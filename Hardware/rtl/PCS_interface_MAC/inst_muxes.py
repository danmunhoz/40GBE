print "library IEEE;\
\nuse IEEE.STD_LOGIC_1164.ALL;\
\nuse IEEE.STD_LOGIC_UNSIGNED.ALL;\
\nlibrary unisim;\
\nuse unisim.vcomponents.all;\
\n\
\n--############################################################################--\
\n--#                       File generated automatically                       #--\
\n--#                            by inst_muxes.py                              #--\
\n--#                                                                          #--\
\n--#                python inst_muxes.py > mii_shifter_lut.vhd                #--\
\n--############################################################################--\
\n\
\n\
\nentity mii_shifter_lut is\
\n  Port(\
\n    in_0      : in std_logic_vector(255 downto 0);\
\n    in_1      : in std_logic_vector(255 downto 0);\
\n    sel_mux   : in std_logic_vector(2 downto 0);\
\n\
\n    data_out  : out std_logic_vector(255 downto 0)\
\n  );\
\nend entity;\
\n\
\n\
\narchitecture behav_mii_shifter of mii_shifter_lut is\
\n  component mux8 is\
\n    Port (  data_in : in std_logic_vector(7 downto 0);\
\n                sel : in std_logic_vector(2 downto 0);\
\n           data_out : out std_logic\
\n          );\
\n  end component;"

print "-- Signal declarations:"

for i in range(0,256):
    print 'signal mux_input_%d : std_logic_vector(7 downto 0);' %i

print "begin"
print "-- Muxes from 0 to 31:"
# MUXES FROM 0 TO 31 HAVE ALL INPUTS FROM in_1
index_in_1_0 = 0
index_in_1_1 = 32
index_in_1_2 = 64
index_in_1_3 = 96
index_in_1_4 = 128
index_in_1_5 = 160
index_in_1_6 = 192
index_in_1_7 = 224

for i in range(0,32):
    print 'mux_input_%d <= in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d);' %(i, index_in_1_7, index_in_1_6, index_in_1_5, index_in_1_4, index_in_1_3, index_in_1_2, index_in_1_1, index_in_1_0)
    index_in_1_0 = index_in_1_0 + 1
    index_in_1_1 = index_in_1_1 + 1
    index_in_1_2 = index_in_1_2 + 1
    index_in_1_3 = index_in_1_3 + 1
    index_in_1_4 = index_in_1_4 + 1
    index_in_1_5 = index_in_1_5 + 1
    index_in_1_6 = index_in_1_6 + 1
    index_in_1_7 = index_in_1_7 + 1


print "-- Muxes from 32 to 63:"
index_in_1_0 = 32
index_in_1_1 = 64
index_in_1_2 = 96
index_in_1_3 = 128
index_in_1_4 = 160
index_in_1_5 = 192
index_in_1_6 = 224
index_in_0_7 = 0

for i in range(32,64):
    print 'mux_input_%d <= in_0(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d);' %(i, index_in_0_7, index_in_1_6, index_in_1_5, index_in_1_4, index_in_1_3, index_in_1_2, index_in_1_1, index_in_1_0)
    index_in_1_0 = index_in_1_0 + 1
    index_in_1_1 = index_in_1_1 + 1
    index_in_1_2 = index_in_1_2 + 1
    index_in_1_3 = index_in_1_3 + 1
    index_in_1_4 = index_in_1_4 + 1
    index_in_1_5 = index_in_1_5 + 1
    index_in_1_6 = index_in_1_6 + 1
    index_in_0_7 = index_in_0_7 + 1

print "-- Muxes from 64 to 95:"
index_in_1_0 = 64
index_in_1_1 = 96
index_in_1_2 = 128
index_in_1_3 = 160
index_in_1_4 = 192
index_in_1_5 = 224
index_in_0_6 = 0
index_in_0_7 = 32

for i in range(64,96):
    print 'mux_input_%d <= in_0(%d) & in_0(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d);' %(i, index_in_0_7, index_in_0_6, index_in_1_5, index_in_1_4, index_in_1_3, index_in_1_2, index_in_1_1, index_in_1_0)
    index_in_1_0 = index_in_1_0 + 1
    index_in_1_1 = index_in_1_1 + 1
    index_in_1_2 = index_in_1_2 + 1
    index_in_1_3 = index_in_1_3 + 1
    index_in_1_4 = index_in_1_4 + 1
    index_in_1_5 = index_in_1_5 + 1
    index_in_0_6 = index_in_0_6 + 1
    index_in_0_7 = index_in_0_7 + 1

print "-- Muxes from 96 to 127:"
index_in_1_0 = 96
index_in_1_1 = 128
index_in_1_2 = 160
index_in_1_3 = 192
index_in_1_4 = 224
index_in_0_5 = 0
index_in_0_6 = 32
index_in_0_7 = 64

