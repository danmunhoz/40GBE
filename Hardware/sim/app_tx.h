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

#define MAX_PL_CYCLES  17
#define MAX_IPG_CYCLES 5
// #define MAX_IPG_CYCLES 1
// #define IPG_CYCLES 3  // IPG_CYCLES sempre > (MAX_PL_CYCLES+1)

SC_MODULE(app_tx) {

  sc_in<sc_logic>   clock_in;
  sc_in<sc_logic>   reset_in;

  sc_out<sc_lv<256 > > data;
  sc_out<sc_lv<5 > >   mod;
  sc_out<sc_lv<2> >    sop;
  sc_out<sc_logic>     eop;
  sc_out<sc_logic>     val;

  int counter;
  int counter_pkt;

  int IPG_CYCLES;

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
    static int end = 0;

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

        // } else if (counter > 2 && counter < MAX_PL_CYCLES) {
        } else if (counter > 2 && counter <= (MAX_PL_CYCLES - 1)) {
          // PAYLOAD
          sop = "00";
          eop = SC_LOGIC_1;
          val = SC_LOGIC_1;
          mod = "00000";
          if (counter + 1 == 4) {
            data = ((sc_lv<64 >)(counter_pkt),(sc_lv<64 >)(counter_pkt),(sc_lv<64 >)(counter_pkt),(sc_lv<64 >)(counter_pkt));
          }
          else{
            data = ((sc_lv<64 >)(counter+1),(sc_lv<64 >)(counter+1),(sc_lv<64 >)(counter+1),(sc_lv<64 >)(counter+1));
          }

        // EOP
        } else if (counter == (MAX_PL_CYCLES )) {
          sop = "00";
          eop = SC_LOGIC_0;
          val = SC_LOGIC_1;
          mod = sc_lv<5 >(end);
          data = ((sc_lv<256 >)(-1));
          end++;
          counter_pkt = counter_pkt +1;



        // // 1 ciclo de espera
        // } else if (counter == MAX_PL_CYCLES) {
        //   sop = "00";
        //   eop = SC_LOGIC_1;
        //   val = SC_LOGIC_0;
        //   mod = "00000";
        //   data = (sc_lv<256 >)0;
        //   // counter_pkt = counter_pkt +1;
        //   if (IPG_CYCLES == (MAX_PL_CYCLES+1))
        //     counter = 1;

        // IDLE
      } else if (counter >= MAX_PL_CYCLES && counter <= (MAX_PL_CYCLES + IPG_CYCLES)) {
          sop = "00";
          eop = SC_LOGIC_1;
          val = SC_LOGIC_0;
          mod = "00000";
          data = (sc_lv<256 >)0;

          if (counter == (MAX_PL_CYCLES + IPG_CYCLES)) {
            // reset counter
            counter = 1;
            if (counter_pkt % 2 == 0) {
              if (IPG_CYCLES == MAX_IPG_CYCLES)
                IPG_CYCLES = 1;
              else
                IPG_CYCLES = IPG_CYCLES + 1;
            }
          }

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

    IPG_CYCLES = 1;

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
