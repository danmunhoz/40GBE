#ifndef _SCGENMOD_rx_xgt4_
#define _SCGENMOD_rx_xgt4_

#include "systemc.h"

class rx_xgt4 : public sc_foreign_module
{
public:
    sc_in<sc_logic> clock_in156;
    sc_in<sc_logic> clock_in161;
    sc_in<sc_logic> reset_in;
    sc_in<sc_logic> reset_in_mii_tx;
    sc_in<sc_logic> reset_in_mii_rx;
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
    sc_out<sc_lv<8> > dump_xgmii_rxc;
    sc_out<sc_lv<64> > dump_xgmii_rxd;


    rx_xgt4(sc_module_name nm, const char* hdl_name)
     : sc_foreign_module(nm),
       clock_in156("clock_in156"),
       clock_in161("clock_in161"),
       reset_in("reset_in"),
       reset_in_mii_tx("reset_in_mii_tx"),
       reset_in_mii_rx("reset_in_mii_rx"),
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
       dump_xgmii_rxc("dump_xgmii_rxc"),
       dump_xgmii_rxd("dump_xgmii_rxd")
    {
        elaborate_foreign_module(hdl_name);
    }
    ~rx_xgt4()
    {}

};

#endif

