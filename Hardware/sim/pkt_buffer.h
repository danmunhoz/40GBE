/*
**  Modulo para enviar blocks do PCS tx -> PCS rx
**
*/

#ifndef PKT_BUFFER
#define PKT_BUFFER

#include "systemc.h"
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>

#define PKTS_BTW_SYNC 16383

/* SYNC_LANEx_LOW BIP SYNC_LANEx_HIGH BIP */
#define SYNC_LANE0_LOW  100100000111011001000111    // 0x907647
#define SYNC_LANE1_LOW  111100001100010011100110    // 0xf0c4e6
#define SYNC_LANE2_LOW  110001010110010110011011    // 0xc5659b
#define SYNC_LANE3_LOW  101000100111100100111101    // 0xa2793d
#define SYNC_LANE0_HIGH 011011111000100110111000    // 0x6f89b8
#define SYNC_LANE1_HIGH 000011110011101100011001    // 0x0f3b19
#define SYNC_LANE2_HIGH 001110101001101001100100    // 0x3a9a64
#define SYNC_LANE3_HIGH 010111011000011011000010    // 0x5d86c2

SC_MODULE(pkt_buffer) {

  sc_in<sc_logic>   clock_in161;
  sc_in<sc_logic>   reset_n;

  sc_in<sc_lv<64> > block_in;
  sc_in<sc_lv<2> >  header_in;
  sc_in<sc_logic>   data_valid_in;

  long int block_counter;

  ofstream lane0;
  ofstream lane1;
  ofstream lane2;
  ofstream lane3;

  void tx(void) {
    std::stringstream buffer;
    int lane = 0;

    if ( data_valid_in == SC_LOGIC_1 ) {
      // cout << "HEADER_IN VALUE: " << header_in << endl;
      // cout << "BLOCK_IN  VALUE:" << block_in << endl;
      buffer << header_in << "-" << block_in;

      lane = block_counter % 4;
      switch (lane) {
        case 0:
          lane0 << buffer.str() << endl;
          block_counter++;
          break;
        case 1:
          lane1 << buffer.str() << endl;
          block_counter++;
          break;
        case 2:
          lane2 << buffer.str() << endl;
          block_counter++;
          break;
        case 3:
          lane3 << buffer.str() << endl;
          block_counter++;
          break;
        default:
          cout << "Ooops" << endl;
      }

      if( block_counter == PKTS_BTW_SYNC) {
        lane0 << SYNC_LANE0_LOW << /*bip*/ << SYNC_LANE0_HIGH << /*bip*/ << endl;
        lane1 << SYNC_LANE1_LOW << /*bip*/ << SYNC_LANE1_HIGH << /*bip*/ << endl;
        lane2 << SYNC_LANE2_LOW << /*bip*/ << SYNC_LANE2_HIGH << /*bip*/ << endl;
        lane3 << SYNC_LANE3_LOW << /*bip*/ << SYNC_LANE3_HIGH << /*bip*/ << endl;
      }

    }
  }

  SC_CTOR(pkt_buffer) {
    block_counter = 0;

    lane0.open("lane0.txt");
    if (lane0.is_open()){
      cout << "File lane0.txt opened" << endl;
    } else {
      cout << "ERROR opening lane0.txt" << endl;
    }

    lane1.open("lane1.txt");
    if (lane1.is_open()){
      cout << "File lane1.txt opened" << endl;
    } else {
      cout << "ERROR opening lane1.txt" << endl;
    }

    lane2.open("lane2.txt");
    if (lane2.is_open()){
      cout << "File lane2.txt opened" << endl;
    } else {
      cout << "ERROR opening lane2.txt" << endl;
    }

    lane3.open("lane3.txt");
    if (lane3.is_open()){
      cout << "File lane3.txt opened" << endl;
    } else {
      cout << "ERROR opening lane3.txt" << endl;
    }

    SC_METHOD(tx);
    sensitive<<clock_in161;

  }

  ~pkt_buffer () {
    lane0.close();
    lane1.close();
    lane2.close();
    lane3.close();
  }

};

#endif
