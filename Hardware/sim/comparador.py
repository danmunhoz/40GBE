f0  = open("dump_mii_rx_0.txt", "r")
f1  = open("dump_mii_rx_1.txt", "r")
f2  = open("dump_mii_rx_2.txt", "r")
f3  = open("dump_mii_rx_3.txt", "r")

fo  = open("dump_output.txt", "r")
i = 0
error = 0
lane0 = 0
lane1 = 0
lane2 = 0
lane3 = 0
aux = 0

lane1 = f1.readline()
lane0 = f0.readline()
aux = lane1[10:73] + lane0[10:73]
print(aux)
lane3 = f3.readline()
lane2 = f2.readline()
aux = lane3[10:73] + lane2[10:73]
print(aux)

##Contar linhas de um arquivo TXT
#def contar_linhas_arquivo(arq):
#    with open(arq, 'r') as f:
#         t = len(f.readlines())
#         f.close()
#         return(t)

#for line0, line1 in zip(f0, f1):
#        i = i + 1
#        if line0 != line1:
#            print "Error: MII_TX and MII_RX are different at line %d!" % i
#            print "MII_TX line: ",line0,"MII_RX line: ",line1
#            print " "
#            error = error + 1;
#
#if not(error > 0):
#    print "[SCOREBOARD] dump_mii_tx == dump_mii_rx"
#else:
#    print "[SCOREBOARD] %d errors founded!" %error








with open('cleaned_dump_tx.txt') as f1:
    str_tx = f1.read()

with open('cleaned_dump_out.txt') as f2:
    str_out = f2.read()

str_tx = str_tx.replace('\n', '')
str_out = str_out.replace('\n', '')

if str_tx == str_out:
    print('passou')
