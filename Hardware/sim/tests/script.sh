#!/bin/sh
#!/usr/bin/python3

###############################################
## ESTE SCRIPT SIMULA TODOS OS CENARIOS DE TESTES

###############################################
## LIMPA OS ARQUIVOS DE DUMP DOS CENARIO

./cleaner.sh
python config.py 0
python config.py pkt
python config.py ipg_min

###############################################
## SC1 ########################################

python config.py mt1
python config.py sc1
cd ..
module load modelsim
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo1

###############################################
## SC2 ########################################

python config.py mt2
python config.py sc2
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo2

##############################################
# SC3 ########################################

python config.py mt3
python config.py sc3
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo3

###############################################
## SC4 ########################################

python config.py mt4
python config.py sc4
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo4

###############################################
## SC5 ########################################

python config.py mt5
python config.py sc5
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo5

###############################################
## SC6 ########################################

python config.py mt6
python config.py sc6
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo6

###############################################
## SC7 ########################################

python config.py mt7
python config.py sc7
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo7

###############################################
## SC8 ########################################

python config.py mt8
python config.py sc8
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo8

###############################################
## ALTERA O IPG ###############################

python config.py ipg

###############################################
## SC9 #######################################

python config.py mt9
python config.py sc1
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo9

###############################################
## SC10 #######################################

python config.py mt10
python config.py sc2
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo10

###############################################
## SC11 #######################################

python config.py mt11
python config.py sc3
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo11

###############################################
## SC12 #######################################

python config.py mt12
python config.py sc4
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo12

###############################################
## SC13 #######################################

python config.py mt13
python config.py sc5
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo13

###############################################
## SC14 #######################################

python config.py mt14
python config.py sc6
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo14

###############################################
## SC15 #######################################

python config.py mt15
python config.py sc7
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo15

###############################################
## SC16 #######################################

python config.py mt16
python config.py sc8
cd ..
vsim -do run.do -c
vsim -do run.do -c
cd tests
python config.py mo16

python config.py mt0
###############################################
## COMPARACAO DOS ARQUIVOS E VALIDACAO ########

python clean_dump_tx.py
python clean_dump_fifo.py
python fifotx_to_hex.py
python comparador.py
