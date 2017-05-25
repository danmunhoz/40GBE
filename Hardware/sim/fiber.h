#ifndef FIBER
#define FIBER

#include "systemc.h"
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>

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

  ifstream lane0;
  ifstream lane1;
  ifstream lane2;
  ifstream lane3;

  std::pair<std::string, std::string> splitHeaderBlock(std::string val) {
      std::string arg;
      std::string::size_type pos = val.find('-');
      if(val.npos != pos) {
          arg = val.substr(pos + 1);
          val = val.substr(0, pos);
      }
      return std::make_pair(val, arg);
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


    if( lane0.is_open() ) {
      if( lane0 >> line0 ) {
        std::pair<std::string, std::string> pr0 = splitHeaderBlock(line0);
        //cout << "LINE1: " << "Header: " << pr0.first << " Block: " << pr0.second << endl;

        header_out_0_int = pr0.first.c_str();
        block_out_0_int  = pr0.second.c_str();

        header_out_0 = header_out_0_int;
        block_out_0 = block_out_0_int;

        cout << "[fiber 0] Header = " << header_out_0 << " Block = " << block_out_0 << endl;
      }
    } else {
      cout << "[fiber 0]FALHOU LANE 0" << endl;
    }

    if( lane1.is_open() ) {
      if( lane1 >> line1 ) {
        std::pair<std::string, std::string> pr1 = splitHeaderBlock(line1);
        //cout << "LINE1: " << "Header: " << pr1.first << " Block: " << pr1.second << endl;

        header_out_1_int = pr1.first.c_str();
        block_out_1_int  = pr1.second.c_str();

        header_out_1 = header_out_1_int;
        block_out_1 = block_out_1_int;

        cout << "[fiber 1] Header = " << header_out_1 << " Block = " << block_out_1 << endl;
      }
    } else {
      cout << "[fiber 1]FALHOU LANE 1" << endl;
    }

    if( lane2.is_open() ) {
      if( lane2 >> line2 ) {
        std::pair<std::string, std::string> pr2 = splitHeaderBlock(line2);
        //cout << "LINE2: " << "Header: " << pr2.first << " Block: " << pr2.second << endl;

        header_out_2_int = pr2.first.c_str();
        block_out_2_int  = pr2.second.c_str();

        header_out_2 = header_out_2_int;
        block_out_2 = block_out_2_int;

        cout << "[fiber 2] Header = " << header_out_2 << " Block = " << block_out_2 << endl;
      }
    } else {
      cout << "[fiber 2]FALHOU LANE 2" << endl;
    }

    if( lane3.is_open() ) {
      if( lane3 >> line3 ) {
        std::pair<std::string, std::string> pr3 = splitHeaderBlock(line3);
        //cout << "LINE3: " << "Header: " << pr3.first << " Block: " << pr3.second << endl;

        header_out_3_int = pr3.first.c_str();
        block_out_3_int  = pr3.second.c_str();

        header_out_3 = header_out_3_int;
        block_out_3 = block_out_3_int;

        cout << "[fiber 3] Header = " << header_out_3 << " Block = " << block_out_3 << endl;
      }
    } else {
      cout << "[fiber 3]FALHOU LANE 3" << endl;
    }

    //
    // if( lane1 ) {
    //   GotoLine(lane1_local,lineNumber);
    //   // if( std::getline(lane1_local, line1) ) {
    //   if ( lane1_local >> line1 ) {
    //       std::pair<std::string, std::string> pr1 = splitHeaderBlock(line1);
    //       cout << "LINE1: " << "Header: " << pr1.first << " Block: " << pr1.second << endl;
    //   }
    // }
    //
    // if( lane2 ) {
    //   GotoLine(lane2_local,lineNumber);
    //   // if( std::getline(lane2_local, line2) ) {
    //   if(lane2_local >> line2) {
    //       std::pair<std::string, std::string> pr2 = splitHeaderBlock(line2);
    //       cout << "LINE2: " << "Header: " << pr2.first << " Block: " << pr2.second << endl;
    //   }
    // }
    //
    // if( lane3 ) {
    //   GotoLine(lane3_local,lineNumber);
    //   // if( std::getline(lane3_local, line3) ) {
    //   if ( lane3_local >> line3 ) {
    //       std::pair<std::string, std::string> pr3 = splitHeaderBlock(line3);
    //       cout << "LINE3: " << "Header: " << pr3.first << " Block: " << pr3.second << endl;
    //   }
    // }

  }


  SC_CTOR(fiber) {

    lane0.open("lane0_teste.txt");
    if (lane0.is_open()){
      cout << "[fiber] File lane0.txt opened." << endl;
    } else {
      cout << "[fiber] ERROR opening lane0.txt" << endl;
    }

    lane1.open("lane1_teste.txt");
    if (lane1.is_open()){
      cout << "[fiber] File lane1.txt opened." << endl;
    } else {
      cout << "[fiber] ERROR opening lane1.txt" << endl;
    }

    lane2.open("lane2_teste.txt");
    if (lane2.is_open()){
      cout << "[fiber] File lane2.txt opened." << endl;
    } else {
      cout << "[fiber] ERROR opening lane2.txt" << endl;
    }

    lane3.open("lane3_teste.txt");
    if (lane3.is_open()){
      cout << "[fiber] File lane3.txt opened." << endl;
    } else {
      cout << "[fiber] ERROR opening lane3.txt" << endl;
    }

    SC_METHOD(buffer_lanes);
    sensitive<<clock_in;


  }

  ~fiber () {
    cout << "End of simulation!" << endl;
    lane0.close();
    lane1.close();
    lane2.close();
    lane3.close();
  }

};
#endif
