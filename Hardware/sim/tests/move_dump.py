#!/usr/bin/python3

import os
import sys
import shutil

###############################################
#### DEFINIR CAMINHO DO PROJETO
string = "/home/rafasperb/Documentos"
###############################################

x=0

x = sys.argv[1]

if (x == '1'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc1")

if (x == '2'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc2")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc2")


if (x == '3'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc3")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc3")


if (x == '4'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc4")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc4")


if (x == '5'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc5")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc5")


if (x == '6'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc6")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc6")


if (x == '7'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc7")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc7")


if (x == '8'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc8")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc8")
