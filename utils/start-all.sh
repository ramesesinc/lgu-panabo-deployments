#!/bin/sh
docker system prune -f

cd ~/docker/etracs && docker-compose up -d

sleep 1
cd ~/docker/local-market && docker-compose up -d

sleep 2
cd ~/docker/gdx-client && docker-compose up -d

cd ~
