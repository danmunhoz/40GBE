#!/usr/bin/python3

import os

n=1

while(n<=8):
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
                    escrever = 0
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
    n=n+1
