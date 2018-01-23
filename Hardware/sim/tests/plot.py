#!/usr/bin/python3

##############################################################
## ESTE SCRIPT LIMPA O ARQUIVO DE SAIDA DEIXANDO APENAS DADOS
##############################################################

#FIFO SIZE
max_addr = 512

import os
import sys
import shutil

tempo = 0
sw = ''
sr = ''
i=2
t=0
x=2

time=[]
write=[]
read=[]
wires=[]
values=[]
diff_val = []
total_wires = 0
wires_btw_time = 0

# if (x == 'fifo'):
#     n = y
#     string = "sc"
#     string += str(n)
#     new_file = open(string+'/cleaned_dump_fifo2.txt', 'w')
#     new_file2 = open(string+'/cleaned_dump_fifo.txt', 'w')
#     aux = 0
#     escrever = 0
    # with open(string+'/dump_output.txt') as f:
with open('list.lst') as f:
    for line in f:
        if (line[0] == '/'):
            wires_btw_time = wires_btw_time + 1
            temp = line.split(' ')
            if temp[0] in wires:
                #pega a posicao
                # values[wires.index(temp[0])].append(temp[1])
                # print wires.index(temp[0])
                temp_value = temp[1].split('h')[1]
                temp_value = temp_value[0:-1]
                # print temp[1].split('h')[1]
                values[wires.index(temp[0])].append(int(temp_value, 16))
            else:
                new = []
                values.append(new)
                wires.append(temp[0])
                total_wires = total_wires + 1
        elif (line[0] == '@'):
            if wires_btw_time != total_wires:
                temp_list = []
                for i in values:
                    temp_list.append(len(i))
                max_len = max(temp_list)
                for i in values:
                    if len(i) < max_len and len(i) > 1:
                        i.append(i[-1])
                    elif len(i) < max_len and len(i) == 1:
                        i.append(i[0])
            wires_btw_time = 0
            temp = line.split(' ')
            time.append(int(temp[0][1:]))

# ultimo ajuste pq nao tem @ na linha final
temp_list = []
for i in values:
    temp_list.append(len(i))
max_len = max(temp_list)

for i in values:
    if len(i) < max_len:
        i.append(i[-1])
##########################################


for i in range(0,len(values)/2):
    new = [values[i*2][j]-values[i*2+1][j] for j in range(len(values[i*2]))]
    diff_val.append(new)

#se deu negativo, e pq "deu a volta na fifo"
for i in range(0,len(diff_val)):
    for j in range(0,len(diff_val[i])):
        if diff_val[i][j] < 0:
            diff_val[i][j] = max_addr + diff_val[i][j]


import matplotlib.pyplot as plt
import numpy as np

f, axarr = plt.subplots(len(diff_val), sharex=True)

subplot_i = 0
for i in diff_val:
    print len(time[0:len(i)])
    print len(i)
    axarr[subplot_i].plot(time[0:len(i)], i)
    axarr[subplot_i].set_title(wires[subplot_i*2])
    axarr[subplot_i].axis([0,max(time),0,max(i)+3])
    axarr[subplot_i].grid(True)
    subplot_i = subplot_i + 1

# axarr[0].set_title('COMPORTAMENTO FIFOS (WRITE - READ)')
plt.xlabel('time [ps]')
plt.show()
