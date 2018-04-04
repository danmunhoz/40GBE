#!/bin/sh
#!/usr/bin/python3

###############################################
## ESTE SCRIPT CRIA TODOS OS ARQUIVOS DE ENTRADA
## DE TODOS OS CENARIOS.

###############################################
## LIMPA OS ARQUIVOS DE DUMP DOS CENARIO

rm -rf sc*/*
rm dump_mii_tx.txt

mkdir sc1
mkdir sc2
mkdir sc3
mkdir sc4
mkdir sc5
mkdir sc6
mkdir sc7
mkdir sc8
mkdir sc9
mkdir sc10
mkdir sc11
mkdir sc12
mkdir sc13
mkdir sc14
mkdir sc15
mkdir sc16

python config.py mt0
python config.py pkt
python config.py ipg_min
python config.py order
python config.py skew
cd ..
module load modelsim
cd tests
###############################################
## SC1 ########################################

# python config.py sc1
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts1

# ###############################################
# ## SC2 ########################################
#
# python config.py sc2
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts2
#
# ##############################################
# # SC3 ########################################

python config.py sc3
cd ..
vsim -do run.do -c
cd tests
python config.py mts3

# # ###############################################
# ## SC4 ########################################
#
# python config.py sc4
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts4
#
# ###############################################
# ## SC5 ########################################
#
# python config.py sc5
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts5
#
# ###############################################
# ## SC6 ########################################
#
# python config.py sc6
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts6
#
# ###############################################
# ## SC7 ########################################
#
# python config.py sc7
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts7
#
# ###############################################
# ## SC8 ########################################
#
# python config.py sc8
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts8
#
# ###############################################
# ## ALTERA O IPG ###############################
#
python config.py ipg
#
# ###############################################
# ## SC9 ########################################
#
# python config.py sc1
# cd ..
# module load modelsim
# vsim -do run.do -c
# cd tests
# python config.py mts9
#
# ###############################################
# ## SC10 ########################################
#
# python config.py sc2
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts10
#
# ###############################################
# ## SC11 ########################################
#
python config.py sc3
cd ..
vsim -do run.do -c
cd tests
python config.py mts11
#
# ###############################################
# ## SC12 ########################################
#
# python config.py sc4
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts12
#
# ###############################################
# ## SC13 ########################################
#
# python config.py sc5
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts13
#
# ###############################################
# ## SC14 ########################################
#
# python config.py sc6
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts14
#
# ###############################################
# ## SC15 ########################################
#
# python config.py sc7
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts15
#
# ###############################################
# ## SC16 ########################################
#
# python config.py sc8
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts16
#
# ###############################################
./script.sh
