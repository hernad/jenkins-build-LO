#!/bin/bash

SRC=/home/docker/data_core_base_windows.vmdk

if [ ! -f data.vdi ] ;  then
  /opt/VirtualBox/VBoxManage clonemedium $SRC data_LO-build.vdi
else
	echo "data_LO-build.vdi already exists"
fi

