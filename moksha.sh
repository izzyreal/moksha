#!/bin/bash

VM_NAME="Moksha"

if [ -z "$DEBIAN_ISO_PATH" ]; then
  echo "Error: DEBIAN_ISO_PATH is not set. Exiting."
  exit 1
fi

if [ ! -f "$DEBIAN_ISO_PATH" ]; then
  echo "Error: ISO file does not exist at $DEBIAN_ISO_PATH. Exiting."
  exit 1
fi

if [ -z "$DEBIAN_VM_PATH" ]; then
  echo "Error: DEBIAN_VM_PATH is not set. Exiting."
  exit 1
fi

if [ ! -d "$DEBIAN_VM_PATH" ]; then
  echo "Error: Directory does not exist at $DEBIAN_VM_PATH. Exiting."
  exit 1
fi

VBoxManage createvm --name $VM_NAME --ostype "Debian_64" --register

VBoxManage modifyvm $VM_NAME --memory 1024 --vram 16

VBoxManage createhd --filename "${VM_NAME}.vdi" --size 20480

VBoxManage storagectl $VM_NAME --name "IDE Controller" --add ide
VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium "${DEBIAN_VM_PATH}/${VM_NAME}.vdi"

VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $DEBIAN_ISO_PATH

VBoxManage modifyvm $VM_NAME --nic1 nat

VBoxManage startvm $VM_NAME
