#ifndef SC_TB
#define sc_tb


#include <systemc.h>
#include <stdio.h>

//MODULES VHDL
#include "tb_xgt4.h"
#include "rx_xgt4.h"
#include "scoreboard.h"
#include "pkt_buffer.h"
#include "dump_mii.h"

SC_MODULE(Top) {
  sc_clock clk_156;
  sc_clock clk_161;

  sc_event reset_deactivation_event;
  sc_event reset_mii_tx_deactivation_event;
  sc_event valid_rx_generator_event;

  sc_signal<sc_logic> iclock156;
  sc_signal<sc_logic> iclock161;
  sc_signal<sc_logic> reset;
  sc_signal<sc_logic> reset_mii_tx;
  sc_signal<sc_logic> reset_mii_rx;

  //sc_signal<sc_logic> pkt_tx_start;

  // TX
  sc_signal<sc_lv<64> > block_from_xgt4;
  sc_signal<sc_lv<2> >  header_from_xgt4;
  sc_signal<sc_lv<8> >  dump_xgmii_txc;
  sc_signal<sc_lv<64> > dump_xgmii_txd;
  sc_signal<sc_lv<8> >  dump_xgmii_rxc;
  sc_signal<sc_lv<64> > dump_xgmii_rxd;

  // RX
  sc_signal< sc_lv<64> >    block_to_xgt4;
  sc_signal< sc_logic  >    data_valid_xgt4;
  sc_signal< sc_lv<2>  >    header_to_xgt4;
  sc_signal< sc_logic  >    header_valid_xgt4;
  sc_signal< sc_lv<64> >    block_from_mac_rx;

  //Outros sinais rx
  sc_signal<sc_logic>     pkt_rx_eop;
  sc_signal<sc_logic>     pkt_rx_err;
  sc_signal<sc_lv<3> >    pkt_rx_mod;
  sc_signal<sc_logic>     pkt_rx_sop;
  sc_signal<sc_logic>     pkt_rx_val;
  sc_signal<sc_logic>     pkt_rx_avail;
  sc_signal<sc_logic>     rx_header_valid_in;
  sc_signal<sc_logic>     rx_data_valid_in;


  tb_xgt4    * tb_xgt4_inst;
  rx_xgt4    * rx_xgt4_inst;
  scoreboard * scoreboard_inst;
  pkt_buffer * pkt_buffer_inst;
  dump_mii   * dump_mii_tx_inst;
  dump_mii   * dump_mii_rx_inst;

  void clock_assign();
  void reset_generator();
  void reset_mii_tx_generator();
  void valid_rx_generator();

 SC_CTOR(Top): clk_156("clk_156", 6.4, SC_NS, 0.5, 0.0, SC_NS, false),
               clk_161("clk_161", 6.2, SC_NS, 0.5, 0.0, SC_NS, false),
               iclock156("iclock156"), iclock161("iclock161"), block_from_xgt4("block_from_xgt4"), header_from_xgt4("header_from_xgt4"),
               block_to_xgt4("block_to_xgt4"), data_valid_xgt4("data_valid_xgt4"), header_to_xgt4("header_to_xgt4"),
               header_valid_xgt4("header_valid_xgt4"), block_from_mac_rx("block_from_mac_rx") {

    // Creating instances
    tb_xgt4_inst = new tb_xgt4("tb_xgt4","tb_xgt4");
    rx_xgt4_inst = new rx_xgt4("rx_xgt4","rx_xgt4");
    scoreboard_inst = new scoreboard("scoreboard");
    pkt_buffer_inst = new pkt_buffer("pkt_buffer");
    dump_mii_tx_inst = new dump_mii("dump_mii_tx","dump_mii_tx.txt");
    dump_mii_rx_inst = new dump_mii("dump_mii_rx","dump_mii_rx.txt");

    // Connections
    tb_xgt4_inst->clock_in156(iclock156);
    tb_xgt4_inst->clock_in161(iclock161);
    tb_xgt4_inst->reset_in(reset);
    tb_xgt4_inst->reset_in_mii_tx(reset_mii_tx);
    tb_xgt4_inst->reset_in_mii_rx(reset_mii_rx);
    tb_xgt4_inst->data_out(block_from_xgt4);
    tb_xgt4_inst->header_out(header_from_xgt4);
    tb_xgt4_inst->dump_xgmii_txc(dump_xgmii_txc);
    tb_xgt4_inst->dump_xgmii_txd(dump_xgmii_txd);
    // tb_xgt4_inst->pkt_tx_start(pkt_tx_start);

    rx_xgt4_inst->clock_in156(iclock156);
    rx_xgt4_inst->clock_in161(iclock161);
    rx_xgt4_inst->reset_in(reset);
    rx_xgt4_inst->reset_in_mii_tx(reset_mii_tx);
    rx_xgt4_inst->reset_in_mii_rx(reset_mii_rx);
    rx_xgt4_inst->rx_header_valid_in(rx_header_valid_in);
    rx_xgt4_inst->rx_header_in(header_from_xgt4);
    rx_xgt4_inst->rx_data_valid_in(rx_data_valid_in);
    rx_xgt4_inst->rx_data_in(block_from_xgt4);
    rx_xgt4_inst->pkt_rx_data(block_from_mac_rx);
    rx_xgt4_inst->dump_xgmii_rxc(dump_xgmii_rxc);
    rx_xgt4_inst->dump_xgmii_rxd(dump_xgmii_rxd);


    rx_xgt4_inst->pkt_rx_eop(pkt_rx_eop);
    rx_xgt4_inst->pkt_rx_err(pkt_rx_err);
    rx_xgt4_inst->pkt_rx_mod(pkt_rx_mod);
    rx_xgt4_inst->pkt_rx_sop(pkt_rx_sop);
    rx_xgt4_inst->pkt_rx_val(pkt_rx_val);
    rx_xgt4_inst->pkt_rx_avail(pkt_rx_avail);

    scoreboard_inst->clock_in156(iclock156);

    pkt_buffer_inst->clock_in161(iclock161);
    pkt_buffer_inst->header_in(header_from_xgt4);
    pkt_buffer_inst->block_in(block_from_xgt4);
    pkt_buffer_inst->data_valid_in(rx_data_valid_in);

    dump_mii_tx_inst->clock_in(iclock156);
    dump_mii_tx_inst->mii_c(dump_xgmii_txc);
    dump_mii_tx_inst->mii_d(dump_xgmii_txd);

    dump_mii_rx_inst->clock_in(iclock156);
    dump_mii_rx_inst->mii_c(dump_xgmii_rxc);
    dump_mii_rx_inst->mii_d(dump_xgmii_rxd);

    SC_METHOD(clock_assign);
    sensitive << clk_156.signal();
    sensitive << clk_161.signal();
    dont_initialize();

    SC_METHOD(reset_generator);
    sensitive << reset_deactivation_event;

    SC_METHOD(reset_mii_tx_generator);
    sensitive << reset_mii_tx_deactivation_event;

    SC_METHOD(valid_rx_generator);
    sensitive << valid_rx_generator_event;

  }
  ~Top () {
    delete tb_xgt4_inst, rx_xgt4_inst, scoreboard_inst;
  }

};
inline void Top::clock_assign()
{
  sc_logic clock_tmp156(clk_156.signal().read());
  iclock156.write(clock_tmp156);

  sc_logic clock_tmp161(clk_161.signal().read());
  iclock161.write(clock_tmp161);
}

