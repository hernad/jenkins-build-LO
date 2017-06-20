#!/bin/bash

SSH_DOWNLOAD_SERVER=docker@192.168.168.171

DOWNLOADS_DIR=/data_0/f18-downloads_0/downloads.bring.out.ba/www/files/

./prepare_build.sh


RUNNINGVM=`VBoxManage list runningvms | grep LO-linux-i386 | awk '{ print $2 }'`
if [ ! -z "$RUNNINGVM" ] ; then
  VBoxManage controlvm $RUNNINGVM poweroff
  VBoxManage unregistervm $RUNNINGVM --delete
fi

vagrant --version
vagrant up --provision
vagrant halt

