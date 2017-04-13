#!/bin/bash

SRC=/home/docker/data_core_base_windows.vmdk
DST=data_LO-build.vdi

if [ ! -f $DST ] ;  then
  /opt/VirtualBox/VBoxManage clonemedium $SRC $DST
else
   echo "$DST already exists"
fi

