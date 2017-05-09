#ifndef SCOREBOARD
#define SCOREBOARD

#include <systemc.h>

SC_MODULE(scoreboard) {

public:
  // sc_in_clk scoreboard_clk;
  // sc_port< sc_fifo_in_if<sc_lv<64>> > pkt_from_tx;
  // sc_port< sc_fifo_in_if<sc_lv<64>> > pkt_from_rx;
  //
  // sc_port< sc_fifo_in_if<sc_lv<2>> > hdr_from_tx;
  // sc_port< sc_fifo_in_if<sc_lv<2>> > hdr_from_rx;
  //
  // sc_fifo<sc_lv<64>> pkt_sent;
  // sc_fifo<sc_lv<64>> pkt_rcvd;
  // sc_fifo<sc_lv<2> > hdr_sent;
  // sc_fifo<sc_lv<2> > hdr_rcvd;

  SC_CTOR(scoreboard) {
    // SC_THREAD(check_data);
    // sensitive<<scoreboard_clk.pos();
    // SC_THREAD(compare_pkts);
    // sensitive<<scoreboard_clk.pos();
    // dont_initialize();
  }

private:
  void check_data();
  void compare_pkts();

};

#endif
