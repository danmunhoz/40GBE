#ifndef _SCGENMOD_shuffle_
#define _SCGENMOD_shuffle_

#include "systemc.h"

class shuffle : public sc_foreign_module
{
public:
    sc_in<sc_lv<67> > in_0;
    sc_in<sc_lv<67> > in_1;
    sc_in<sc_lv<67> > in_2;
    sc_in<sc_lv<67> > in_3;
    sc_out<sc_lv<67> > out_0;
    sc_out<sc_lv<67> > out_1;
    sc_out<sc_lv<67> > out_2;
    sc_out<sc_lv<67> > out_3;
    sc_in<sc_lv<2> > lane_0;
    sc_in<sc_lv<2> > lane_1;
    sc_in<sc_lv<2> > lane_2;
    sc_in<sc_lv<2> > lane_3;


    shuffle(sc_module_name nm, const char* hdl_name,
       int num_generics, const char** generic_list)
     : sc_foreign_module(nm),
       in_0("in_0"),
       in_1("in_1"),
       in_2("in_2"),
       in_3("in_3"),
       out_0("out_0"),
       out_1("out_1"),
       out_2("out_2"),
       out_3("out_3"),
       lane_0("lane_0"),
       lane_1("lane_1"),
       lane_2("lane_2"),
       lane_3("lane_3")
    {
        elaborate_foreign_module(hdl_name, num_generics, generic_list);
    }
    ~shuffle()
    {}

};

#endif