inline void Top::reset_generator()
{
    static int first = 0;
    if (first == 0)
    {
        first ++;
        reset.write(SC_LOGIC_0);
        reset_deactivation_event.notify(35, SC_NS);
        // Todos juntos
        reset_mii_tx.write(SC_LOGIC_0);
        reset_mii_rx.write(SC_LOGIC_0);
    }
    else{
        first ++;
        reset.write(SC_LOGIC_1);
        reset_mii_rx.write(SC_LOGIC_1);

    }

}

inline void Top::reset_mii_tx_generator()
{
    static bool f = true;

    if (f)
    {
        f = false;
        reset_mii_tx.write(SC_LOGIC_0);
        reset_mii_tx_deactivation_event.notify(16, SC_NS);
    }
    else {
        reset_mii_tx.write(SC_LOGIC_1);
    }
}

inline void Top::valid_rx_generator()
{
    static bool f = true;

    if (f)
    {
        f = false;
        rx_header_valid_in.write(SC_LOGIC_0);
        rx_data_valid_in.write(SC_LOGIC_0);
        valid_rx_generator_event.notify(35, SC_NS);
    }
    else {
        rx_header_valid_in.write(SC_LOGIC_1);
        rx_data_valid_in.write(SC_LOGIC_1);
    }
}

#endif
