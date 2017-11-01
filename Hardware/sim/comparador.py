"""
Created on Mon Oct 16 16:12:43 2017

@author: rafasperb
"""

with open('cleaned_dump_tx.txt') as f1:
    str_tx = f1.read()

with open('cleaned_dump_fifo.txt') as f2:
    str_fifo = f2.read()

str_tx = str_tx.replace('\n', '')
str_fifo = str_fifo.replace('\n', '')

print('Tamanho Entrada: ',len(str_tx))
print('Tamanho Saida FIFO: ',len(str_fifo))

for i in range(len(str_tx)):
    if str_tx[i] == str_fifo[i]:
        print('passou')
    else:
        print('Nao passou')
        print(i)
        print("TX: "+ str_tx[i])
        print("FIFO: "+ str_fifo[i])

print(str_tx[0:1300])
print('##################')
print(str_fifo[0:1300])
