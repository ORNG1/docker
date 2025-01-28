#!/bin/bash

# Arrêt et suppression de tous les conteneurs + suppression de toutes les images
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi -f $(docker images -aq)

cd ..
mkdir "Etape 2"
cd "Etape 2"
docker image build -f Dockerfile-nginx -t http:orng .
docker image build -f Dockerfile-php -t php:orng .
docker image build -f Dockerfile-mysql -t mariadb:orng .

docker container run --name "http" -d  --network tp3-network -p 8080:80 -v $PWD/src:/app -v $PWD/config/default.conf:/etc/nginx/conf.d/default.conf http:orng
docker container run --name "script" -d  --network tp3-network -v $PWD/src:/app php:orng
docker container run -d --name "data" -d --network tp3-network -e MYSQL_ROOT_PASSWORD=root -v $PWD/db/create.sql:/docker-entrypoint-initdb.d/create.sql mariadb:orng

docker container stop script
docker container rm script
docker container stop http
docker container rm http

docker container run --name "http" -d  --network tp3-network -p 8080:80 -v $PWD/src:/app -v $PWD/config/default.conf:/etc/nginx/conf.d/default.conf http:orng
docker container run --name "script" -d  --network tp3-network -v $PWD/src:/app php:orng