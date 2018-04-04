#!/bin/sh
cd ../../../../
cp -r 40GBE 40GBE_1
./40GBE_1/Hardware/sim/tests/load_dump.sh
./40GBE_1/Hardware/sim/tests/script.sh 1
