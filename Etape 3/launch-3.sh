#!/bin/bash

mkdir ../"Etape 3"
cp -r * ../"Etape 3"
cd ../"Etape 3"

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi -f $(docker images -aq)

vim docker-compose.xml

docker compose up -d