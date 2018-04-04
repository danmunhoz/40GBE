#!/bin/sh
#!/usr/bin/python3

module load modelsim


#load input
python config.py sc$1
cd ..
vsim -do run.do -c
cd tests
python config.py mts$1

#run new input
python config.py mt$1
python config.py sc$1
cd ..
vsim -do run.do -c
cd tests
python config.py mo$1
python clean_dump.py tx $1
python clean_dump.py fifo $1
python clean_dump.py hex $1
python comparador.py $1
