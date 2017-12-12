#!/usr/bin/python3

n=1
while(n<=16):
    string = "sc"
    string += str(n)

    new_file = open(string+'/cleaned_dump_txhex.txt', 'w')

    with open(string+'/cleaned_dump_tx.txt') as f1:
        for line in f1:
            if (line != '\n'):
                new_file.write(hex(int(line,2))+"\n")
    n=n+1

n=1
while(n<=16):
    string = "sc"
    string += str(n)

    new_file2 = open(string+'/cleaned_dump_fifohex.txt', 'w')

    with open(string+'/cleaned_dump_fifo.txt') as f1:
        for line in f1:
            if (line != '\n'):
                new_file2.write(hex(int(line,2))+"\n")
    n=n+1
