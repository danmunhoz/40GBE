#include "scoreboard.h"

void scoreboard::check_data() {
  while (true) {
    pkt_sent = pkt_from_tx->read();
    cout << "Packet recebido do TX" << endl;
    pkt_rcvd = pkt_from_rx->read();
    cout << "Packet recebido do RX" << endl;
    wait();
  }
};

void scoreboard::compare_pkts() {
  while (true) {
    if (pkt_sent == pkt_rcvd) {
      cout << "Packets RX e TX iguais" << endl;
    } else {
      cout << "ERRO no envio ou recebimento" << endl;
    }
    wait();
  }
};
