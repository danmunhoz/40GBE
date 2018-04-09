/*
**  Modulo gera arquivo de dump do barramento de saida do mac_dataterface
**
*/

#ifndef DUMP_OUTPUT
#define DUMP_OUTPUT

#include <systemc.h>
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>

class dump_output : public sc_module {
public:

  sc_in<sc_logic>   clock_in;
  sc_in<sc_logic>   reset_n;
  sc_in<sc_lv<128> > mac_data;
  sc_in<sc_logic > mac_sop;
  sc_in<sc_logic > mac_val;
  sc_in<sc_lv<5> > mac_eop;

  ofstream dump_file;
  std::string file_name;

  void dump();

  SC_HAS_PROCESS(dump_output);
  dump_output (sc_module_name nm, std::string file_name) : sc_module(nm), file_name(file_name) {
    dump_file.open(file_name.c_str());
    if (dump_file.is_open()){
      cout << "[DUMP_OUTPUT] File "<< file_name << " opened." << endl;
    } else {
      cout << "ERROR opening " << file_name << endl;
    }

    SC_METHOD(dump);
    sensitive << clock_in.pos();

  }

  ~dump_output() {
  }
};

inline void dump_output::dump() {
  if(reset_n == SC_LOGIC_1) {
    if(dump_file.is_open()) {
      if(mac_val == SC_LOGIC_1) {
        dump_file << mac_sop << "-" << mac_eop << "-" << mac_data << endl;
      }
    }
  }
}

#endif
