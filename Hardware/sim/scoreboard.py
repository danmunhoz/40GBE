f0  = open("dump_mii_tx.txt", "r")
f1  = open("dump_mii_rx.txt", "r")
i = 0
error = 0

for line0, line1 in zip(f0, f1):
        i = i + 1
        if line0 != line1:
            print "Error: MII_TX and MII_RX are different at line %d!" % i
            print "MII_TX line: ",line0,"MII_RX line: ",line1
            print " "
            error = error + 1;

if not(error > 0):
    print "[SCOREBOARD] dump_mii_tx == dump_mii_rx"
else:
    print "[SCOREBOARD] %d errors founded!" %error
