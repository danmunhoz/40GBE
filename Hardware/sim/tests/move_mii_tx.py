#!/usr/bin/python3

##############################################################
## ESTE SCRIPT MOVE O ARQUIVO DE ENTRADA PARA O DIRETORIO
## DO CENARIO CORRESPONDENTE
##############################################################

import os
import sys
import shutil

###############################################
#### DEFINIR CAMINHO DO PROJETO
string = "/home/rafasperb/Documentos"
###############################################

x=0

x = sys.argv[1]

if (x == '0'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")

if (x == '1'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")

if (x == '2'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc2")

if (x == '3'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc3")

if (x == '4'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc4")

if (x == '5'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc5")

if (x == '6'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc6")

if (x == '7'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc7")

if (x == '8'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc8")

if (x == '9'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc9")

if (x == '10'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc10")

if (x == '11'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc11")

if (x == '12'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc12")

if (x == '13'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc13")

if (x == '14'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc14")

if (x == '15'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc15")

if (x == '16'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc16")
