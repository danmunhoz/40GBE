#!/usr/bin/python3

##############################################################
## ESTE SCRIPT LIMPA O ARQUIVO DE SAIDA DEIXANDO APENAS DADOS
##############################################################

import os
import sys
import shutil
x=0
x = sys.argv[1]
y = sys.argv[2]
n=1


if (x == 'fifo'):
    n = y
    string = "sc"
    string += str(n)
    new_file = open(string+'/cleaned_dump_fifo2.txt', 'w')
    new_file2 = open(string+'/cleaned_dump_fifo.txt', 'w')
    aux = 0
    escrever = 0
    with open(string+'/dump_output.txt') as f:
        for line in f:
            if escrever == 0:
                if (line[0] == '1'):
                    escrever = 1
                    #print(line[8:])
                    new_file.write(line[8:])
            elif escrever == 1:
                if (line[2] == '1'):
                    #print(line)
                    aux = int(line[3])*8+int(line[4])*4+int(line[5])*2+int(line[6])
                    #print(aux*8)
                    #print(line[136-(aux*8):])
                    new_file.write(line[(len(line)-1)-(aux*8):])
                    escrever = 0
                else:
                    escrever = 1
                    new_file.write(line[8:])
    new_file.close()
    with open(string+'/cleaned_dump_fifo2.txt') as f:
        for line in f:
            if line[96:] != "\n":
                new_file2.write(line[96:])
            if line[64:96] != "\n":
                new_file2.write(line[64:96]+"\n")
            if line[32:64] != "\n":
                new_file2.write(line[32:64]+"\n")
            if line[:32] != "\n":
                new_file2.write(line[:32]+"\n")
    new_file2.close()
    os.remove(string+'/cleaned_dump_fifo2.txt')


if (x == 'tx'):
    control = []
    data = []
    escreve = 0
    sop_addr = 0
    achou_eop = 0
    n = y

    string = "sc"
    string += str(n)
    new_file = open(string+'/cleaned_dump_tx2.txt', 'w')
    new_file2 = open(string+'/cleaned_dump_tx.txt', 'w')

    with open(string+'/dump_mii_tx.txt') as f:
        for line in f:
            control = line[0:8]
            data = line[9:]

            if escreve == 0:

                if control == "11111111":
                    escreve = 0
                else:

                    sop_addr = int(control.index('1'))
                    if data[(sop_addr*8):(sop_addr*8+8)] == "11111011": #significa que de fato eh sop
                        if sop_addr == 7:
                            escreve = 1
                        elif sop_addr == 3:
                            escreve = 2

            elif escreve == 2:
                new_file.write(data[:32]+"\n")
                escreve = 1

            elif escreve == 1:
                #testar se tem EOP
                if control == "00000000":
                    new_file.write(data)
                else:
                    for i in range(8):
                        if control[i] == "1" and data[(i*8):(i*8+8)] == "11111101":
                            new_file.write(data[(i*8+8):])
                            escreve = 0
                            break

    new_file.close()

    with open(string+'/cleaned_dump_tx2.txt') as f:
        for line in f:
            if line[32:] != "\n":
                new_file2.write(line[32:])
            if line[:32] != "\n":
                new_file2.write(line[:32]+"\n")
    new_file2.close()

    os.remove(string+'/cleaned_dump_tx2.txt')


if (x == 'hex'):
    n = y
    cont=0
    cont2=0
    string = "sc"
    string += str(n)

    new_file = open(string+'/cleaned_dump_txhex.txt', 'w')

    with open(string+'/cleaned_dump_tx.txt') as f1:
        for line in f1:
            cont=cont+1
            # print(cont)
            if (line != '\n'):
                new_file.write(hex(int(line,2))+"\n")


    string = "sc"
    string += str(n)

    new_file2 = open(string+'/cleaned_dump_fifohex.txt', 'w')

    with open(string+'/cleaned_dump_fifo.txt') as f1:
        for line in f1:
            # if (cont2 < cont):
            #     cont2=cont2+1
            #     print(cont2)
            if (line != '\n'):
                new_file2.write(hex(int(line,2))+"\n")
