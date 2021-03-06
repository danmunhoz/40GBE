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
#include <limits>

//#define PKTS_BTW_SYNC 16383
#define PKTS_BTW_SYNC 32

/* SYNC_LANEx_LOW BIP SYNC_LANEx_HIGH BIP */
#define SYNC_LANE0_LOW  "100100000111011001000111"    // 0x907647
#define SYNC_LANE1_LOW  "111100001100010011100110"    // 0xf0c4e6
#define SYNC_LANE2_LOW  "110001010110010110011011"    // 0xc5659b
#define SYNC_LANE3_LOW  "101000100111100100111101"    // 0xa2793d
#define SYNC_LANE0_HIGH "011011111000100110111000"    // 0x6f89b8
#define SYNC_LANE1_HIGH "000011110011101100011001"    // 0x0f3b19
#define SYNC_LANE2_HIGH "001110101001101001100100"    // 0x3a9a64
#define SYNC_LANE3_HIGH "010111011000011011000010"    // 0x5d86c2

SC_MODULE(pkt_buffer) {

  sc_in<sc_logic>   clock_in161;
  sc_in<sc_logic>   reset_n;

  sc_in<sc_lv<64> > block_in;
  sc_in<sc_lv<2> >  header_in;
  sc_in<sc_logic>   data_valid_in;

  sc_out<sc_lv<64 > > block_out_0;
  sc_out<sc_lv<2 > >  header_out_0;

  sc_out<sc_lv<64 > > block_out_1;
  sc_out<sc_lv<2 > >  header_out_1;

  sc_out<sc_lv<64 > > block_out_2;
  sc_out<sc_lv<2 > >  header_out_2;

  sc_out<sc_lv<64 > > block_out_3;
  sc_out<sc_lv<2 > >  header_out_3;

  long int block_counter;

  ofstream lane0;
  ofstream lane1;
  ofstream lane2;
  ofstream lane3;

  void bip_calculator (sc_lv<8 > *lane_bip, const sc_lv<64 > block_in_lv, const sc_lv<2 > header_in_lv, int debug = 0) {

    sc_logic aux;

    sc_lv<64 > block_in_lv_little;

    block_in_lv_little.range(0,63) =  block_in_lv;
    if (debug)
      cout << "CALC_BIP_call: " << header_in_lv << block_in_lv << endl;

    if (debug)
      cout << "CALC_BIP_call: " << endl;

    for (int i = 0; i <8; i++) {
      for (int j=0; j<8; j++) {
        aux = block_in_lv_little.get_bit((j*8)+i);
        (*lane_bip)[i] = (*lane_bip)[i] ^ aux;
        if(debug)
          cout << "(" << ((j*8)+i) << ")" << aux << " | -> bip bit:" << i << endl;
        aux = 0;
      }
      if (i == 3) {
        aux = header_in_lv.get_bit(0);
        (*lane_bip)[i] = (*lane_bip)[i] ^ aux;
        if(debug)
          cout << "(h0)" << aux << " | -> bip bit:" << i << endl;
        aux = 0;
      }
      else if (i == 4 ) {
        aux = header_in_lv.get_bit(1);
        (*lane_bip)[i] = (*lane_bip)[i] ^ aux;
        if(debug)
          cout << "(h1)" << aux << " | -> bip bit:" << i << endl;
        aux = 0;
      }
    }
    if(debug)
      cout << endl;
  }

  void rx() {
    std::stringstream buffer;
    int lane = 0;

    sc_lv<64 > block_in_lv;
    sc_lv<2 > header_in_lv;

    block_in_lv = block_in;
    header_in_lv = header_in;

    sc_lv<64 > blk_temp;
    sc_lv<2 >  hdr_temp;
    std::stringstream str_temp;

    static sc_lv<8 > lane0_bip;
    static sc_lv<8 > lane1_bip;
    static sc_lv<8 > lane2_bip;
    static sc_lv<8 > lane3_bip;

    static int first = 0;
    if (first == 0) {
        first ++;
        lane0_bip = "00000000";
        lane1_bip = "00000000";
        lane2_bip = "00000000";
        lane3_bip = "00000000";
    }

    if ( data_valid_in == SC_LOGIC_1 ) {

      buffer << header_in << "-" << block_in;

      lane = block_counter % 4;

      switch (lane) {
        case 0:
          lane0 << buffer.str() << endl;
          cout << buffer.str() << endl;
          block_counter++;
          bip_calculator (&lane0_bip, block_in, header_in, 0);
          break;
        case 1:
          lane1 << buffer.str() << endl;
          cout << buffer.str() << endl;
          block_counter++;
          bip_calculator (&lane1_bip, block_in, header_in);
          break;
        case 2:
          lane2 << buffer.str() << endl;
          cout << buffer.str() << endl;
          block_counter++;
          bip_calculator (&lane2_bip, block_in, header_in);
          break;
        case 3:
          lane3 << buffer.str() << endl;
          cout << buffer.str() << endl;
          block_counter++;
          bip_calculator (&lane3_bip, block_in, header_in);
          break;
        default:
          cout << "Wrong mode operation!" << endl;
      }

      if( block_counter == PKTS_BTW_SYNC) {
        /*
        **  BIT INTERLEAVED PARITY
        **  Each bit in the BIP field is an even parity calculation over all of
        **  the previous specified bits of a given PCS Lane, from and including
        **  the previous alignment marker, but not including the current alignment
        **  marker.
        */
        /*
        **  BIP BIT NUMBER  |   Assigned 66-bit word bits
        **        0         |     2,10,18,26,34,42,50,58
        **        1         |     3,11,19,27,35,43,51,59
        **        2         |     4,12,20,28,36,44,52,60
        **        3         |   0,5,13,21,29,37,45,53,61
        **        4         |   1,6,14,22,30,38,46,54,62
        **        5         |     7,15,23,31,39,47,55,63
        **        6         |     8,16,24,32,40,48,56,64
        **        7         |     9,17,25,33,41,49,57,65
        */
        /*
        **  10-LOW PART OF AN ALIGNMENT BLOCK, BIP, HIGH PART OF AN ALIGNMENT BLOCK, NOT(BIP)
        */

        lane0 << "10-" << SYNC_LANE0_LOW << lane0_bip << SYNC_LANE0_HIGH << ~lane0_bip << endl;
        str_temp << SYNC_LANE0_LOW << lane0_bip << SYNC_LANE0_HIGH << ~lane0_bip;
        blk_temp = str_temp.str().c_str();
        hdr_temp = "10";
        lane0_bip = "00000000";
        // cout << "LANE0_BIP " << hdr_temp << "-" << blk_temp << endl;
        // cout << "LANE0_BIP " << lane0_bip << endl;
        bip_calculator (&lane0_bip, blk_temp, hdr_temp, 0);
        // cout << "LANE0_BIP_ret: " << lane0_bip << endl << endl;

        lane1 << "10-" << SYNC_LANE1_LOW << lane1_bip << SYNC_LANE1_HIGH << ~lane1_bip << endl;
        str_temp << SYNC_LANE1_LOW << lane1_bip << SYNC_LANE1_HIGH << ~lane0_bip;
        blk_temp = str_temp.str().c_str();
        hdr_temp = "10";
        lane1_bip = "00000000";
        bip_calculator (&lane1_bip, blk_temp, hdr_temp);

        lane2 << "10-" << SYNC_LANE2_LOW << lane2_bip << SYNC_LANE2_HIGH << ~lane2_bip << endl;
        str_temp << SYNC_LANE2_LOW << lane2_bip << SYNC_LANE2_HIGH << ~lane0_bip;
        blk_temp = str_temp.str().c_str();
        hdr_temp = "10";
        lane2_bip = "00000000";
        bip_calculator (&lane2_bip, block_in_lv, hdr_temp);

        lane3 << "10-" << SYNC_LANE3_LOW << lane3_bip << SYNC_LANE3_HIGH << ~lane3_bip << endl;
        str_temp << SYNC_LANE3_LOW << lane3_bip << SYNC_LANE3_HIGH << ~lane0_bip;
        blk_temp = str_temp.str().c_str();
        hdr_temp = "10";
        lane3_bip = "00000000";
        bip_calculator (&lane3_bip, blk_temp, hdr_temp);

        block_counter = 0;
       }
      }
    }

  SC_CTOR(pkt_buffer) {
    block_counter = 0;

    lane0.open("lane0.txt");
    if (lane0.is_open()){
      cout << "[pkt_buffer] File lane0.txt opened." << endl;
    } else {
      cout << "[pkt_buffer] ERROR opening lane0.txt" << endl;
    }

    lane1.open("lane1.txt");
    if (lane1.is_open()){
      cout << "[pkt_buffer] File lane1.txt opened." << endl;
    } else {
      cout << "[pkt_buffer] ERROR opening lane1.txt" << endl;
    }

    lane2.open("lane2.txt");
    if (lane2.is_open()){
      cout << "[pkt_buffer] File lane2.txt opened." << endl;
    } else {
      cout << "[pkt_buffer] ERROR opening lane2.txt" << endl;
    }

    lane3.open("lane3.txt");
    if (lane3.is_open()){
      cout << "[pkt_buffer] File lane3.txt opened." << endl;
    } else {
      cout << "[pkt_buffer] ERROR opening lane3.txt" << endl;
    }

    SC_METHOD(rx);
    sensitive<<clock_in161.pos();
    dont_initialize();

  }

  ~pkt_buffer () {
    cout << "End of simulation!" << endl;
    lane0.close();
    lane1.close();
    lane2.close();
    lane3.close();
  }

};

#endif
