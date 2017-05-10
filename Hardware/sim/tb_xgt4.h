#ifndef _SCGENMOD_tb_xgt4_
#define _SCGENMOD_tb_xgt4_

#include "systemc.h"

class tb_xgt4 : public sc_foreign_module
{
public:
    sc_in<sc_logic> clock_in156;
    sc_in<sc_logic> clock_in161;
    sc_in<sc_logic> reset_in;
    sc_in<sc_logic> reset_in_mii_tx;
    sc_in<sc_logic> reset_in_mii_rx;
    sc_out<sc_lv<64> > data_out;
    sc_out<sc_lv<2> > header_out;


    tb_xgt4(sc_module_name nm, const char* hdl_name)
     : sc_foreign_module(nm),
       clock_in156("clock_in156"),
       clock_in161("clock_in161"),
       reset_in("reset_in"),
       reset_in_mii_tx("reset_in_mii_tx"),
       reset_in_mii_rx("reset_in_mii_rx"),
       data_out("data_out"),
       header_out("header_out")
    {
        elaborate_foreign_module(hdl_name);
    }
    ~tb_xgt4()
    {}

};

#endif

