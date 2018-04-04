#!/bin/sh
#!/usr/bin/python3

###############################################
## ESTE SCRIPT SIMULA TODOS OS CENARIOS DE TESTES

###############################################
## LIMPA OS ARQUIVOS DE DUMP DOS CENARIO

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
# ###############################################
# ## SC1 ########################################
# ./cleaner.sh 1
#
# python config.py sc1
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts1
#
# python config.py mt1
# python config.py sc1
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo1
# python clean_dump.py tx 1
# python clean_dump.py fifo 1
# python clean_dump.py hex 1
# python comparador.py 1
# ###############################################
# ## SC2 ########################################
# ./cleaner.sh 2
#
# python config.py sc2
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts2
#
# python config.py mt2
# python config.py sc2
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo2
# python clean_dump.py tx 2
# python clean_dump.py fifo 2
# python clean_dump.py hex 2
# python comparador.py 2
# # # # #############################################
# # # # SC3 ########################################
./cleaner.sh 3

python config.py sc3
cd ..
vsim -do run.do -c
cd tests
python config.py mts3

python config.py mt3
python config.py sc3
cd ..
vsim -do run.do -c
cd tests
python config.py mo3
python clean_dump.py tx 3
python clean_dump.py fifo 3
python clean_dump.py hex 3
python comparador.py 3
# # ##############################################
# # # SC4 ########################################
# ./cleaner.sh 4
#
# python config.py sc4
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts4
#
# python config.py mt4
# python config.py sc4
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo4
# python clean_dump.py tx 4
# python clean_dump.py fifo 4
# python clean_dump.py hex 4
# python comparador.py 4
# # # ###############################################
# # # ## SC5 ########################################
# ./cleaner.sh 5
#
# python config.py sc5
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts5
#
# python config.py mt5
# python config.py sc5
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo5
# python clean_dump.py tx 5
# python clean_dump.py fifo 5
# python clean_dump.py hex 5
# python comparador.py 5
# # # ###############################################
# # # ## SC6 ########################################
# ./cleaner.sh 6
#
# python config.py sc6
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts6
#
# python config.py mt6
# python config.py sc6
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo6
# python clean_dump.py tx 6
# python clean_dump.py fifo 6
# python clean_dump.py hex 6
# python comparador.py 6
# # # ###############################################
# # # ## SC7 ########################################
# ./cleaner.sh 7
#
# python config.py sc7
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts7
#
# python config.py mt7
# python config.py sc7
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo7
# python clean_dump.py tx 7
# python clean_dump.py fifo 7
# python clean_dump.py hex 7
# python comparador.py 7
# # # ###############################################
# # # ## SC8 ########################################
# ./cleaner.sh 8
#
# python config.py sc8
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts8
#
# python config.py mt8
# python config.py sc8
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo8
# python clean_dump.py tx 8
# python clean_dump.py fifo 8
# python clean_dump.py hex 8
# python comparador.py 8
# # ###############################################
# # ## ALTERA O IPG ###############################
# #
# # python config.py ipg
# #
# # ###############################################
# # ## SC9 #######################################
# ./cleaner.sh 9
#
# python config.py sc9
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts9
#
# python config.py mt9
# python config.py sc1
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo9
# python clean_dump.py tx 9
# python clean_dump.py fifo 9
# python clean_dump.py hex 9
# python comparador.py 9
# # ###############################################
# # ## SC10 #######################################
# ./cleaner.sh 10
#
# python config.py sc10
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts10
#
# python config.py mt10
# python config.py sc2
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo10
# python clean_dump.py tx 10
# python clean_dump.py fifo 10
# python clean_dump.py hex 10
# python comparador.py 10
# # ###############################################
# # ## SC11 #######################################
./cleaner.sh 11

python config.py sc11
cd ..
vsim -do run.do -c
cd tests
python config.py mts11

python config.py mt11
python config.py sc3
cd ..
vsim -do run.do -c
cd tests
python config.py mo11
python clean_dump.py tx 11
python clean_dump.py fifo 11
python clean_dump.py hex 11
python comparador.py 11
# # ###############################################
# # ## SC12 #######################################
# ./cleaner.sh 12
#
# python config.py sc12
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts12
#
# python config.py mt12
# python config.py sc4
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo12
# python clean_dump.py tx 12
# python clean_dump.py fifo 12
# python clean_dump.py hex 12
# python comparador.py 12
# # ###############################################
# # ## SC13 #######################################
# ./cleaner.sh 13
#
# python config.py sc13
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts13
#
# python config.py mt13
# python config.py sc5
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo13
# python clean_dump.py tx 13
# python clean_dump.py fifo 13
# python clean_dump.py hex 13
# python comparador.py 13
# # ###############################################
# # ## SC14 #######################################
# ./cleaner.sh 14
#
# python config.py sc14
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts14
#
# python config.py mt14
# python config.py sc6
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo14
# python clean_dump.py tx 14
# python clean_dump.py fifo 14
# python clean_dump.py hex 14
# python comparador.py 14
# # ###############################################
# # ## SC15 #######################################
# ./cleaner.sh 15
#
# python config.py sc15
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts15
#
# python config.py mt15
# python config.py sc7
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo15
# python clean_dump.py tx 15
# python clean_dump.py fifo 15
# python clean_dump.py hex 15
# python comparador.py 15
# # ###############################################
# # ## SC16 #######################################
# ./cleaner.sh 16
#
# python config.py sc16
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mts16
#
# python config.py mt16
# python config.py sc8
# cd ..
# vsim -do run.do -c
# cd tests
# python config.py mo16
# python clean_dump.py tx 16
# python clean_dump.py fifo 16
# python clean_dump.py hex 16
# python comparador.py 16
