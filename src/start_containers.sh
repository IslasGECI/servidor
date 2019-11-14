#!/usr/bin/env bash
#
# Corre los contenedores de Docker del servidor islasgeci.org
#
# Variables:
PATH_TO_REPOS=${HOME}/repositorios
# Actualiza imágenes:
docker pull islasgeci/gatos-trampas:latest
docker pull islasgeci/homepage:latest
docker pull islasgeci/jupyter:latest
docker pull islasgeci/nerd_demo:latest
docker pull islasgeci/tablero_api:latest
docker pull islasgeci/tablero_front:latest
docker pull islasgeci/tag_docker_images:latest
docker pull islasgeci/tamanio-poblacional-aves-marinas_api-datos:latest
docker pull islasgeci/tamanio-poblacional-aves-marinas_api-lambdas:latest
docker pull islasgeci/tamanio-poblacional-aves-marinas_front:latest
docker pull rocker/tidyverse:latest
# Corre contenedores con volumen:
docker run --detach                     --rm --volume secrets_vol:/.secrets --volume /var/run/docker.sock:/var/run/docker.sock islasgeci/tag_docker_images:latest
docker run --detach --publish  251:80   --rm --volume gatos-trampas_vol:/go/src/bitbucket.org/IslasGECI/gatos-trampas islasgeci/gatos-trampas:latest ./mapa-gatos
docker run --detach --publish  500:5000 --rm --volume tablero_api_vol:/workdir islasgeci/tablero_api:latest
docker run --detach --publish 8888:8888 --rm --volume jupyter_vol:/workdir islasgeci/jupyter:latest
# Corre contenedores sin volumen:
docker run --detach --publish   80:80   --rm islasgeci/homepage:latest
docker run --detach --publish  850:80   --rm islasgeci/tamanio-poblacional-aves-marinas_front:latest
docker run --detach --publish  851:4000 --rm islasgeci/tamanio-poblacional-aves-marinas_api-datos:latest
docker run --detach --publish  852:5000 --rm islasgeci/tamanio-poblacional-aves-marinas_api-lambdas:latest
docker run --detach --publish 5000:80   --rm islasgeci/tablero_front:latest
docker run --detach --publish 8080:8888 --rm islasgeci/nerd_demo:latest
docker run --detach --publish 8787:8787 --rm --env PASSWORD=4705 rocker/tidyverse:latest
