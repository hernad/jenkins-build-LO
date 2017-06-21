#!/bin/bash

echo greenbox path
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/bin:/usr/sbin
#export PATH=/opt/x11/bin:/opt/vim/bin
export PATH=$PATH:/opt/vagrant/bin
export PATH=$PATH:/opt/java/bin:
export PATH=$PATH:/opt/green/bin

LO_TAR_GZ=LO_Windows_5-3.tar.gz

uname -a
echo pwd=`pwd`
#cd jenkins-build-LO

./prepare_build.sh

[ -f $LO_TAR_GZ ] && rm $LO_TAR_GZ

vagrant --version
vagrant up
vagrant provision
vagrant halt


if [ ! -f $LO_TAR_GZ ] ; then
   echo "$LO_TAR_GZ not created ?!"
   exit 1
fi

