# !/bin/bash

if [ "$1" = "-h" ]
then
  echo "To use: ./run_simulation <min payload cycles*> <max payload cycles> <min IPG**> <max IPG> <simulation time> <simulation time unit>"
  echo "*Min payload cycles must be at least 3"
  echo "**Min IPG must be at least 1"
elif [ $# -lt 6 ]
then
  echo "Parameters missing"
  echo "To use: ./run_simulation <min payload cycles*> <max payload cycles> <min IPG**> <max IPG> <simulation time> <simulation time unit>"
  echo "*Min payload cycles must be at least 3"
  echo "**Min IPG must be at least 1"
else
  rm -rf transcript*

  module load modelsim

  i_begin=$1
  i_end=$2
  j_begin=$3
  j_end=$4
  time_sim=$5
  time_unit=$6

  export i_begin
  export i_end
  export j_begin
  export j_end
  export time_sim
  export time_unit

  vsim -c -do run_n.do
fi
