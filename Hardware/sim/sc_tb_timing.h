#ifndef SC_TB
#define sc_tb


#include <systemc.h>
#include <stdio.h>

//MODULES VHDL
//#include "tb_xgt4.h"
#include "area_timing_wrapper.h"
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
  //tanauan
  sc_clock clk_156_n;
  sc_clock clk_161_n;
  sc_clock clk_312_n;

  sc_event reset_deactivation_event;
  sc_event reset_mii_tx_deactivation_event;
  sc_event valid_rx_generator_event;

  sc_signal<sc_logic> iclock156;
  sc_signal<sc_logic> iclock161;
  sc_signal<sc_logic> iclock312;
  //tanauan
  sc_signal<sc_logic> iclock156n;
  sc_signal<sc_logic> iclock161n;
  sc_signal<sc_logic> iclock312n;

  // sc_signal<sc_logic> iclock156_n;
  // sc_signal<sc_logic> iclock312_n;

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
  sc_signal<sc_lv<64 > > block_out_1;
  sc_signal<sc_lv<2 > >  header_out_1;
  sc_signal<sc_lv<64 > > block_out_2;
  sc_signal<sc_lv<2 > >  header_out_2;
  sc_signal<sc_lv<64 > > block_out_3;
  sc_signal<sc_lv<2 > >  header_out_3;

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


  //tb_xgt4      * tb_xgt4_inst;
  scoreboard   * scoreboard_inst;
  pkt_buffer   * pkt_buffer_inst;
  // dump_mii     * dump_mii_tx_inst;
  // dump_mii     * dump_mii_rx_inst_0;
  // dump_mii     * dump_mii_rx_inst_1;
  // dump_mii     * dump_mii_rx_inst_2;
  // dump_mii     * dump_mii_rx_inst_3;
  fiber        * fiber_inst;
  dump_output  * dump_output_inst;
  area_timing_wrapper * area_timing_wrapper_inst;

  void clock_assign();
  void reset_generator();
  void reset_mii_tx_generator();
  void valid_rx_generator();
  //void clock_neg();

 SC_CTOR(Top): clk_156("clk_156", 6.4, SC_NS, 0.5, 0.0, SC_NS, false),
               clk_161("clk_161", 6.2, SC_NS, 0.5, 0.0, SC_NS, false),
               clk_312("clk_312", 3.2, SC_NS, 0.5, 0.0, SC_NS, false),
               //tanauan
               clk_156_n("clk_156_n", 6.4, SC_NS, 0.5, 0.0, SC_NS, true),
               clk_161_n("clk_161_n", 6.2, SC_NS, 0.5, 0.0, SC_NS, true),
               clk_312_n("clk_312_n", 3.2, SC_NS, 0.5, 0.0, SC_NS, true),
               iclock156("iclock156"), iclock161("iclock161"), iclock312("iclock312"),
               iclock156n("iclock156n"),iclock312n("iclock312n"),
               iclock161n("iclock161n"), block_from_xgt4("block_from_xgt4"),
               header_from_xgt4("header_from_xgt4"), data_valid_xgt4("data_valid_xgt4"),
               header_valid_xgt4("header_valid_xgt4"), block_from_mac_rx("block_from_mac_rx") {

    // Creating instances
    //tb_xgt4_inst = new tb_xgt4("tb_xgt4","tb_xgt4");
    area_timing_wrapper_inst = new area_timing_wrapper("area_timing_wrapper","area_timing_wrapper");
    scoreboard_inst = new scoreboard("scoreboard");
    pkt_buffer_inst = new pkt_buffer("pkt_buffer");
    // dump_mii_tx_inst = new dump_mii("dump_mii_tx","dump_mii_tx.txt");
    //
    // dump_mii_rx_inst_0 = new dump_mii("dump_mii_rx_0","dump_mii_rx_0.txt");
    // dump_mii_rx_inst_1 = new dump_mii("dump_mii_rx_1","dump_mii_rx_1.txt");
    // dump_mii_rx_inst_2 = new dump_mii("dump_mii_rx_2","dump_mii_rx_2.txt");
    // dump_mii_rx_inst_3 = new dump_mii("dump_mii_rx_3","dump_mii_rx_3.txt");

    dump_output_inst = new dump_output("dump_output", "dump_output.txt");

    fiber_inst  = new fiber("fiber");
    // lane_reorder_inst = new lane_reorder("lane_reorder", "lane_reorder");

    area_timing_wrapper_inst->Q8_CLK0_GTREFCLK_PAD_N_IN(iclock156n);  // clk 156 N
    area_timing_wrapper_inst->Q8_CLK0_GTREFCLK_PAD_P_IN(iclock156);   // clk 156 P
    area_timing_wrapper_inst->SYSCLK_IN_N(iclock161n); //clk 200
    area_timing_wrapper_inst->SYSCLK_IN_P(iclock161); //clk 200

    area_timing_wrapper_inst->rst_n(reset); //clk 200

    area_timing_wrapper_inst->rx_lane_0_header_valid_in(rx_header_valid_in);
    area_timing_wrapper_inst->rx_lane_0_header_in(header_out_0);
    area_timing_wrapper_inst->rx_lane_0_data_valid_in(rx_data_valid_in);
    area_timing_wrapper_inst->rx_lane_0_data_in(block_out_0);

    area_timing_wrapper_inst->rx_lane_1_header_valid_in(rx_header_valid_in);
    area_timing_wrapper_inst->rx_lane_1_header_in(header_out_1);
    area_timing_wrapper_inst->rx_lane_1_data_valid_in(rx_data_valid_in);
    area_timing_wrapper_inst->rx_lane_1_data_in(block_out_1);

    area_timing_wrapper_inst->rx_lane_2_header_valid_in(rx_header_valid_in);
    area_timing_wrapper_inst->rx_lane_2_header_in(header_out_2);
    area_timing_wrapper_inst->rx_lane_2_data_valid_in(rx_data_valid_in);
    area_timing_wrapper_inst->rx_lane_2_data_in(block_out_2);

    area_timing_wrapper_inst->rx_lane_3_header_valid_in(rx_header_valid_in);
    area_timing_wrapper_inst->rx_lane_3_header_in(header_out_3);
    area_timing_wrapper_inst->rx_lane_3_data_valid_in(rx_data_valid_in);
    area_timing_wrapper_inst->rx_lane_3_data_in(block_out_3);

    area_timing_wrapper_inst->pkt_rx_eop(pkt_rx_eop);
    area_timing_wrapper_inst->pkt_rx_err(pkt_rx_err);
    area_timing_wrapper_inst->pkt_rx_mod(pkt_rx_mod);
    area_timing_wrapper_inst->pkt_rx_sop(pkt_rx_sop);
    area_timing_wrapper_inst->pkt_rx_val(pkt_rx_val);
    area_timing_wrapper_inst->pkt_rx_avail(pkt_rx_avail);
    area_timing_wrapper_inst->pkt_rx_data(block_from_mac_rx);

    area_timing_wrapper_inst->mac_data(mac_data);
    area_timing_wrapper_inst->mac_sop(mac_sop);
    area_timing_wrapper_inst->mac_eop(mac_eop);


    // output dumped to file for comparison
    dump_output_inst->clock_in(iclock312);
    dump_output_inst->reset_n(reset);
    dump_output_inst->mac_data(mac_data);
    dump_output_inst->mac_sop(mac_sop);
    dump_output_inst->mac_eop(mac_eop);

    scoreboard_inst->clock_in156(iclock156);

    pkt_buffer_inst->clock_in161(iclock161);
    pkt_buffer_inst->header_in(header_from_xgt4);
    pkt_buffer_inst->block_in(block_from_xgt4);
    pkt_buffer_inst->data_valid_in(rx_data_valid_in);

    // dump_mii_tx_inst->clock_in(iclock156);
    // dump_mii_tx_inst->reset_n(reset);
    // dump_mii_tx_inst->mii_c(dump_xgmii_txc);
    // dump_mii_tx_inst->mii_d(dump_xgmii_txd);
    //
    // dump_mii_rx_inst_0->clock_in(iclock156);
    // dump_mii_rx_inst_0->reset_n(reset);
    // dump_mii_rx_inst_0->mii_c(dump_xgmii_rxc_0);
    // dump_mii_rx_inst_0->mii_d(dump_xgmii_rxd_0);
    //
    // dump_mii_rx_inst_1->clock_in(iclock156);
    // dump_mii_rx_inst_1->reset_n(reset);
    // dump_mii_rx_inst_1->mii_c(dump_xgmii_rxc_1);
    // dump_mii_rx_inst_1->mii_d(dump_xgmii_rxd_1);
    //
    // dump_mii_rx_inst_2->clock_in(iclock156);
    // dump_mii_rx_inst_2->reset_n(reset);
    // dump_mii_rx_inst_2->mii_c(dump_xgmii_rxc_2);
    // dump_mii_rx_inst_2->mii_d(dump_xgmii_rxd_2);
    //
    // dump_mii_rx_inst_3->clock_in(iclock156);
    // dump_mii_rx_inst_3->reset_n(reset);
    // dump_mii_rx_inst_3->mii_c(dump_xgmii_rxc_3);
    // dump_mii_rx_inst_3->mii_d(dump_xgmii_rxd_3);

    fiber_inst->clock_in(iclock161);
    fiber_inst->reset_in(reset);
    fiber_inst->block_out_0(block_out_0);
    fiber_inst->header_out_0(header_out_0);
    fiber_inst->block_out_1(block_out_1);
    fiber_inst->header_out_1(header_out_1);
    fiber_inst->block_out_2(block_out_2);
    fiber_inst->header_out_2(header_out_2);
    fiber_inst->block_out_3(block_out_3);
    fiber_inst->header_out_3(header_out_3);

    SC_METHOD(clock_assign);
    sensitive << clk_156.signal();
    sensitive << clk_161.signal();
    sensitive << clk_312.signal();
    //tanauan
    sensitive << clk_156_n.signal();
    sensitive << clk_161_n.signal();
    sensitive << clk_312_n.signal();
    dont_initialize();

    SC_METHOD(reset_generator);
    sensitive << reset_deactivation_event;

    //tanauan
    // SC_METHOD(clock_neg);
    // sensitive << iclock156;
    // sensitive << iclock312;

    SC_METHOD(reset_mii_tx_generator);
    sensitive << reset_mii_tx_deactivation_event;

    SC_METHOD(valid_rx_generator);
    sensitive << valid_rx_generator_event;

  }
  ~Top () {
    // delete tb_xgt4_inst;
    // delete rx_xgt4_inst;
    // delete scoreboard_inst;
    // delete pkt_buffer_inst;
    // delete dump_mii_rx_inst;
    // delete fiber_inst;
  }

};

// tanauan
// inline void Top::clock_neg() {
//   iclock312_n = (~iclock312);
//   iclock156_n = (~iclock156);
// }

inline void Top::clock_assign()
{
  sc_logic clock_tmp156(clk_156.signal().read());
  iclock156.write(clock_tmp156);

  sc_logic clock_tmp161(clk_161.signal().read());
  iclock161.write(clock_tmp161);

  sc_logic clock_tmp312(clk_312.signal().read());
  iclock312.write(clock_tmp312);

  //tanauan
  sc_logic clock_tmp156n(clk_156_n.signal().read());
  iclock156n.write(clock_tmp156n);

  sc_logic clock_tmp161n(clk_161_n.signal().read());
  iclock161n.write(clock_tmp161n);

  sc_logic clock_tmp312n(clk_312_n.signal().read());
  iclock312n.write(clock_tmp312n);
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
