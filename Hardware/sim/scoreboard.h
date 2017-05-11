#ifndef SCOREBOARD
#define SCOREBOARD

#include "systemc.h"

SC_MODULE(scoreboard) {

  sc_in<sc_logic> clock_in156;
  sc_in<sc_lv<64> > block_in;
  sc_in<sc_lv<2> >  header_in;

  FILE * fd;

  SC_CTOR( scoreboard ) {
    fd = NULL;
    fd = fopen("board.txt","rw+");
    if (fd == NULL) {
      printf("\nERROR Creating file!!\n");
    } else {
      printf("\n OK \n");
    }
    // SC_METHOD
  }

};

#endif
