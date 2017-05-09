#!/bin/bash

#Script to rescan the pci bar 
#Author Walter Lau

NETSUME_PCI=`lspci |grep "Xilinx" | awk '{print $1}'`
pci_id=${NETSUME_PCI%:*}

echo 1 > /sys/bus/pci/devices/0000\:$pci_id\:00.0/remove
sleep 1
echo 1 > /sys/bus/pci/devices/0000\:00\:${pci_id}.0/rescan
sleep 1
echo 1 > /sys/bus/pci/devices/0000\:$pci_id\:00.0/enable

chown -R www-data /sys/bus/pci/devices/0000\:$pci_id\:00.0/*
