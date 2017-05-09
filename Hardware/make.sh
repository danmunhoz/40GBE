#!/bin/sh
set -e

xauth add $(xauth -f ~root/.Xauthority list|tail -1)
source /opt/Xilinx/Vivado/2015.2/settings64.sh
export XILINXD_LICENSE_FILE=2100@kriti.inf.pucrs.br
make debug