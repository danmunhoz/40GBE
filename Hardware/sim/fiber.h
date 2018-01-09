#ifndef FIBER
#define FIBER

#include "systemc.h"
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>
#include <time.h>

#define PICK_RANDOM_ORDER 0

// It counts from time ZERO (not from reset)
#define SKEW_0_NS 40
#define SKEW_1_NS 45
#define SKEW_2_NS 87
#define SKEW_3_NS 100

SC_MODULE(fiber) {

  sc_in<sc_logic>   clock_in;
  sc_in<sc_logic>   reset_in;

  sc_in<sc_logic>   data_valid_in;

  sc_out<sc_lv<64 > > block_out_0;
  sc_out<sc_lv<2 > >  header_out_0;
  sc_out<sc_lv<64 > > block_out_1;
  sc_out<sc_lv<2 > >  header_out_1;
  sc_out<sc_lv<64 > > block_out_2;
  sc_out<sc_lv<2 > >  header_out_2;
  sc_out<sc_lv<64 > > block_out_3;
  sc_out<sc_lv<2 > >  header_out_3;

  ifstream lanes[4];
  ifstream lanes_shuffled[4];

  sc_event skew_event_0;
  sc_event skew_event_1;
  sc_event skew_event_2;
  sc_event skew_event_3;
  sc_event reset_event;

  sc_signal<sc_logic> skew_ok_0;
  sc_signal<sc_logic> skew_ok_1;
  sc_signal<sc_logic> skew_ok_2;
  sc_signal<sc_logic> skew_ok_3;
  sc_signal<sc_logic> reset_event_sig;

  std::pair<std::string, std::string> splitHeaderBlock(std::string val) {
      std::string arg;
      std::string::size_type pos = val.find('-');
      if(val.npos != pos) {
          arg = val.substr(pos + 1);
          val = val.substr(0, pos);
      }
      return std::make_pair(val, arg);
  }

  void skew_lane_0() {
    static bool f = true;

    if(f){
      f = false;
      skew_event_0.notify(SKEW_0_NS, SC_NS);
      skew_ok_0 = SC_LOGIC_0;
    }
    else {
      skew_ok_0 = SC_LOGIC_1;
    }
  }

  void skew_lane_1() {
    static bool f = true;

    if(f) {
      f = false;
      skew_event_1.notify(SKEW_1_NS, SC_NS);
      skew_ok_1 = SC_LOGIC_0;
    } else {
      skew_ok_1 = SC_LOGIC_1;
    }
  }

  void skew_lane_2() {
    static bool f = true;

    if(f) {
      f = false;
      skew_event_2.notify(SKEW_2_NS, SC_NS);
      skew_ok_2 = SC_LOGIC_0;
    } else {
      skew_ok_2 = SC_LOGIC_1;
    }
  }

  void skew_lane_3() {
    static bool f = true;

    if(f) {
      f = false;
      skew_event_3.notify(SKEW_3_NS, SC_NS);
      skew_ok_3 = SC_LOGIC_0;
    } else {
      skew_ok_3 = SC_LOGIC_1;
    }
  }

  void reset_flag() {
    static bool f = true;

    if(f) {
      f = false;
      reset_event_sig = SC_LOGIC_0;
    } else {
      reset_event_sig = SC_LOGIC_1;
    }
  }

  void buffer_lanes() {

    std::pair<std::string, std::string> pr0;
    std::pair<std::string, std::string> pr1;
    std::pair<std::string, std::string> pr2;
    std::pair<std::string, std::string> pr3;

    std::string line0;
    std::string line1;
    std::string line2;
    std::string line3;

    sc_lv<2 >  header_out_0_int;
    sc_lv<64 > block_out_0_int;
    sc_lv<2 >  header_out_1_int;
    sc_lv<64 > block_out_1_int;
    sc_lv<2 >  header_out_2_int;
    sc_lv<64 > block_out_2_int;
    sc_lv<2 >  header_out_3_int;
    sc_lv<64 > block_out_3_int;

    if (reset_in == SC_LOGIC_1) {       // RESET ativo baixo
        if( lanes_shuffled[0].is_open() && skew_ok_0 == SC_LOGIC_1) {
          if( lanes_shuffled[0] >> line0 ) {
            std::pair<std::string, std::string> pr0 = splitHeaderBlock(line0);
            //cout << "LINE1: " << "Header: " << pr0.first << " Block: " << pr0.second << endl;

            header_out_0_int = pr0.first.c_str();
            block_out_0_int  = pr0.second.c_str();

            header_out_0 = header_out_0_int;
            block_out_0 = block_out_0_int;

            // cout << "[fiber 0] Header = " << header_out_0 << " Block = " << block_out_0 << endl;
          }
        } else {
          cout << "[fiber 0]FALHOU lanes 0" << endl;
        }

        if( lanes_shuffled[1].is_open() && skew_ok_1 == SC_LOGIC_1) {
          if( lanes_shuffled[1] >> line1 ) {
            std::pair<std::string, std::string> pr1 = splitHeaderBlock(line1);
            //cout << "LINE1: " << "Header: " << pr1.first << " Block: " << pr1.second << endl;

            header_out_1_int = pr1.first.c_str();
            block_out_1_int  = pr1.second.c_str();

            header_out_1 = header_out_1_int;
            block_out_1 = block_out_1_int;

            // cout << "[fiber 1] Header = " << header_out_1 << " Block = " << block_out_1 << endl;
          }
        } else {
          cout << "[fiber 1]FALHOU lanes 1" << endl;
        }

        if( lanes_shuffled[2].is_open() && skew_ok_2 == SC_LOGIC_1) {
          if( lanes_shuffled[2] >> line2 ) {
            std::pair<std::string, std::string> pr2 = splitHeaderBlock(line2);
            //cout << "LINE2: " << "Header: " << pr2.first << " Block: " << pr2.second << endl;

            header_out_2_int = pr2.first.c_str();
            block_out_2_int  = pr2.second.c_str();

            header_out_2 = header_out_2_int;
            block_out_2 = block_out_2_int;

            // cout << "[fiber 2] Header = " << header_out_2 << " Block = " << block_out_2 << endl;
          }
        } else {
          cout << "[fiber 2]FALHOU lanes 2" << endl;
        }

        if( lanes_shuffled[3].is_open() && skew_ok_3 == SC_LOGIC_1) {
          if( lanes_shuffled[3] >> line3 ) {
            std::pair<std::string, std::string> pr3 = splitHeaderBlock(line3);
            //cout << "LINE3: " << "Header: " << pr3.first << " Block: " << pr3.second << endl;

            header_out_3_int = pr3.first.c_str();
            block_out_3_int  = pr3.second.c_str();

            header_out_3 = header_out_3_int;
            block_out_3 = block_out_3_int;

            // cout << "[fiber 3] Header = " << header_out_3 << " Block = " << block_out_3 << endl;
          }
        } else {
          cout << "[fiber 3]FALHOU lanes 3" << endl;
        }
    } else {
      header_out_0 = "00";
      block_out_0  = "0000000000000000000000000000000000000000000000000000000000000000";
      header_out_1 = "00";
      block_out_1  = "0000000000000000000000000000000000000000000000000000000000000000";
      header_out_2 = "00";
      block_out_2  = "0000000000000000000000000000000000000000000000000000000000000000";
      header_out_3 = "00";
      block_out_3  = "0000000000000000000000000000000000000000000000000000000000000000";
    }
  }


  SC_CTOR(fiber) {

    lanes[0].open("lane0_rx.txt");
    if (lanes[0].is_open()){
      cout << "[fiber] File lanes[0].txt opened." << endl;
    } else {
      cout << "[fiber] ERROR opening lanes[0].txt" << endl;
    }

    lanes[1].open("lane1_rx.txt");
    if (lanes[1].is_open()){
      cout << "[fiber] File lanes[1].txt opened." << endl;
    } else {
      cout << "[fiber] ERROR opening lanes[1].txt" << endl;
    }

    lanes[2].open("lane2_rx.txt");
    if (lanes[2].is_open()){
      cout << "[fiber] File lanes[2].txt opened." << endl;
    } else {
      cout << "[fiber] ERROR opening lanes[2].txt" << endl;
    }

    lanes[3].open("lane3_rx.txt");
    if (lanes[3].is_open()){
      cout << "[fiber] File lanes[3].txt opened." << endl;
    } else {
      cout << "[fiber] ERROR opening lanes[3].txt" << endl;
    }

    int size = sizeof(ifstream);
    if(PICK_RANDOM_ORDER) {
      srand ( (unsigned int) time (0) );
      int r;
      int used_lanes[4] = {0};
      for(int i = 4; i > 0; i --) {
        r = rand() % i;
        if (used_lanes[r] == 1) {
          for(int j=0; j < 4; j++) {
            if (used_lanes[j] == 0)
              r = j;
            }
        }
        memcpy (&lanes_shuffled[4 - i], &lanes[r], size);
        used_lanes[r] = 1;
      }
    } else {
      for(int i = 0;i < 4;i++) {
        memcpy (&lanes_shuffled[i], &lanes[i], size);
      }
    }

    SC_METHOD(buffer_lanes);
    dont_initialize();
    sensitive<<clock_in.pos();

    SC_METHOD(skew_lane_0);
    sensitive<<skew_event_0<<reset_in.pos();

    SC_METHOD(skew_lane_1);
    sensitive<<skew_event_1;

    SC_METHOD(skew_lane_2);
    sensitive<<skew_event_2;

    SC_METHOD(skew_lane_3);
    sensitive<<skew_event_3;

    SC_METHOD(reset_flag);
    sensitive<<reset_in.pos();
  }

  ~fiber () {
    cout << "End of simulation!" << endl;
    for(int i=0; i < 4; i++) {
      lanes_shuffled[i].close();
      lanes[i].close();
    }
  }

};
#endif
