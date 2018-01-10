#!/bin/sh
#!/usr/bin/python3

###############################################
## ESTE SCRIPT CRIA TODOS OS ARQUIVOS DE ENTRADA
## DE TODOS OS CENARIOS.

###############################################
## LIMPA OS ARQUIVOS DE DUMP DOS CENARIO

cd sc1
rm -rf *
cd ..
cd sc2
rm -rf *
cd ..
cd sc3
rm -rf *
cd ..
cd sc4
rm -rf *
cd ..
cd sc5
rm -rf *
cd ..
cd sc6
rm -rf *
cd ..
cd sc7
rm -rf *
cd ..
cd sc8
rm -rf *
cd ..
cd sc9
rm -rf *
cd ..
cd sc10
rm -rf *
cd ..
cd sc11
rm -rf *
cd ..
cd sc12
rm -rf *
cd ..
cd sc13
rm -rf *
cd ..
cd sc14
rm -rf *
cd ..
cd sc15
rm -rf *
cd ..
cd sc16
rm -rf *
cd ..
cd ..
rm dump_mii_tx.txt
cd tests

python config.py mt0
python config.py pkt
python config.py ipg_min
python config.py order
python config.py skew

###############################################
## SC1 ########################################

python config.py sc1
cd ..
module load modelsim
vsim -do run.do -c
cd tests
python config.py mts1

###############################################
## SC2 ########################################

python config.py sc2
cd ..
vsim -do run.do -c
cd tests
python config.py mts2

##############################################
# SC3 ########################################

python config.py sc3
cd ..
vsim -do run.do -c
cd tests
python config.py mts3

###############################################
## SC4 ########################################

python config.py sc4
cd ..
vsim -do run.do -c
cd tests
python config.py mts4

###############################################
## SC5 ########################################

python config.py sc5
cd ..
vsim -do run.do -c
cd tests
python config.py mts5

###############################################
## SC6 ########################################

python config.py sc6
cd ..
vsim -do run.do -c
cd tests
python config.py mts6

###############################################
## SC7 ########################################

python config.py sc7
cd ..
vsim -do run.do -c
cd tests
python config.py mts7

###############################################
## SC8 ########################################

python config.py sc8
cd ..
vsim -do run.do -c
cd tests
python config.py mts8

###############################################
## ALTERA O IPG ###############################

python config.py ipg

###############################################
## SC9 ########################################

python config.py sc1
cd ..
module load modelsim
vsim -do run.do -c
cd tests
python config.py mts9

###############################################
## SC10 ########################################

python config.py sc2
cd ..
vsim -do run.do -c
cd tests
python config.py mts10

###############################################
## SC11 ########################################

python config.py sc3
cd ..
vsim -do run.do -c
cd tests
python config.py mts11

###############################################
## SC12 ########################################

python config.py sc4
cd ..
vsim -do run.do -c
cd tests
python config.py mts12

###############################################
## SC13 ########################################

python config.py sc5
cd ..
vsim -do run.do -c
cd tests
python config.py mts13

###############################################
## SC14 ########################################

python config.py sc6
cd ..
vsim -do run.do -c
cd tests
python config.py mts14

###############################################
## SC15 ########################################

python config.py sc7
cd ..
vsim -do run.do -c
cd tests
python config.py mts15

###############################################
## SC16 ########################################

python config.py sc8
cd ..
vsim -do run.do -c
cd tests
python config.py mts16

###############################################
