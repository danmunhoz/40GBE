#!/bin/sh
#!/usr/bin/python3

###############################################
## ESTE SCRIPT CRIA TODOS OS ARQUIVOS DE ENTRADA
## DE TODOS OS CENARIOS.

###############################################
## LIMPA OS ARQUIVOS DE DUMP DOS CENARIO

./cleaner.sh
python move_tx.py 0
###############################################
## SC1 ########################################

python change_dump.py 1
cd ..
module load modelsim
vsim -do run.do -c
cd tests
python move_mii_tx.py 1

###############################################
## SC2 ########################################

python change_dump.py 2
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 2

###############################################
## SC3 ########################################

python change_dump.py 3
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 3

###############################################
## SC4 ########################################

python change_dump.py 4
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 4

###############################################
## SC5 ########################################

python change_dump.py 5
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 5

###############################################
## SC6 ########################################

python change_dump.py 6
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 6

###############################################
## SC7 ########################################

python change_dump.py 7
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 7

###############################################
## SC8 ########################################

python change_dump.py 8
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 8

###############################################
## ALTERA O IPG ###############################

python change_dump.py 9

###############################################
## SC9 ########################################

python change_dump.py 11
cd ..
module load modelsim
vsim -do run.do -c
cd tests
python move_mii_tx.py 9

###############################################
## SC10 ########################################

python change_dump.py 2
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 10

###############################################
## SC11 ########################################

python change_dump.py 3
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 11

###############################################
## SC12 ########################################

python change_dump.py 4
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 12

###############################################
## SC13 ########################################

python change_dump.py 5
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 13

###############################################
## SC14 ########################################

python change_dump.py 6
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 14

###############################################
## SC15 ########################################

python change_dump.py 7
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 15

###############################################
## SC16 ########################################

python change_dump.py 8
cd ..
vsim -do run.do -c
cd tests
python move_mii_tx.py 16

###############################################
