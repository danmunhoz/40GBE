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

SC_MODULE(app_tx) {

  sc_in<sc_logic>   clock_in;
  sc_in<sc_logic>   reset_in;

  sc_out<sc_lv<256 > > data;
  sc_out<sc_lv<5 > > mod;
  sc_out<sc_logic>  sop;
  sc_out<sc_logic>  eop;
  sc_out<sc_logic>  val;

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

    sc_lv<8 >  ctrl_int;
    sc_lv<64 > data_int;

    if (reset_in == SC_LOGIC_1) {       // RESET ativo baixo

      if( in_file.is_open() ) {
        if( in_file >> line0 ) {
          line pr0 = splitHeaderBlock(line0);

          ctrl_int = pr0.ctrl.c_str();
          data_int  = pr0.data.c_str();

          data = (data_int,data_int,data_int,data_int); // Enquanto nao passarmos um pacote de verdade...

          cout << "[app_tx] ctrl_int : " << ctrl_int << endl;
          cout << "[app_tx] data     : " << data << endl;

          if (ctrl_int == "00000001") { //Assuming packets are starting at byte 0...
            sop = SC_LOGIC_1;
            eop = SC_LOGIC_0;
            val = SC_LOGIC_0;
            mod = "00000";
          } else if (ctrl_int == "11110000"){ // TODO: calcular todos eops....!
            sop = SC_LOGIC_0;
            eop = SC_LOGIC_0;
            val = SC_LOGIC_0;
            mod = "01111";
          } else {
            sop = SC_LOGIC_0;
            eop = SC_LOGIC_0;
            val = SC_LOGIC_0;
            mod = "00000";
          }
        } else {
          cout << "[app_tx] no lines left on input file." << endl;
        }
      } else {
        cout << "[app_tx] input file not open." << endl;
      }

    } else {
      mod = "00000";
      sop = SC_LOGIC_0;
      eop = SC_LOGIC_0;
      val = SC_LOGIC_0;
      data  = "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
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
