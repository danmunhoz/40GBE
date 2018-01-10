#!/usr/bin/python3
##############################################################
## ESTE SCRIPT CONFIGURA O TESTE
##############################################################

#### DEFINIR CAMINHO DO PROJETO /40GBE #######################
string = "/home/rafasperb/Documentos"
##############################################################

#### DEFINIR QUANTIDADE DE PACOTES ###########################
pkt = 26
##############################################################

#### DEFINIR IPG #############################################
ipg = 32
##############################################################

#### DEFINIR IPG #############################################
#### DEFINE A ORDEM DAS FIBRAS, 0 = ORDEM SEQUENCIAL, 1 = RANDOM
order = 0
##############################################################

#### DEFINIR O SKEW ##########################################
#### SKEW MINIMO = RESET = 40 ################################
skew_0=40
skew_1=40
skew_2=40
skew_3=40
##############################################################

#### DEFINIR TAMANHOS DE PAYLOAD ENTRE 0x00 e 0xBC ###########
sc1='0x00'
sc2='0x0E'
sc3='0x1E'
sc4='0x3E'
sc5='0x5E'
sc6='0x7E'
sc7='0x9E'
sc8='0xBC'
##############################################################

import os
import sys
import shutil
x=0
x = sys.argv[1]

##############################################################
#### FUNCOES PARA MANIPULACAO DE ARQUIVOS ####################
##############################################################

def encontrar_string(path,string):
    global n
    with open(path,'r') as f:
        texto=f.readlines()
    for i in texto:
        if string in i:
            n = texto.index(i)
            n=n+1
            return
    print('String nao encontrada')

def alterar_linha(path,index_linha,nova_linha):
    with open(path,'r') as f:
        texto=f.readlines()
    with open(path,'w') as f:
        for i in texto:
            if texto.index(i)==index_linha:
                f.write(nova_linha+'\n')
            else:
                f.write(i)

##############################################################
#### ALTERACOES DE PKT, IPG E PAYLOAD NO TB ##################
##############################################################
if (x == 'pkt'):

    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PKT\n'
    nova_linha = '      for i in 0 to '+str(pkt)+' loop'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if (x == 'ipg_min'):

    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_IPG\n'
    nova_linha = '        wait for 8 ns;'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if (x == 'ipg'):

    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_IPG\n'
    nova_linha = '        wait for '+str(ipg)+' ns;'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if (x == 'order'):

    path = string+'/40GBE/Hardware/sim/fiber.h'
    marcador = '//ORDER\n'
    nova_linha = '#define PICK_RANDOM_ORDER '+str(order)+''

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if (x == 'skew'):

    path = string+'/40GBE/Hardware/sim/fiber.h'
    marcador = '//SKEW_0\n'
    nova_linha = '#define SKEW_0_NS '+str(skew_0)+''

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

    path = string+'/40GBE/Hardware/sim/fiber.h'
    marcador = '//SKEW_1\n'
    nova_linha = '#define SKEW_1_NS '+str(skew_1)+''

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

    path = string+'/40GBE/Hardware/sim/fiber.h'
    marcador = '//SKEW_2\n'
    nova_linha = '#define SKEW_2_NS '+str(skew_2)+''

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

    path = string+'/40GBE/Hardware/sim/fiber.h'
    marcador = '//SKEW_3\n'
    nova_linha = '#define SKEW_3_NS '+str(skew_3)+''

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if (x == 'sc1'):
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PAYLOAD\n'
    nova_linha = '        payload_cycles      => x"000000'+sc1[2:]+'",'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if (x == 'sc2'):
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PAYLOAD\n'
    nova_linha = '        payload_cycles      => x"000000'+sc2[2:]+'",'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if x == 'sc3':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PAYLOAD\n'
    nova_linha = '        payload_cycles      => x"000000'+sc3[2:]+'",'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if x == 'sc4':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PAYLOAD\n'
    nova_linha = '        payload_cycles      => x"000000'+sc4[2:]+'",'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if x == 'sc5':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PAYLOAD\n'
    nova_linha = '        payload_cycles      => x"000000'+sc5[2:]+'",'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if x == 'sc6':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PAYLOAD\n'
    nova_linha = '        payload_cycles      => x"000000'+sc6[2:]+'",'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if x == 'sc7':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PAYLOAD\n'
    nova_linha = '        payload_cycles      => x"000000'+sc7[2:]+'",'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

if x == 'sc8':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    marcador = '--CHANGE_PAYLOAD\n'
    nova_linha = '        payload_cycles      => x"000000'+sc8[2:]+'",'

    encontrar_string(path, marcador)
    alterar_linha(path,n,nova_linha)

##############################################################
#### MOVIMENTACAO DO ARQUIVO DE ENTRADA DO CENARIO PARA SIMULACAO
##############################################################
if (x == 'mt0'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/tb_xgt4.vhd", string+"/40GBE/Hardware/sim/")

if (x == 'mt1'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc1/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt2'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc2")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc2/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt3'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc3")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc3/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt4'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc4")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc4/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt5'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc5")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc5/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt6'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc6")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc6/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt7'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc7")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc7/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt8'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc8")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc8/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt9'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc9")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc9/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt10'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc10")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc10/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt11'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc11")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc11/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt12'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc12")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc12/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt13'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc13")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc13/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt14'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc14")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc14/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt15'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc15")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc15/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

if (x == 'mt16'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc16")
    shutil.copy2(string+"/40GBE/Hardware/sim/tests/sc16/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/")

##############################################################
#### MOVIMENTACAO DO ARQUIVO DE SAIDA DA SIMULACAO PARA O CENARIO
##############################################################

if (x == 'mo1'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc1")

if (x == 'mo2'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc2")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc2")

if (x == 'mo3'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc3")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc3")

if (x == 'mo4'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc4")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc4")

if (x == 'mo5'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc5")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc5")

if (x == 'mo6'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc6")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc6")

if (x == 'mo7'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc7")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc7")

if (x == 'mo8'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc8")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc8")

if (x == 'mo9'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc9")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc9")

if (x == 'mo10'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc10")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc10")

if (x == 'mo11'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc11")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc11")

if (x == 'mo12'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc12")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc12")

if (x == 'mo13'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc13")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc13")

if (x == 'mo14'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc14")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc14")

if (x == 'mo15'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc15")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc15")

if (x == 'mo16'):
    #shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc16")
    shutil.move(string+"/40GBE/Hardware/sim/dump_output.txt", string+"/40GBE/Hardware/sim/tests/sc16")

##############################################################
#### MOVIMENTACAO DO ARQUIVO DE ENTRADA DA SIMULACAO PARA O CENARIO
##############################################################

if (x == 'mts1'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc1")

if (x == 'mts2'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc2")

if (x == 'mts3'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc3")

if (x == 'mts4'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc4")

if (x == 'mts5'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc5")

if (x == 'mts6'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc6")

if (x == 'mts7'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc7")

if (x == 'mts8'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc8")

if (x == 'mts9'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc9")

if (x == 'mts10'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc10")

if (x == 'mts11'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc11")

if (x == 'mts12'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc12")

if (x == 'mts13'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc13")

if (x == 'mts14'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc14")

if (x == 'mts15'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc15")

if (x == 'mts16'):
    shutil.move(string+"/40GBE/Hardware/sim/dump_mii_tx.txt", string+"/40GBE/Hardware/sim/tests/sc16")
