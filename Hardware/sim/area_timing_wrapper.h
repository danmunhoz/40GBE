#ifndef _SCGENMOD_area_timing_wrapper_
#define _SCGENMOD_area_timing_wrapper_

#include "systemc.h"

class area_timing_wrapper : public sc_foreign_module
{
public:
    sc_in<sc_logic> Q8_CLK0_GTREFCLK_PAD_N_IN;
    sc_in<sc_logic> Q8_CLK0_GTREFCLK_PAD_P_IN;
    sc_in<sc_logic> SYSCLK_IN_N;
    sc_in<sc_logic> SYSCLK_IN_P;
    sc_in<sc_logic> rst_n;
    sc_out<sc_logic> hi_ber;
    sc_out<sc_logic> blk_lock;
    sc_out<sc_logic> linkstatus;
    sc_out<sc_logic> rx_fifo_spill;
    sc_out<sc_logic> tx_fifo_spill;
    sc_out<sc_logic> rxlf;
    sc_out<sc_logic> txlf;
    sc_out<sc_lv<6> > ber_cnt;
    sc_out<sc_lv<8> > errd_blks;
    sc_out<sc_lv<16> > jtest_errc;
    sc_out<sc_lv<64> > tx_data_out;
    sc_out<sc_lv<2> > tx_header_out;
    sc_out<sc_logic> rxgearboxslip_out;
    sc_out<sc_lv<7> > tx_sequence_out;
    sc_out<sc_logic> mac_sop;
    sc_out<sc_lv<128> > mac_data;
    sc_out<sc_lv<5> > mac_eop;
    sc_in<sc_lv<8> > wb_adr_i;
    sc_in<sc_logic> wb_clk_i;
    sc_in<sc_logic> wb_cyc_i;
    sc_in<sc_lv<32> > wb_dat_i;
    sc_in<sc_logic> wb_stb_i;
    sc_in<sc_logic> wb_we_i;
    sc_in<sc_logic> rx_lane_0_header_valid_in;
    sc_in<sc_lv<2> > rx_lane_0_header_in;
    sc_in<sc_logic> rx_lane_0_data_valid_in;
    sc_in<sc_lv<64> > rx_lane_0_data_in;
    sc_in<sc_logic> rx_lane_1_header_valid_in;
    sc_in<sc_lv<2> > rx_lane_1_header_in;
    sc_in<sc_logic> rx_lane_1_data_valid_in;
    sc_in<sc_lv<64> > rx_lane_1_data_in;
    sc_in<sc_logic> rx_lane_2_header_valid_in;
    sc_in<sc_lv<2> > rx_lane_2_header_in;
    sc_in<sc_logic> rx_lane_2_data_valid_in;
    sc_in<sc_lv<64> > rx_lane_2_data_in;
    sc_in<sc_logic> rx_lane_3_header_valid_in;
    sc_in<sc_lv<2> > rx_lane_3_header_in;
    sc_in<sc_logic> rx_lane_3_data_valid_in;
    sc_in<sc_lv<64> > rx_lane_3_data_in;
    sc_out<sc_logic> pkt_rx_avail;
    sc_out<sc_lv<64> > pkt_rx_data;
    sc_out<sc_logic> pkt_rx_eop;
    sc_out<sc_logic> pkt_rx_err;
    sc_out<sc_lv<3> > pkt_rx_mod;
    sc_out<sc_logic> pkt_rx_sop;
    sc_out<sc_logic> pkt_rx_val;
    sc_out<sc_logic> pkt_tx_full;


    area_timing_wrapper(sc_module_name nm, const char* hdl_name)
     : sc_foreign_module(nm),
       Q8_CLK0_GTREFCLK_PAD_N_IN("Q8_CLK0_GTREFCLK_PAD_N_IN"),
       Q8_CLK0_GTREFCLK_PAD_P_IN("Q8_CLK0_GTREFCLK_PAD_P_IN"),
       SYSCLK_IN_N("SYSCLK_IN_N"),
       SYSCLK_IN_P("SYSCLK_IN_P"),
       rst_n("rst_n"),
       hi_ber("hi_ber"),
       blk_lock("blk_lock"),
       linkstatus("linkstatus"),
       rx_fifo_spill("rx_fifo_spill"),
       tx_fifo_spill("tx_fifo_spill"),
       rxlf("rxlf"),
       txlf("txlf"),
       ber_cnt("ber_cnt"),
       errd_blks("errd_blks"),
       jtest_errc("jtest_errc"),
       tx_data_out("tx_data_out"),
       tx_header_out("tx_header_out"),
       rxgearboxslip_out("rxgearboxslip_out"),
       tx_sequence_out("tx_sequence_out"),
       mac_sop("mac_sop"),
       mac_data("mac_data"),
       mac_eop("mac_eop"),
       wb_adr_i("wb_adr_i"),
       wb_clk_i("wb_clk_i"),
       wb_cyc_i("wb_cyc_i"),
       wb_dat_i("wb_dat_i"),
       wb_stb_i("wb_stb_i"),
       wb_we_i("wb_we_i"),
       rx_lane_0_header_valid_in("rx_lane_0_header_valid_in"),
       rx_lane_0_header_in("rx_lane_0_header_in"),
       rx_lane_0_data_valid_in("rx_lane_0_data_valid_in"),
       rx_lane_0_data_in("rx_lane_0_data_in"),
       rx_lane_1_header_valid_in("rx_lane_1_header_valid_in"),
       rx_lane_1_header_in("rx_lane_1_header_in"),
       rx_lane_1_data_valid_in("rx_lane_1_data_valid_in"),
       rx_lane_1_data_in("rx_lane_1_data_in"),
       rx_lane_2_header_valid_in("rx_lane_2_header_valid_in"),
       rx_lane_2_header_in("rx_lane_2_header_in"),
       rx_lane_2_data_valid_in("rx_lane_2_data_valid_in"),
       rx_lane_2_data_in("rx_lane_2_data_in"),
       rx_lane_3_header_valid_in("rx_lane_3_header_valid_in"),
       rx_lane_3_header_in("rx_lane_3_header_in"),
       rx_lane_3_data_valid_in("rx_lane_3_data_valid_in"),
       rx_lane_3_data_in("rx_lane_3_data_in"),
       pkt_rx_avail("pkt_rx_avail"),
       pkt_rx_data("pkt_rx_data"),
       pkt_rx_eop("pkt_rx_eop"),
       pkt_rx_err("pkt_rx_err"),
       pkt_rx_mod("pkt_rx_mod"),
       pkt_rx_sop("pkt_rx_sop"),
       pkt_rx_val("pkt_rx_val"),
       pkt_tx_full("pkt_tx_full")
    {
        elaborate_foreign_module(hdl_name);
    }
    ~area_timing_wrapper()
    {}

};

#endif

