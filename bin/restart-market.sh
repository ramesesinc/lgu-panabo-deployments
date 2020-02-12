#!/bin/sh
RUN_DIR=`pwd`
cd ../local-market
docker-compose down
docker system prune -f
sleep 1
docker-compose up -d
docker-compose logs -f local-market-server
cd $RUN_DIR
