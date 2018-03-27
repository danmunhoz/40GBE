#ifndef SC_TB
#define sc_tb


#include <systemc.h>
#include <stdio.h>

//MODULES VHDL
#include "tx_xgt4.h"
#include "rx_xgt4.h"
#include "scoreboard.h"
#include "pkt_buffer.h"
#include "dump_mii.h"
#include "dump_output.h"
#include "fiber.h"
// #include "lane_reorder.h"

SC_MODULE(Top) {
  sc_clock clk_156;
  sc_clock clk_161;
  sc_clock clk_312;

  sc_event reset_deactivation_event;
  sc_event reset_mii_tx_deactivation_event;
  sc_event valid_rx_generator_event;

  sc_signal<sc_logic> iclock156;
  sc_signal<sc_logic> iclock161;
  sc_signal<sc_logic> iclock312;

  sc_signal<sc_logic> reset;
  sc_signal<sc_logic> reset_mii_tx;
  sc_signal<sc_logic> reset_mii_rx;

  //sc_signal<sc_logic> pkt_tx_start;

  // TX
  sc_signal<sc_lv<8> >  dump_xgmii_txc;
  sc_signal<sc_lv<64> > dump_xgmii_txd;

  sc_signal<sc_lv<8> >  dump_xgmii_rxc_0;
  sc_signal<sc_lv<64> > dump_xgmii_rxd_0;
  sc_signal<sc_lv<8> >  dump_xgmii_rxc_1;
  sc_signal<sc_lv<64> > dump_xgmii_rxd_1;
  sc_signal<sc_lv<8> >  dump_xgmii_rxc_2;
  sc_signal<sc_lv<64> > dump_xgmii_rxd_2;
  sc_signal<sc_lv<8> >  dump_xgmii_rxc_3;
  sc_signal<sc_lv<64> > dump_xgmii_rxd_3;

  sc_signal<sc_lv<64> > block_from_xgt4;
  sc_signal<sc_lv<2> >  header_from_xgt4;

  // sc_signal<sc_lv<64> > lane0_block_from_xgt4;
  // sc_signal<sc_lv<2> >  lane0_header_from_xgt4;
  //
  // sc_signal<sc_lv<64> > lane1_block_from_xgt4;
  // sc_signal<sc_lv<2> >  lane1_header_from_xgt4;
  //
  // sc_signal<sc_lv<64> > lane2_block_from_xgt4;
  // sc_signal<sc_lv<2> >  lane2_header_from_xgt4;
  //
  // sc_signal<sc_lv<64> > lane3_block_from_xgt4;
  // sc_signal<sc_lv<2> >  lane3_header_from_xgt4;

  // RX
  //sc_signal< sc_lv<64> >    block_to_xgt4;
  //sc_signal< sc_lv<2>  >    header_to_xgt4;

  sc_signal< sc_logic  >    data_valid_xgt4;
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

  //Sinais fiber
  sc_signal<sc_lv<64 > > block_out_0;
  sc_signal<sc_lv<2 > >  header_out_0;
  sc_signal<sc_logic>    valid_out_0;
  sc_signal<sc_lv<64 > > block_out_1;
  sc_signal<sc_lv<2 > >  header_out_1;
  sc_signal<sc_logic>    valid_out_1;
  sc_signal<sc_lv<64 > > block_out_2;
  sc_signal<sc_lv<2 > >  header_out_2;
  sc_signal<sc_logic>    valid_out_2;
  sc_signal<sc_lv<64 > > block_out_3;
  sc_signal<sc_lv<2 > >  header_out_3;
  sc_signal<sc_logic>    valid_out_3;

  sc_signal<sc_lv<64 > > pcs_0_block_out;
  sc_signal<sc_lv<64 > > pcs_1_block_out;
  sc_signal<sc_lv<64 > > pcs_2_block_out;
  sc_signal<sc_lv<64 > > pcs_3_block_out;
  sc_signal<sc_lv<2 > > pcs_0_header_out;
  sc_signal<sc_lv<2 > > pcs_1_header_out;
  sc_signal<sc_lv<2 > > pcs_2_header_out;
  sc_signal<sc_lv<2 > > pcs_3_header_out;


  // sinais de saida da FIFO
  sc_signal<sc_lv<128> > mac_data;
  sc_signal<sc_logic> mac_sop;
  sc_signal<sc_lv<5> > mac_eop;


  tx_xgt4      * tx_xgt4_inst;
  rx_xgt4      * rx_xgt4_inst;
  scoreboard   * scoreboard_inst;
  pkt_buffer   * pkt_buffer_inst;
  dump_mii     * dump_mii_tx_inst;
  dump_mii     * dump_mii_rx_inst_0;
  dump_mii     * dump_mii_rx_inst_1;
  dump_mii     * dump_mii_rx_inst_2;
  dump_mii     * dump_mii_rx_inst_3;
  fiber        * fiber_inst;
  dump_output  * dump_output_inst;
  // lane_reorder * lane_reorder_inst;

  void clock_assign();
  void reset_generator();
  void reset_mii_tx_generator();
  void valid_rx_generator();

 SC_CTOR(Top): clk_156("clk_156", 6.4, SC_NS, 0.5, 0.0, SC_NS, false),
               clk_161("clk_161", 6.2, SC_NS, 0.5, 0.0, SC_NS, false),
               clk_312("clk_312", 3.2, SC_NS, 0.5, 0.0, SC_NS, false),
               iclock156("iclock156"), iclock161("iclock161"), iclock312("iclock312"), block_from_xgt4("block_from_xgt4"), header_from_xgt4("header_from_xgt4"),
               //block_to_xgt4("block_to_xgt4"), data_valid_xgt4("data_valid_xgt4"), header_to_xgt4("header_to_xgt4"),
               data_valid_xgt4("data_valid_xgt4"), header_valid_xgt4("header_valid_xgt4"), block_from_mac_rx("block_from_mac_rx") {

    // Creating instances
    tx_xgt4_inst = new tx_xgt4("tx_xgt4","tx_xgt4");
    rx_xgt4_inst = new rx_xgt4("rx_xgt4","rx_xgt4");
    scoreboard_inst = new scoreboard("scoreboard");
    pkt_buffer_inst = new pkt_buffer("pkt_buffer");
    dump_mii_tx_inst = new dump_mii("dump_mii_tx","dump_mii_tx.txt");

    dump_mii_rx_inst_0 = new dump_mii("dump_mii_rx_0","dump_mii_rx_0.txt");
    dump_mii_rx_inst_1 = new dump_mii("dump_mii_rx_1","dump_mii_rx_1.txt");
    dump_mii_rx_inst_2 = new dump_mii("dump_mii_rx_2","dump_mii_rx_2.txt");
    dump_mii_rx_inst_3 = new dump_mii("dump_mii_rx_3","dump_mii_rx_3.txt");

    dump_output_inst = new dump_output("dump_output", "dump_output.txt");

    fiber_inst  = new fiber("fiber");
    // lane_reorder_inst = new lane_reorder("lane_reorder", "lane_reorder");

    // Connections
    tx_xgt4_inst->clock_in156(iclock156);
    tx_xgt4_inst->clock_in161(iclock161);
    tx_xgt4_inst->reset_in(reset);
    tx_xgt4_inst->reset_in_mii_tx(reset_mii_tx);
    tx_xgt4_inst->reset_in_mii_rx(reset_mii_rx);
    tx_xgt4_inst->data_out(block_from_xgt4);
    tx_xgt4_inst->header_out(header_from_xgt4);
    tx_xgt4_inst->dump_xgmii_txc(dump_xgmii_txc);
    tx_xgt4_inst->dump_xgmii_txd(dump_xgmii_txd);
    // tx_xgt4_inst->pkt_tx_start(pkt_tx_start);


    rx_xgt4_inst->clock_in156(iclock156);
    rx_xgt4_inst->clock_in161(iclock161);
    rx_xgt4_inst->clock_in312(iclock312);
    rx_xgt4_inst->reset_in(reset);
    rx_xgt4_inst->reset_in_mii_tx(reset_mii_tx);
    rx_xgt4_inst->reset_in_mii_rx(reset_mii_rx);
    rx_xgt4_inst->pkt_rx_data(block_from_mac_rx);
    rx_xgt4_inst->dump_xgmii_rxc_0(dump_xgmii_rxc_0);
    rx_xgt4_inst->dump_xgmii_rxd_0(dump_xgmii_rxd_0);
    rx_xgt4_inst->dump_xgmii_rxc_1(dump_xgmii_rxc_1);
    rx_xgt4_inst->dump_xgmii_rxd_1(dump_xgmii_rxd_1);
    rx_xgt4_inst->dump_xgmii_rxc_2(dump_xgmii_rxc_2);
    rx_xgt4_inst->dump_xgmii_rxd_2(dump_xgmii_rxd_2);
    rx_xgt4_inst->dump_xgmii_rxc_3(dump_xgmii_rxc_3);
    rx_xgt4_inst->dump_xgmii_rxd_3(dump_xgmii_rxd_3);

    rx_xgt4_inst->rx_lane_0_header_valid_in(valid_out_0);
    rx_xgt4_inst->rx_lane_0_header_in(header_out_0);
    rx_xgt4_inst->rx_lane_0_data_valid_in(valid_out_0);
    rx_xgt4_inst->rx_lane_0_data_in(block_out_0);

    rx_xgt4_inst->rx_lane_1_header_valid_in(valid_out_1);
    rx_xgt4_inst->rx_lane_1_header_in(header_out_1);
    rx_xgt4_inst->rx_lane_1_data_valid_in(valid_out_1);
    rx_xgt4_inst->rx_lane_1_data_in(block_out_1);

    rx_xgt4_inst->rx_lane_2_header_valid_in(valid_out_2);
    rx_xgt4_inst->rx_lane_2_header_in(header_out_2);
    rx_xgt4_inst->rx_lane_2_data_valid_in(valid_out_2);
    rx_xgt4_inst->rx_lane_2_data_in(block_out_2);

    rx_xgt4_inst->rx_lane_3_header_valid_in(valid_out_3);
    rx_xgt4_inst->rx_lane_3_header_in(header_out_3);
    rx_xgt4_inst->rx_lane_3_data_valid_in(valid_out_3);
    rx_xgt4_inst->rx_lane_3_data_in(block_out_3);


    rx_xgt4_inst->pkt_rx_eop(pkt_rx_eop);
    rx_xgt4_inst->pkt_rx_err(pkt_rx_err);
    rx_xgt4_inst->pkt_rx_mod(pkt_rx_mod);
    rx_xgt4_inst->pkt_rx_sop(pkt_rx_sop);
    rx_xgt4_inst->pkt_rx_val(pkt_rx_val);
    rx_xgt4_inst->pkt_rx_avail(pkt_rx_avail);

    rx_xgt4_inst->mac_data(mac_data);
    rx_xgt4_inst->mac_sop(mac_sop);
    rx_xgt4_inst->mac_eop(mac_eop);

    // output dumped to file for comparison
    dump_output_inst->clock_in(iclock312);
    dump_output_inst->reset_n(reset);
    dump_output_inst->mac_data(mac_data);
    dump_output_inst->mac_sop(mac_sop);
    dump_output_inst->mac_eop(mac_eop);

    scoreboard_inst->clock_in156(iclock156);

    pkt_buffer_inst->clock_in161(iclock161);
    pkt_buffer_inst->reset_n(reset);
    pkt_buffer_inst->header_in(header_from_xgt4);
    pkt_buffer_inst->block_in(block_from_xgt4);
    pkt_buffer_inst->data_valid_in(rx_data_valid_in); //Passar para o data_valid do TX

    dump_mii_tx_inst->clock_in(iclock156);
    dump_mii_tx_inst->reset_n(reset);
    dump_mii_tx_inst->mii_c(dump_xgmii_txc);
    dump_mii_tx_inst->mii_d(dump_xgmii_txd);

    dump_mii_rx_inst_0->clock_in(iclock156);
    dump_mii_rx_inst_0->reset_n(reset);
    dump_mii_rx_inst_0->mii_c(dump_xgmii_rxc_0);
    dump_mii_rx_inst_0->mii_d(dump_xgmii_rxd_0);

    dump_mii_rx_inst_1->clock_in(iclock156);
    dump_mii_rx_inst_1->reset_n(reset);
    dump_mii_rx_inst_1->mii_c(dump_xgmii_rxc_1);
    dump_mii_rx_inst_1->mii_d(dump_xgmii_rxd_1);

    dump_mii_rx_inst_2->clock_in(iclock156);
    dump_mii_rx_inst_2->reset_n(reset);
    dump_mii_rx_inst_2->mii_c(dump_xgmii_rxc_2);
    dump_mii_rx_inst_2->mii_d(dump_xgmii_rxd_2);

    dump_mii_rx_inst_3->clock_in(iclock156);
    dump_mii_rx_inst_3->reset_n(reset);
    dump_mii_rx_inst_3->mii_c(dump_xgmii_rxc_3);
    dump_mii_rx_inst_3->mii_d(dump_xgmii_rxd_3);

    fiber_inst->clock_in(iclock161);
    fiber_inst->reset_in(reset);
    fiber_inst->block_out_0(block_out_0);
    fiber_inst->header_out_0(header_out_0);
    fiber_inst->valid_out_0(valid_out_0);
    fiber_inst->block_out_1(block_out_1);
    fiber_inst->header_out_1(header_out_1);
    fiber_inst->valid_out_1(valid_out_1);
    fiber_inst->block_out_2(block_out_2);
    fiber_inst->header_out_2(header_out_2);
    fiber_inst->valid_out_2(valid_out_2);
    fiber_inst->block_out_3(block_out_3);
    fiber_inst->header_out_3(header_out_3);
    fiber_inst->valid_out_3(valid_out_3);

    //INSTACIANDO NO TOP POR AGORA PARA TESTER... DEPOIS VAI PRA DENTRO DO WRAPPER...
    // lane_reorder_inst->lane_0_block_in(block_out_0);
    // lane_reorder_inst->lane_1_block_in(block_out_1);
    // lane_reorder_inst->lane_2_block_in(block_out_2);
    // lane_reorder_inst->lane_3_block_in(block_out_3);
    // lane_reorder_inst->lane_0_header_in(header_out_0);
    // lane_reorder_inst->lane_1_header_in(header_out_1);
    // lane_reorder_inst->lane_2_header_in(header_out_2);
    // lane_reorder_inst->lane_3_header_in(header_out_3);
    // lane_reorder_inst->pcs_0_block_out(pcs_0_block_out);
    // lane_reorder_inst->pcs_1_block_out(pcs_1_block_out);
    // lane_reorder_inst->pcs_2_block_out(pcs_2_block_out);
    // lane_reorder_inst->pcs_3_block_out(pcs_3_block_out);
    // lane_reorder_inst->pcs_0_header_out(pcs_0_header_out);
    // lane_reorder_inst->pcs_1_header_out(pcs_1_header_out);
    // lane_reorder_inst->pcs_2_header_out(pcs_2_header_out);
    // lane_reorder_inst->pcs_3_header_out(pcs_3_header_out);

    SC_METHOD(clock_assign);
    sensitive << clk_156.signal();
    sensitive << clk_161.signal();
    sensitive << clk_312.signal();
    dont_initialize();

    SC_METHOD(reset_generator);
    sensitive << reset_deactivation_event;

    SC_METHOD(reset_mii_tx_generator);
    sensitive << reset_mii_tx_deactivation_event;

    SC_METHOD(valid_rx_generator);
    sensitive << valid_rx_generator_event;

  }
  ~Top () {
    // delete tx_xgt4_inst;
    // delete rx_xgt4_inst;
    // delete scoreboard_inst;
    // delete pkt_buffer_inst;
    // delete dump_mii_rx_inst;
    // delete fiber_inst;
  }

};
inline void Top::clock_assign()
{
  sc_logic clock_tmp156(clk_156.signal().read());
  iclock156.write(clock_tmp156);

  sc_logic clock_tmp161(clk_161.signal().read());
  iclock161.write(clock_tmp161);

  sc_logic clock_tmp312(clk_312.signal().read());
  iclock312.write(clock_tmp312);
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
