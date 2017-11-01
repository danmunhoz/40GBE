"""
Created on Mon Oct 16 16:12:43 2017

@author: rafasperb
"""
import os
n=1

while(n<=8):
    string = "sc"
    string += str(n)

    with open(string+'/cleaned_dump_tx.txt') as f1:
        str_tx = f1.read()

    with open(string+'/cleaned_dump_fifo.txt') as f2:
        str_fifo = f2.read()

    str_tx = str_tx.replace('\n', '')
    str_fifo = str_fifo.replace('\n', '')

    if str_tx == str_fifo:
        new_file = open(string+'/PASSOU.txt', 'w')
    else:
        new_file = open(string+'/NAO PASSOU.txt', 'w')

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
    n=n+1