for i in range(96,128):
    print 'mux_input_%d <= in_0(%d) & in_0(%d) & in_0(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d);' %(i, index_in_0_7, index_in_0_6, index_in_0_5, index_in_1_4, index_in_1_3, index_in_1_2, index_in_1_1, index_in_1_0)
    index_in_1_0 = index_in_1_0 + 1
    index_in_1_1 = index_in_1_1 + 1
    index_in_1_2 = index_in_1_2 + 1
    index_in_1_3 = index_in_1_3 + 1
    index_in_1_4 = index_in_1_4 + 1
    index_in_0_5 = index_in_0_5 + 1
    index_in_0_6 = index_in_0_6 + 1
    index_in_0_7 = index_in_0_7 + 1

print "-- Muxes from 128 to 159:"
index_in_1_0 = 128
index_in_1_1 = 160
index_in_1_2 = 192
index_in_1_3 = 224
index_in_0_4 = 0
index_in_0_5 = 32
index_in_0_6 = 64
index_in_0_7 = 128

for i in range(128,160):
    print 'mux_input_%d <= in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_1(%d) & in_1(%d) & in_1(%d) & in_1(%d);' %(i, index_in_0_7, index_in_0_6, index_in_0_5, index_in_0_4, index_in_1_3, index_in_1_2, index_in_1_1, index_in_1_0)
    index_in_1_0 = index_in_1_0 + 1
    index_in_1_1 = index_in_1_1 + 1
    index_in_1_2 = index_in_1_2 + 1
    index_in_1_3 = index_in_1_3 + 1
    index_in_0_4 = index_in_0_4 + 1
    index_in_0_5 = index_in_0_5 + 1
    index_in_0_6 = index_in_0_6 + 1
    index_in_0_7 = index_in_0_7 + 1

print "-- Muxes from 160 to 191:"
index_in_1_0 = 160
index_in_1_1 = 192
index_in_1_2 = 224
index_in_0_3 = 0
index_in_0_4 = 32
index_in_0_5 = 64
index_in_0_6 = 96
index_in_0_7 = 128

for i in range(160,192):
    print 'mux_input_%d <= in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_1(%d) & in_1(%d) & in_1(%d);' %(i, index_in_0_7, index_in_0_6, index_in_0_5, index_in_0_4, index_in_0_3, index_in_1_2, index_in_1_1, index_in_1_0)
    index_in_1_0 = index_in_1_0 + 1
    index_in_1_1 = index_in_1_1 + 1
    index_in_1_2 = index_in_1_2 + 1
    index_in_0_3 = index_in_0_3 + 1
    index_in_0_4 = index_in_0_4 + 1
    index_in_0_5 = index_in_0_5 + 1
    index_in_0_6 = index_in_0_6 + 1
    index_in_0_7 = index_in_0_7 + 1

print "-- Muxes from 192 to 223:"
index_in_1_0 = 192
index_in_1_1 = 224
index_in_0_2 = 0
index_in_0_3 = 32
index_in_0_4 = 64
index_in_0_5 = 96
index_in_0_6 = 128
index_in_0_7 = 160

for i in range(192,224):
    print 'mux_input_%d <= in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_1(%d) & in_1(%d);' %(i, index_in_0_7, index_in_0_6, index_in_0_5, index_in_0_4, index_in_0_3, index_in_0_2, index_in_1_1, index_in_1_0)
    index_in_1_0 = index_in_1_0 + 1
    index_in_1_1 = index_in_1_1 + 1
    index_in_0_2 = index_in_0_2 + 1
    index_in_0_3 = index_in_0_3 + 1
    index_in_0_4 = index_in_0_4 + 1
    index_in_0_5 = index_in_0_5 + 1
    index_in_0_6 = index_in_0_6 + 1
    index_in_0_7 = index_in_0_7 + 1

print "-- Muxes from 224 to 255:"
index_in_1_0 = 224
index_in_0_1 = 0
index_in_0_2 = 32
index_in_0_3 = 64
index_in_0_4 = 96
index_in_0_5 = 128
index_in_0_6 = 160
index_in_0_7 = 192

for i in range(224,256):
    print 'mux_input_%d <= in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_0(%d) & in_1(%d);' %(i, index_in_0_7, index_in_0_6, index_in_0_5, index_in_0_4, index_in_0_3, index_in_0_2, index_in_0_1, index_in_1_0)
    index_in_1_0 = index_in_1_0 + 1
    index_in_0_1 = index_in_0_1 + 1
    index_in_0_2 = index_in_0_2 + 1
    index_in_0_3 = index_in_0_3 + 1
    index_in_0_4 = index_in_0_4 + 1
    index_in_0_5 = index_in_0_5 + 1
    index_in_0_6 = index_in_0_6 + 1
    index_in_0_7 = index_in_0_7 + 1

# MUXES PORT MAPS
print '-- Port maps:'
for i in range(0,256):
    print 'inst_mux_%d: entity work.mux8 port map(mux_input_%d, sel_mux, data_out(%d));' %(i,i,i)

print "end architecture;"
