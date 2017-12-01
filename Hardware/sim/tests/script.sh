#!/bin/sh
#!/usr/bin/python3

###############################################
## LIMPA OS ARQUIVOS DE DUMP DOS CENÁRIO

./cleaner.sh

###############################################
## SC1 ########################################

python change_dump.py 1
cd ..
module load modelsim
vsim -do run.do -c
vsim -do run.do -c
cd tests
python move_dump.py 1

###############################################
## SC2 ########################################

python change_dump.py 2
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python move_dump.py 2

###############################################
## SC3 ########################################

python change_dump.py 3
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python move_dump.py 3

###############################################
## SC4 ########################################

python change_dump.py 4
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python move_dump.py 4

###############################################
## SC5 ########################################

python change_dump.py 5
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python move_dump.py 5

###############################################
## SC6 ########################################

python change_dump.py 6
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python move_dump.py 6

###############################################
## SC7 ########################################

python change_dump.py 7
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python move_dump.py 7

###############################################
## SC8 ########################################

python change_dump.py 8
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python move_dump.py 8

###############################################
## COMPARACAO DOS ARQUIVOS E VALIDACAO ########

python clean_dump_tx.py
python clean_dump_fifo.py
python comparador.py
