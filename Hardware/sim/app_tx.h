#ifndef APP_TX
#define APP_TX

#include "systemc.h"
#include <sstream>
#include <iostream>
#include <string>
#include <iostream>
#include <fstream>

struct line {
  std::string data;
  std::string ctrl;
};

#define MAX_PL_CYCLES 16
#define MAX_IPG_CYCLES MAX_PL_CYCLES + 2  // MAX_IPG_CYCLES sempre > (MAX_PL_CYCLES+1)

SC_MODULE(app_tx) {

  sc_in<sc_logic>   clock_in;
  sc_in<sc_logic>   reset_in;

  sc_out<sc_lv<256 > > data;
  sc_out<sc_lv<5 > >   mod;
  sc_out<sc_lv<2> >    sop;
  sc_out<sc_logic>     eop;
  sc_out<sc_logic>     val;

  int counter;

  bool shift;

  ifstream in_file;
  sc_event reset_event;

  line splitHeaderBlock(std::string val) {
    line ret;
    std::string::size_type pos = val.find('-');
    if(val.npos != pos) {
        ret.data = val.substr(pos + 1);
        ret.ctrl = val.substr(0, pos);
    }
    return ret;
  }

  void buffer_lanes() {
    line pr0;
    std::string line0;

    if (reset_in == SC_LOGIC_1) {       // RESET ativo baixo

        counter = counter + 1;

        if (counter == 2) {
          if(shift) {
            // SOP
            sop = "11";
            eop = SC_LOGIC_1;
            val = SC_LOGIC_1;
            mod = "00000";
            // data = ((sc_lv<64 >)(counter+2),(sc_lv<64 >)(counter+1),(sc_lv<64 >)0,(sc_lv<64 >)0); // Enquanto nao passarmos um pacote de verdade...
            data = ((sc_lv<64 >)(counter-1),(sc_lv<64 >)(counter-2),(sc_lv<64 >)0,(sc_lv<64 >)0); // tanauan
          } else {
            sop = "10";
            eop = SC_LOGIC_1;
            val = SC_LOGIC_1;
            mod = "00000";
            // data = ((sc_lv<64 >)(counter+4),(sc_lv<64 >)(counter+3),(sc_lv<64 >)(counter+2),(sc_lv<64 >)(counter+1)); // Enquanto nao passarmos um pacote de verdade...
            data = ((sc_lv<64 >)(counter+1),(sc_lv<64 >)(counter),(sc_lv<64 >)(counter-1),(sc_lv<64 >)(counter-2)); // tanauan
          }

          shift = !shift;

        } else if (counter > 2 && counter < MAX_PL_CYCLES) {
          // PAYLOAD
          sop = "00";
          eop = SC_LOGIC_1;
          val = SC_LOGIC_1;
          mod = "00000";
          data = ((sc_lv<64 >)(counter+1),(sc_lv<64 >)(counter+1),(sc_lv<64 >)(counter+1),(sc_lv<64 >)(counter+1));

        } else if (counter == MAX_PL_CYCLES) {
          // EOP
          sop = "00";
          eop = SC_LOGIC_0;
          val = SC_LOGIC_1;
          mod = "01011";
          data = ((sc_lv<64 >)0, (sc_lv<64 >)0, (sc_lv<64 >)2964376266, (sc_lv<64 >)counter);

        } else if (counter > MAX_PL_CYCLES && counter < MAX_IPG_CYCLES) {
          // IDLE
          sop = "00";
          eop = SC_LOGIC_1;
          val = SC_LOGIC_0;
          mod = "00000";
          data = (sc_lv<256 >)0;

        } else if (counter == MAX_IPG_CYCLES) {
          // reset counter
          data = (sc_lv<256 >)0;
          counter = 1;
        }

    } else {
      mod = "00000";
      sop = "00";
      eop = SC_LOGIC_1;
      val = SC_LOGIC_0;
      data = (sc_lv<256 >)0;
      counter  = 0;
      shift = false;
    }
  }


  SC_CTOR(app_tx) {

    in_file.open("dump_app.txt");
    if (in_file.is_open()){
      cout << "[app_tx] File dump_mii_tx.txt opened." << endl;
    } else {
      cout << "[app_tx] ERROR opening dump_mii_tx.txt" << endl;
    }

    SC_METHOD(buffer_lanes);
    dont_initialize();
    sensitive<<clock_in.pos();

  }

  ~app_tx () {
    in_file.close();
  }

};
#endif
