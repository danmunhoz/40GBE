"""
Created on Mon Oct 16 16:12:43 2017

@author: rafasperb
"""
import os

control = []
data = []
escreve = 0
sop_addr = 0
achou_eop = 0
n=1

while(n<=8):
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
    n=n+1
