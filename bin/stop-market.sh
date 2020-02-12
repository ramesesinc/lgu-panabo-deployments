#!/bin/sh
RUN_DIR=`pwd`
cd ../local-market
docker-compose down
docker system prune -f
cd $RUN_DIR
