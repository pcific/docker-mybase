#!/bin/sh
# docker rmi  pcific/mybase:latest
docker rmi -f `docker images pcific/mybase -q`

TSTMP=`date "+%y%m%d%H%M"`
echo $TSTMP 
docker build -t pcific/mybase:$TSTMP -f Dockerfile .
docker tag pcific/mybase:$TSTMP pcific/mybase
echo ----------------------------
docker images pcific/mybase
echo ----------------------------

