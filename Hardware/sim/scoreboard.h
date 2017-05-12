/*
**  Modulo para commparar frames enviados vs. recebidos
**
*/

#ifndef SCOREBOARD
#define SCOREBOARD

#include "systemc.h"

SC_MODULE(scoreboard) {

  sc_in<sc_logic>   clock_in156;
  sc_in<sc_lv<64> > block_in;
  sc_in<sc_lv<2> >  header_in;
  sc_in<sc_logic>   rx_data_valid_in;

  FILE * fd;

  // void board_write() {
  //   while (true) {
  //    if () {
  //    }
  //   }
  // }

  SC_CTOR( scoreboard ) {
    fd = NULL;
    fd = fopen("board.txt","rw+");
    if (fd == NULL) {
      printf("\nERROR Creating file!!\n");
    }
    // SC_METHOD
  }

  ~scoreboard () {
    fclose(fd);
  }

};

#endif
