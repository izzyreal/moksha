#!/bin/bash

VM_NAME="Moksha"

VM_STATE=$(VBoxManage showvminfo $VM_NAME --machinereadable | grep VMState= | cut -d'=' -f2 | tr -d '"')
if [ "$VM_STATE" = "running" ]; then
  VBoxManage controlvm $VM_NAME poweroff
  sleep 5
fi

VBoxManage controlvm $VM_NAME poweroff

VBoxManage unregistervm $VM_NAME --delete

rm "${VM_NAME}.vdi"

