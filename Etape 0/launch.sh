#!/bin/bash

mkdir docker-tp3
echo "# docker" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/ORNG1/docker.git
git push -u origin main