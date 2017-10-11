import sys
with open('cleaned_dump_tx2.txt') as f1:
    str_tx = f1.read()

with open('cleaned_dump_fifo2.txt') as f2:
    str_fifo = f2.read()

str_tx = str_tx.replace('\n', '')
str_fifo = str_fifo.replace('\n', '')

print('Tamanho Entrada: ',len(str_tx))
print('Tamanho Saída FIFO: ',len(str_fifo))

for i in range(len(str_tx)):
    if str_tx[i] == str_fifo[i]:
        print('passou')
    else:
        print('Não passou')
        print(i)
        print("TX: "+ str_tx[i])
        print("FIFO: "+ str_fifo[i])

print(str_tx[0:1300])
print('##################')
print(str_fifo[0:1300])