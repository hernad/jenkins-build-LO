#!/bin/bash

./prepare_build.sh

[ -f LO.tar.gz ] && rm LO.tar.gz

vagrant --version
vagrant up
vagrant provision
vagrant halt


if [ ! -f LO.tar.gz ] ; then
   echo "LO.tar.gz not created ?!"
   exit 1
fi


