README file for the simulation process


The simulation folder contains several input and output files as well as SystemC
and vhdl modules needed to run the testbench.
Those modules are:
  - Top (sc_tb.h). This is the simulation TOP module.
  - tx_xgt4 (tx_xgt4.vhd). This module instantiates the transmitting wrapper_macpcs
    and the echo_generator module, which generates payloads to be transmitted.
    In its interface is possible to set payload type, size, and interval of requests.
  - pkt_buffer (pkt_buffer.h). This is the module responsible for reading the
    PCS TX output bus (66 bits). The module than breaks the stream into four
    lanes in a Round-Robin fashion (as stated in 803.2ab), it also inserts the
    alignment markers.
  - fiber (fiber.h). This module loads the four files into the respective PCS
    buses. Additionally, it is possible to insert arbitrary values of skew
    between lanes and randomly order the lanes.
  - rx_xgt4 (rx_xgt4.vhd). This module instantiates the receiving wrapper_macpcs_rx.
  - dump_output (dump_output.h). Creates dump files from the receiving end point.
  - dump_mii (dump_mii.txt). Dumps the MII bus. Now, it is being used to monitor
    the four receiving PCS and the transmitting module.


There are 2 ways of simulating the project:

1) Running the modelsim script "run.do", which will run the testbench using the
   existing files of input data.
   Basically, run.do will instantiate all the SystemC modules that load input
   data and dumps the output data of the circuit under test (DUT) on different files.
   Those main files are:
      - lane0.txt, lane1.txt, lane2.txt, and lane3.txt, which store all the PCS
      blocks that will be inputed to the RX PCSs. Those files are filled with
      the stream oriund from the TX PCS broken into 4 lanes (they already contain
      alignment blocks inserted by the SystemC module "packet_buffer.h")
      - lane0_rx.txt, lane1_rx.txt, lane2_rx.txt, and lane3_rx.txt, that are copies
      of the lanes from the last execution.

2) Running the recursive verification scrits.
   More information about it can be found at tests/README.txt
