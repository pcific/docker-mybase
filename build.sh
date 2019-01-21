#!/bin/sh
TSTMP=`date "+%y%m%d%H%M"`
echo $TSTMP > tstmp.tmp
docker build -t pcific/mybase:$TSTMP -f Dockerfile .
docker tag pcific/mybase:$TSTMP pcific/mybase
