#!/usr/bin/python3

##############################################################
## ESTE SCRIPT MOVE O ARQUIVO DE ENTRADA DO CENARIO
## PARA A PASTA DE SIMULACAO
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
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/tb_xgt4.vhd", string+"/40GBE/Hardware/sim/")

if (x == '1'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc1/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '2'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc2")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc2/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")


if (x == '3'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc3")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc3/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")


if (x == '4'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc4")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc4/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")


if (x == '5'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc5")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc5/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")


if (x == '6'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc6")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc6/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")


if (x == '7'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc7")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc7/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")


if (x == '8'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc8")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc8/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '9'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc9")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc9/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '10'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc10")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc10/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '11'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc11")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc11/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '12'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc12")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc12/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '13'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc13")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc13/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '14'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc14")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc14/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '15'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc15")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc15/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == '16'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc16")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc16/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")
