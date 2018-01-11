#!/usr/bin/python3

##############################################################
## ESTE SCRIPT COMPARA BIT A BIT O ARQUIVO DE ENTRADA COM O
## ARQUIVO DE SAIDA
##############################################################

import os
import sys
y = sys.argv[1]
n = y
x=0

##############################################################
############# EXCLUI OS ARQUIVOS DE SINALIZACAO
##############################################################
string = "sc"
string += str(n)
try:
   with open(string+'/PASSOU.txt', 'r') as f:
       os.remove(string+'/PASSOU.txt')
except IOError:
    n=n
    #print u'Arquivo nao encontrado2!'
try:
   with open(string+'/NAO PASSOU.txt', 'r') as f:
       os.remove(string+'/NAO PASSOU.txt')
except IOError:
    n=n
    #print u'Arquivo nao encontrado!'

##############################################################
############# COMPARA OS ARQUIVOS E SINALIZA O RESULTADO EM
############# UM ARQUIVO TXT
##############################################################

string = "sc"
string += str(n)

with open(string+'/cleaned_dump_txhex.txt') as f1:
    str_tx = f1.read()

with open(string+'/cleaned_dump_fifohex.txt') as f2:
    str_fifo = f2.read()

# str_tx = str_tx.replace('\n', '')
# str_fifo = str_fifo.replace('\n', '')


if str_tx[0:] == str_fifo[0:]:
    new_file = open(string+'/PASSOU.txt', 'w')
else:
    new_file = open(string+'/NAO_PASSOU.txt', 'w')

# print('Tamanho Entrada: ',len(str_tx))
# print('Tamanho Saida FIFO: ',len(str_fifo))

# for i in range(len(str_tx)):
#     if str_tx[i] == str_fifo[i]:
#         print('passou')
#     else:
#         print('Nao passou')
#         print(i)
#         print("TX: "+ str_tx[i])
#         print("FIFO: "+ str_fifo[i])

# print(str_tx[0:1300])
# print('##################')
# print(str_fifo[0:1300])
