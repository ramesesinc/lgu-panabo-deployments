#!/bin/sh
cd ~/docker/local-market
docker-compose down
docker system prune -f
sleep 2
docker-compose up -d
docker-compose logs -f local-market-server
cd ~
