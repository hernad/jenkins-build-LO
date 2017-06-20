#!/bin/bash

echo greenbox path
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/bin:/usr/sbin
#export PATH=/opt/x11/bin:/opt/vim/bin
export PATH=$PATH:/opt/vagrant/bin
export PATH=$PATH:/opt/java/bin:
export PATH=$PATH:/opt/green/bin

uname -a
echo pwd=`pwd`
#cd jenkins-build-LO

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

