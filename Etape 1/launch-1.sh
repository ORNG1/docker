#!/bin/bash

# Création de l'image nginx 
docker image build -f Dockerfile-nginx -t http:orng .

# Création de l'image php
docker image build -f Dockerfile-php -t php:orng .

# Création du réseau tp3-network pour la communication des conteneurs en interne
docker network create tp3-network

# Lancement du conteneur http
docker container run --name "http" -d  --network tp3-network -p 8080:80 -v $PWD/src:/app:ro nginx

#Lancement du conteneur script
docker container run --name "script" -d  --network tp3-network -v $PWD/src:/app php:orng

# Copie du fichier default.conf sur le conteneur nginx sur le répetoire local
docker container cp http:/etc/nginx/conf.d/default.conf ./config/default.conf

#Arrêt et relance du conteneur http avec default.conf local monté
docker stop http
docker rm http
docker container run --name "http" -d  --network tp3-network -p 8080:80 -v $PWD/src:/app -v $PWD/config/default.conf:/etc/nginx/conf.d/default.conf http:orng
