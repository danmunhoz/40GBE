#!/usr/bin/python3

##############################################################
## ESTE SCRIPT ALTERA OS VALORES DE PAYLOAD DO TB
##############################################################

import os
import sys

###############################################
#### DEFINIR CAMINHO DO PROJETO
string = "/home/rafasperb/Documentos"
###############################################

x=0
x = sys.argv[1]

def encontrar_string(path,string):
    global n
    with open(path,'r') as f:
        texto=f.readlines()
    for i in texto:
        if string in i:
            n = texto.index(i)
            print(texto.index(i))
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

if (x == '9'):
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        wait for 5 ns;\n'
    nova_linha = '        wait for 15 ns;'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if (x == '99'):
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        wait for 15 ns;\n'
    nova_linha = '        wait for 5 ns;'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)


if (x == '1'):
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"00000006",\n'
    nova_linha = '        payload_cycles      => x"00000006",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if (x == '11'):
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"000000BC",\n'
    nova_linha = '        payload_cycles      => x"00000006",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if (x == '2'):
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"00000006",\n'
    nova_linha = '        payload_cycles      => x"0000000E",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if x == '3':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"0000000E",\n'
    nova_linha = '        payload_cycles      => x"0000001E",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if x == '4':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"0000001E",\n'
    nova_linha = '        payload_cycles      => x"0000003E",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if x == '5':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"0000003E",\n'
    nova_linha = '        payload_cycles      => x"0000005E",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if x == '6':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"0000005E",\n'
    nova_linha = '        payload_cycles      => x"0000007E",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if x == '7':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"0000007E",\n'
    nova_linha = '        payload_cycles      => x"0000009E",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)

if x == '8':
    path = string+'/40GBE/Hardware/sim/tb_xgt4.vhd'
    string = '        payload_cycles      => x"0000009E",\n'
    nova_linha = '        payload_cycles      => x"000000BC",'

    encontrar_string(path, string)
    alterar_linha(path,n,nova_linha)
