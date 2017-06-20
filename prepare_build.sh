#!/bin/bash

PATH=/opt/VirtualBox:$PATH

WORKSPACE=LO-windows
DATA_HDD_BASE=~/data_core_base_windows.vmdk
DATA_HDD=data.vmdk
DATA_HDD_FORMAT=VMDK

if [ ! -f $DATA_HDD ] ; then

  VM=`VBoxManage list vms | grep ^\"${WORKSPACE}_default_ | tail -1 | awk '{print $2}'`
  if [ -n "$VM" ] ; then
    echo "erasing old VM $VM"
    VBoxManage unregistervm $VM --delete
  else
    echo "no old VM LO-windows"
  fi

  HDD=`VBoxManage list hdds -l | grep "Location.*workspace/${WORKSPACE}/${DATA_HDD}" -B7 | grep "^UUID:" | awk '{print $2}'`
  if [ -n "$HDD" ] ; then
     echo "erasing old HDD"
     VBoxManage closemedium $HDD --delete
  else
     echo "no old HDD ${WORKSPACE}/$DATA_HDD"
  fi

fi

[ -f $DATA_HDD_BASE ]  || VBoxManage createmedium --size 20000 --format $DATA_HDD_FORMAT --filename $DATA_HDD_BASE

[ -f data.vdi ] || VBoxManage clonemedium $DATA_HDD_BASE $DATA_HDD
