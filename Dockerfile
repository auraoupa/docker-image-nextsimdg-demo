#
# Build container
#

FROM jupyter/base-notebook:2023-05-15 as build

# Maximum jobs for make
ARG MAX_JOBS=4

USER root

RUN apt-get -y -q update \
 && apt-get -y -q upgrade \
 && apt-get -y -q install \
	build-essential \
	cmake \
	git \
	libboost-log1.74-dev \
	libboost-program-options1.74-dev \
	libeigen3-dev \
	libnetcdf-c++4-dev \
	netcdf-bin \
 && rm -rf /var/lib/apt/lists/*

# Catch2 compilation
WORKDIR /build
RUN git clone -b v2.x https://github.com/catchorg/Catch2.git \
 && cd Catch2 \
 && cmake -Bbuild -H. -DBUILD_TESTING=OFF \
 && cmake --build build/ --target install

# Get nextsimdg source from the dedicated branch for test case
WORKDIR /build
RUN git clone -b issue194_topaz_era https://github.com/nextsimdg/nextsimdg.git \
 && cd nextsimdg \
 && cmake -B build/ \
 && make -j ${MAX_JOBS} -C build

#
# Final container
#

FROM jupyter/base-notebook:2023-05-15

# Disable announcements
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

USER root

RUN apt-get -y -q update \
 && apt-get -y -q upgrade \
 && apt-get -y -q install \
	bash-completion \
	libnetcdf-c++4-1 \
	libboost-log1.74 \
	libboost-program-options1.74 \
	netcdf-bin \
        vim \
	wget \
 && rm -rf /var/lib/apt/lists/*

# Copy from build container
COPY --from=build /build/nextsimdg/build/ /opt/nextsimdg
RUN  ln -s /opt/nextsimdg/nextsim /usr/local/bin/

# Adding necessary group for SUMMER fs
RUN groupadd -g 10128 pr-sasip \
 && usermod -g 10128 $NB_USER

USER $NB_USER
