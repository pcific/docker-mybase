#!/bin/sh
docker run --rm -it --hostname mybase -v `pwd`:/vms  pcific/mybase bash

