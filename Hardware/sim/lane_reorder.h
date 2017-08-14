#ifndef _SCGENMOD_lane_reorder_
#define _SCGENMOD_lane_reorder_

#include "systemc.h"

class lane_reorder : public sc_foreign_module
{
public:
    sc_in<sc_logic> clock;
    sc_in<sc_logic> reset;
    sc_in<sc_lv<64> > lane_0_data_in;
    sc_in<sc_lv<64> > lane_1_data_in;
    sc_in<sc_lv<64> > lane_2_data_in;
    sc_in<sc_lv<64> > lane_3_data_in;
    sc_in<sc_lv<2> > lane_0_header_in;
    sc_in<sc_lv<2> > lane_1_header_in;
    sc_in<sc_lv<2> > lane_2_header_in;
    sc_in<sc_lv<2> > lane_3_header_in;
    sc_out<sc_lv<64> > pcs_0_data_out;
    sc_out<sc_lv<64> > pcs_1_data_out;
    sc_out<sc_lv<64> > pcs_2_data_out;
    sc_out<sc_lv<64> > pcs_3_data_out;
    sc_out<sc_lv<2> > pcs_0_header_out;
    sc_out<sc_lv<2> > pcs_1_header_out;
    sc_out<sc_lv<2> > pcs_2_header_out;
    sc_out<sc_lv<2> > pcs_3_header_out;


    lane_reorder(sc_module_name nm, const char* hdl_name)
     : sc_foreign_module(nm),
       clock("clock"),
       reset("reset"),
       lane_0_data_in("lane_0_data_in"),
       lane_1_data_in("lane_1_data_in"),
       lane_2_data_in("lane_2_data_in"),
       lane_3_data_in("lane_3_data_in"),
       lane_0_header_in("lane_0_header_in"),
       lane_1_header_in("lane_1_header_in"),
       lane_2_header_in("lane_2_header_in"),
       lane_3_header_in("lane_3_header_in"),
       pcs_0_data_out("pcs_0_data_out"),
       pcs_1_data_out("pcs_1_data_out"),
       pcs_2_data_out("pcs_2_data_out"),
       pcs_3_data_out("pcs_3_data_out"),
       pcs_0_header_out("pcs_0_header_out"),
       pcs_1_header_out("pcs_1_header_out"),
       pcs_2_header_out("pcs_2_header_out"),
       pcs_3_header_out("pcs_3_header_out")
    {
        elaborate_foreign_module(hdl_name);
    }
    ~lane_reorder()
    {}

};

#endif

