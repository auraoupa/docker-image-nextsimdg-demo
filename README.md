# Creation of a docker image for nextsimdg


I will use repo2docker github workflow and quay.io to create and host the docker image that will be used to run nextsimdg following [this 2i2c tutorial](https://docs.2i2c.org/en/latest/admin/howto/environment/hub-user-image-template-guide.html) and [that tutorial](https://github.com/jupyterhub/repo2docker-action#push-repo2docker-image-to-quayio).

The modifications of the Dockerfile are done in a dedicated branch, then a pull request is created so that it will trigger a binder image. When it is ready, the pull request is merge and that triggers the creation of the docker image on quay.io.

Then you have to check on https://quay.io/repository/auraoupa/nextsimdg-demo-meeting?tab=tags, the newest tag that has been created, you click and the download icon (fetch the tag), select docker pull by tag and the command ```docker pull quay.io/auraoupa/nextsimdg-demo-meeting:f1b93ce58bab``` for instance is generated.

You can test the docker with binder each time you do a pull request : https://mybinder.org/v2/gh/auraoupa/docker-image-nextsimdg-demo/notebook2

To add the notebook layer, I followed [jupyter's documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/) and read [some images dockerfile](https://github.com/jupyter/docker-stacks)

With your local instance of docker you can download the docker image with the command and then you run it with ```docker exec -it d63b7e4998665547be7127449db7963e40c65efdcaa2bb08c005d9b2acc7f9e5 /bin/sh``` (get the command from docker desktop)

When a notebook interface is deployed do :
  - docker run -p 10000:8888 quay.io/auraoupa/nextsimdg-demo-meeting:437f95b1f18c
  - open the jupyterlab. with http://127.0.0.1:10000/lab?token=282834470c5bb5b1175caef0d3457ac9c103df4a2b356b4b


# Material for the cloud demo at SASIP Meeting, June 2023
Some important ressources :

 - la documentation pour NOVA@GRICAD : https://gricad-doc.univ-grenoble-alpes.fr/nova/
 - Interface web du projet : https://gricad-doc.univ-grenoble-alpes.fr/nova/
 - where to manage the project : https://gricad-gitlab.univ-grenoble-alpes.fr/OSUG/DC/sasip-hub
 - if we want to change the docker image : modify https://gricad-gitlab.univ-grenoble-alpes.fr/OSUG/DC/sasip-hub/-/blob/main/config/sasiphub-config.yml, it will be propagated in a few minutes
 - The cloud is accessible here : https://sasip-01-server-001.osug.fr/
