#!/bin/sh
cd ~/docker/etracs && docker-compose down

cd ~/docker/local-market && docker-compose down

cd ~/docker/gdx-client && docker-compose down

cd ~ && docker system prune -f
