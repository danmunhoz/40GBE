/*
**  Modulo gera arquivo de dump do barramento MII
**
*/

#ifndef DUMP_MII
#define DUMP_MII

#include <systemc.h>
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>

// Set it to zero if you wish to dump only data
#define DUMP_CONTROL 0

//SC_MODULE(dump_mii) {
class dump_mii : public sc_module {
public:

  sc_in<sc_logic>   clock_in;
  sc_in<sc_logic>   reset_n;
  sc_in<sc_lv<64> > mii_d;
  sc_in<sc_lv<8> >  mii_c;
  ofstream dump_file;
  std::string file_name;

  void dump();

  SC_HAS_PROCESS(dump_mii);
  dump_mii (sc_module_name nm, std::string file_name) : sc_module(nm), file_name(file_name)
  {
    dump_file.open(file_name.c_str());
    if (dump_file.is_open()){
      cout << "[dump_mii] File "<< file_name << " opened." << endl;
    } else {
      cout << "ERROR opening " << file_name << endl;
    }

    SC_METHOD(dump);
    sensitive << clock_in.pos();

  }

  ~dump_mii() {
  }
};

inline void dump_mii::dump() {
  sc_lv<8> aux;
  aux = mii_c;
  if(reset_n == SC_LOGIC_1) {
    if(DUMP_CONTROL){
      if(dump_file.is_open()) {
        dump_file << mii_c << "-" << mii_d << endl;
      }
    } else {
      if(dump_file.is_open() && (aux.to_uint() != 0xff) && (aux.to_uint() != 0x11)) {
        dump_file << mii_c << "-" << mii_d << endl;
      }
    }
  }
}

#endif
