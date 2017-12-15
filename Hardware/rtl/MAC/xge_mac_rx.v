//////////////////////////////////////////////////////////////////////
////                                                              ////
////  File name "xge_mac.v"                                       ////
////                                                              ////
////  This file is part of the "10GE MAC" project                 ////
////  http://www.opencores.org/cores/xge_mac/                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - A. Tanguay (antanguay@opencores.org)                  ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 AUTHORS. All rights reserved.             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////


`include "defines.v"

module xge_mac_rx(/*AUTOARG*/
  // Outputs
  xgmii_txd, xgmii_txc, wb_int_o, wb_dat_o, wb_ack_o, pkt_tx_full,
  pkt_rx_val, pkt_rx_sop, pkt_rx_mod, pkt_rx_err, pkt_rx_eop,
  pkt_rx_data, pkt_rx_avail,
  // Inputs
  xgmii_rxd_0, xgmii_rxc_0, xgmii_rxd_1, xgmii_rxc_1, xgmii_rxd_2, xgmii_rxc_2,
  xgmii_rxd_3, xgmii_rxc_3, wb_we_i, wb_stb_i, wb_rst_i, wb_dat_i,
  wb_cyc_i, wb_clk_i, wb_adr_i, reset_xgmii_tx_n, reset_xgmii_rx_n,
  reset_156m25_n, pkt_tx_val, pkt_tx_sop, pkt_tx_mod, pkt_tx_eop,
  pkt_tx_data, pkt_rx_ren, clk_xgmii_tx, clk_xgmii_rx, clk_156m25,
  data_in_from_if, eop_in_from_if, sop_in_from_if
  );

/*AUTOINPUT*/
// Beginning of automatic inputs (from unused autoinst inputs)
input                   clk_156m25;             // To rx_dq0 of rx_dequeue.v, ...
input                   clk_xgmii_rx;           // To rx_eq0 of rx_enqueue.v, ...
input                   clk_xgmii_tx;           // To tx_dq0 of tx_dequeue.v, ...
input                   pkt_rx_ren;             // To rx_dq0 of rx_dequeue.v
input [63:0]            pkt_tx_data;            // To tx_eq0 of tx_enqueue.v
input                   pkt_tx_eop;             // To tx_eq0 of tx_enqueue.v
input [2:0]             pkt_tx_mod;             // To tx_eq0 of tx_enqueue.v
input                   pkt_tx_sop;             // To tx_eq0 of tx_enqueue.v
input                   pkt_tx_val;             // To tx_eq0 of tx_enqueue.v
input                   reset_156m25_n;         // To rx_dq0 of rx_dequeue.v, ...
input                   reset_xgmii_rx_n;       // To rx_eq0 of rx_enqueue.v, ...
input                   reset_xgmii_tx_n;       // To tx_dq0 of tx_dequeue.v, ...
input [7:0]             xgmii_rxc_0;              // To rx_eq0 of rx_enqueue.v
input [63:0]            xgmii_rxd_0;              // To rx_eq0 of rx_enqueue.v
input [7:0]             xgmii_rxc_1;              // To rx_eq0 of rx_enqueue.v
input [63:0]            xgmii_rxd_1;              // To rx_eq0 of rx_enqueue.v
input [7:0]             xgmii_rxc_2;              // To rx_eq0 of rx_enqueue.v
input [63:0]            xgmii_rxd_2;              // To rx_eq0 of rx_enqueue.v
input [7:0]             xgmii_rxc_3;              // To rx_eq0 of rx_enqueue.v
input [63:0]            xgmii_rxd_3;              // To rx_eq0 of rx_enqueue.v


input [7:0]             wb_adr_i;               // To wishbone_if0 of wishbone_if.v
input                   wb_clk_i;               // To sync_clk_wb0 of sync_clk_wb.v, ...
input                   wb_cyc_i;               // To wishbone_if0 of wishbone_if.v
input [31:0]            wb_dat_i;               // To wishbone_if0 of wishbone_if.v
input                   wb_rst_i;               // To sync_clk_wb0 of sync_clk_wb.v, ...
input                   wb_stb_i;               // To wishbone_if0 of wishbone_if.v
input                   wb_we_i;                // To wishbone_if0 of wishbone_if.v
// End of automatics
input [127:0] data_in_from_if;
input [4:0]   eop_in_from_if;
input         sop_in_from_if;

/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output                  pkt_rx_avail;           // From rx_dq0 of rx_dequeue.v
output [63:0]           pkt_rx_data;            // From rx_dq0 of rx_dequeue.v
output                  pkt_rx_eop;             // From rx_dq0 of rx_dequeue.v
output                  pkt_rx_err;             // From rx_dq0 of rx_dequeue.v
output [2:0]            pkt_rx_mod;             // From rx_dq0 of rx_dequeue.v
output                  pkt_rx_sop;             // From rx_dq0 of rx_dequeue.v
output                  pkt_rx_val;             // From rx_dq0 of rx_dequeue.v
output                  pkt_tx_full;            // From tx_eq0 of tx_enqueue.v
output                  wb_ack_o;               // From wishbone_if0 of wishbone_if.v
output [31:0]           wb_dat_o;               // From wishbone_if0 of wishbone_if.v
output                  wb_int_o;               // From wishbone_if0 of wishbone_if.v
output [7:0]            xgmii_txc;              // From tx_dq0 of tx_dequeue.v
output [63:0]           xgmii_txd;              // From tx_dq0 of tx_dequeue.v
// End of automatics

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire                    clear_stats_rx_octets;        // From wishbone_if0 of wishbone_if.v
wire                    clear_stats_rx_pkts;          // From wishbone_if0 of wishbone_if.v
wire                    clear_stats_tx_octets;        // From wishbone_if0 of wishbone_if.v
wire                    clear_stats_tx_pkts;          // From wishbone_if0 of wishbone_if.v
wire                    ctrl_tx_enable;               // From wishbone_if0 of wishbone_if.v
wire                    ctrl_tx_enable_ctx;           // From sync_clk_xgmii_tx0 of sync_clk_xgmii_tx.v
wire                    rxdfifo_ren;                  // From rx_dq0 of rx_dequeue.v

wire [31:0]             stats_rx_octets;              // From stats0 of stats.v
wire [31:0]             stats_rx_pkts;                // From stats0 of stats.v
wire [31:0]             stats_tx_octets;              // From stats0 of stats.v
wire [31:0]             stats_tx_pkts;                // From stats0 of stats.v
wire                    status_crc_error;             // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_fragment_error;        // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_lenght_error;          // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_local_fault;           // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_local_fault_crx;       // From fault_sm0 of fault_sm.v
// tanauan testando fault.vhd
wire      status_local_fault_crx2;
wire      status_remote_fault_crx2;
//
wire                    status_local_fault_ctx;       // From sync_clk_xgmii_tx0 of sync_clk_xgmii_tx.v
wire                    status_pause_frame_rx;        // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_remote_fault;          // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_remote_fault_crx;      // From fault_sm0 of fault_sm.v
wire                    status_remote_fault_ctx;      // From sync_clk_xgmii_tx0 of sync_clk_xgmii_tx.v
wire                    status_rxdfifo_ovflow;        // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_rxdfifo_udflow;        // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_rxdfifo_udflow_tog;    // From rx_dq0 of rx_dequeue.v
wire                    status_txdfifo_ovflow;        // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_txdfifo_ovflow_tog;    // From tx_eq0 of tx_enqueue.v
wire                    status_txdfifo_udflow;        // From sync_clk_wb0 of sync_clk_wb.v
wire                    status_txdfifo_udflow_tog;    // From tx_dq0 of tx_dequeue.v
wire                    txdfifo_ralmost_empty;        // From tx_data_fifo0 of tx_data_fifo.v
wire [63:0]             txdfifo_rdata;                // From tx_data_fifo0 of tx_data_fifo.v
wire                    txdfifo_rempty;               // From tx_data_fifo0 of tx_data_fifo.v
wire                    txdfifo_ren;                  // From tx_dq0 of tx_dequeue.v
wire [7:0]              txdfifo_rstatus;              // From tx_data_fifo0 of tx_data_fifo.v
wire                    txdfifo_walmost_full;         // From tx_data_fifo0 of tx_data_fifo.v
wire [63:0]             txdfifo_wdata;                // From tx_eq0 of tx_enqueue.v
wire                    txdfifo_wen;                  // From tx_eq0 of tx_enqueue.v
wire                    txdfifo_wfull;                // From tx_data_fifo0 of tx_data_fifo.v
wire [7:0]              txdfifo_wstatus;              // From tx_eq0 of tx_enqueue.v
wire                    txhfifo_ralmost_empty;        // From tx_hold_fifo0 of tx_hold_fifo.v
wire [63:0]             txhfifo_rdata;                // From tx_hold_fifo0 of tx_hold_fifo.v
wire                    txhfifo_rempty;               // From tx_hold_fifo0 of tx_hold_fifo.v
wire                    txhfifo_ren;                  // From tx_dq0 of tx_dequeue.v
wire [7:0]              txhfifo_rstatus;              // From tx_hold_fifo0 of tx_hold_fifo.v
wire                    txhfifo_walmost_full;         // From tx_hold_fifo0 of tx_hold_fifo.v
wire [63:0]             txhfifo_wdata;                // From tx_dq0 of tx_dequeue.v
wire                    txhfifo_wen;                  // From tx_dq0 of tx_dequeue.v
wire                    txhfifo_wfull;                // From tx_hold_fifo0 of tx_hold_fifo.v
wire [7:0]              txhfifo_wstatus;              // From tx_dq0 of tx_dequeue.v
wire [13:0]             txsfifo_wdata;                // From tx_dq0 of tx_dequeue.v
wire                    txsfifo_wen;                  // From tx_dq0 of tx_dequeue.v
// End of automatics

// LANE 0
// Wires of rx_eq0
wire [1:0]              local_fault_msg_det_0;          // From rx_eq0 of rx_enqueue.v
wire [1:0]              remote_fault_msg_det_0;         // From rx_eq0 of rx_enqueue.v
wire [63:0]             rxhfifo_wdata_0;                // From rx_eq0 of rx_enqueue.v
wire                    rxhfifo_wen_0;                  // From rx_eq0 of rx_enqueue.v
wire [7:0]              rxhfifo_wstatus_0;              // From rx_eq0 of rx_enqueue.v
wire [13:0]             rxsfifo_wdata_0;                // From rx_eq0 of rx_enqueue.v
wire                    rxsfifo_wen_0;                  // From rx_eq0 of rx_enqueue.v
wire [63:0]             rxdfifo_wdata_0;                // From rx_eq0 of rx_enqueue.v
wire                    rxdfifo_wen_0;                  // From rx_eq0 of rx_enqueue.v
wire [7:0]              rxdfifo_wstatus_0;              // From rx_eq0 of rx_enqueue.v
wire                    rxhfifo_ren_0;                  // From rx_eq0 of rx_enqueue.v
wire                    status_crc_error_tog_0;         // From rx_eq0 of rx_enqueue.v
wire                    status_fragment_error_tog_0;    // From rx_eq0 of rx_enqueue.v
wire                    status_lenght_error_tog_0;      // From rx_eq0 of rx_enqueue.v
wire                    status_rxdfifo_ovflow_tog_0;    // From rx_eq0 of rx_enqueue.v
wire                    status_pause_frame_rx_tog_0;    // From rx_eq0 of rx_enqueue.v
// Wires of rx_data_fifo0
wire                    rxdfifo_ralmost_empty_0;        // From rx_data_fifo0 of rx_data_fifo.v
wire [63:0]             rxdfifo_rdata_0;                // From rx_data_fifo0 of rx_data_fifo.v
wire                    rxdfifo_rempty_0;               // From rx_data_fifo0 of rx_data_fifo.v
wire [7:0]              rxdfifo_rstatus_0;              // From rx_data_fifo0 of rx_data_fifo.v
wire                    rxdfifo_wfull_0;                // From rx_data_fifo0 of rx_data_fifo.v
// Wires of rx_hold_fifo0
wire                    rxhfifo_ralmost_empty_0;        // From rx_hold_fifo0 of rx_hold_fifo.v
wire [63:0]             rxhfifo_rdata_0;                // From rx_hold_fifo0 of rx_hold_fifo.v
wire                    rxhfifo_rempty_0;               // From rx_hold_fifo0 of rx_hold_fifo.v
wire [7:0]              rxhfifo_rstatus_0;              // From rx_hold_fifo0 of rx_hold_fifo.v

// LANE 1
// Wires of rx_eq1
wire [1:0]              local_fault_msg_det_1;          // From rx_eq1 of rx_enqueue.v
wire [1:0]              remote_fault_msg_det_1;         // From rx_eq1 of rx_enqueue.v
wire [63:0]             rxhfifo_wdata_1;                // From rx_eq1 of rx_enqueue.v
wire                    rxhfifo_wen_1;                  // From rx_eq1 of rx_enqueue.v
wire [7:0]              rxhfifo_wstatus_1;              // From rx_eq1 of rx_enqueue.v
wire [13:0]             rxsfifo_wdata_1;                // From rx_eq1 of rx_enqueue.v
wire                    rxsfifo_wen_1;                  // From rx_eq1 of rx_enqueue.v
wire [63:0]             rxdfifo_wdata_1;                // From rx_eq1 of rx_enqueue.v
wire                    rxdfifo_wen_1;                  // From rx_eq1 of rx_enqueue.v
wire [7:0]              rxdfifo_wstatus_1;              // From rx_eq1 of rx_enqueue.v
wire                    rxhfifo_ren_1;                  // From rx_eq1 of rx_enqueue.v
wire                    status_crc_error_tog_1;         // From rx_eq1 of rx_enqueue.v
wire                    status_fragment_error_tog_1;    // From rx_eq1 of rx_enqueue.v
wire                    status_lenght_error_tog_1;      // From rx_eq1 of rx_enqueue.v
wire                    status_rxdfifo_ovflow_tog_1;    // From rx_eq1 of rx_enqueue.v
wire                    status_pause_frame_rx_tog_1;    // From rx_eq1 of rx_enqueue.v
// Wires of rx_data_fifo0
wire                    rxdfifo_ralmost_empty_1;        // From rx_data_fifo1 of rx_data_fifo.v
wire [63:0]             rxdfifo_rdata_1;                // From rx_data_fifo1 of rx_data_fifo.v
wire                    rxdfifo_rempty_1;               // From rx_data_fifo1 of rx_data_fifo.v
wire [7:0]              rxdfifo_rstatus_1;              // From rx_data_fifo1 of rx_data_fifo.v
wire                    rxdfifo_wfull_1;                // From rx_data_fifo1 of rx_data_fifo.v
// Wires of rx_hold_fifo1
wire                    rxhfifo_ralmost_empty_1;        // From rx_hold_fifo1 of rx_hold_fifo.v
wire [63:0]             rxhfifo_rdata_1;                // From rx_hold_fifo1 of rx_hold_fifo.v
wire                    rxhfifo_rempty_1;               // From rx_hold_fifo1 of rx_hold_fifo.v
wire [7:0]              rxhfifo_rstatus_1;              // From rx_hold_fifo1 of rx_hold_fifo.v

// LANE 2
// Wires of rx_eq2
wire [1:0]              local_fault_msg_det_2;          // From rx_eq2 of rx_enqueue.v
wire [1:0]              remote_fault_msg_det_2;         // From rx_eq2 of rx_enqueue.v
wire [63:0]             rxhfifo_wdata_2;                // From rx_eq2 of rx_enqueue.v
wire                    rxhfifo_wen_2;                  // From rx_eq2 of rx_enqueue.v
wire [7:0]              rxhfifo_wstatus_2;              // From rx_eq2 of rx_enqueue.v
wire [13:0]             rxsfifo_wdata_2;                // From rx_eq2 of rx_enqueue.v
wire                    rxsfifo_wen_2;                  // From rx_eq2 of rx_enqueue.v
wire [63:0]             rxdfifo_wdata_2;                // From rx_eq2 of rx_enqueue.v
wire                    rxdfifo_wen_2;                  // From rx_eq2 of rx_enqueue.v
wire [7:0]              rxdfifo_wstatus_2;              // From rx_eq2 of rx_enqueue.v
wire                    rxhfifo_ren_2;                  // From rx_eq2 of rx_enqueue.v
wire                    status_crc_error_tog_2;         // From rx_eq2 of rx_enqueue.v
wire                    status_fragment_error_tog_2;    // From rx_eq2 of rx_enqueue.v
wire                    status_lenght_error_tog_2;      // From rx_eq2 of rx_enqueue.v
wire                    status_rxdfifo_ovflow_tog_2;    // From rx_eq2 of rx_enqueue.v
wire                    status_pause_frame_rx_tog_2;    // From rx_eq2 of rx_enqueue.v
// Wires of rx_data_fifo2
wire                    rxdfifo_ralmost_empty_2;        // From rx_data_fifo2 of rx_data_fifo.v
wire [63:0]             rxdfifo_rdata_2;                // From rx_data_fifo2 of rx_data_fifo.v
wire                    rxdfifo_rempty_2;               // From rx_data_fifo2 of rx_data_fifo.v
wire [7:0]              rxdfifo_rstatus_2;              // From rx_data_fifo2 of rx_data_fifo.v
wire                    rxdfifo_wfull_2;                // From rx_data_fifo2 of rx_data_fifo.v
// Wires of rx_hold_fifo2
wire                    rxhfifo_ralmost_empty_2;        // From rx_hold_fifo2 of rx_hold_fifo.v
wire [63:0]             rxhfifo_rdata_2;                // From rx_hold_fifo2 of rx_hold_fifo.v
wire                    rxhfifo_rempty_2;               // From rx_hold_fifo2 of rx_hold_fifo.v
wire [7:0]              rxhfifo_rstatus_2;              // From rx_hold_fifo2 of rx_hold_fifo.v

// LANE 3
// Wires of rx_eq3
wire [1:0]              local_fault_msg_det_3;          // From rx_eq3 of rx_enqueue.v
wire [1:0]              remote_fault_msg_det_3;         // From rx_eq3 of rx_enqueue.v
wire [63:0]             rxhfifo_wdata_3;                // From rx_eq3 of rx_enqueue.v
wire                    rxhfifo_wen_3;                  // From rx_eq3 of rx_enqueue.v
wire [7:0]              rxhfifo_wstatus_3;              // From rx_eq3 of rx_enqueue.v
wire [13:0]             rxsfifo_wdata_3;                // From rx_eq3 of rx_enqueue.v
wire                    rxsfifo_wen_3;                  // From rx_eq3 of rx_enqueue.v
wire [63:0]             rxdfifo_wdata_3;                // From rx_eq3 of rx_enqueue.v
wire                    rxdfifo_wen_3;                  // From rx_eq3 of rx_enqueue.v
wire [7:0]              rxdfifo_wstatus_3;              // From rx_eq3 of rx_enqueue.v
wire                    rxhfifo_ren_3;                  // From rx_eq3 of rx_enqueue.v
wire                    status_crc_error_tog_3;         // From rx_eq3 of rx_enqueue.v
wire                    status_fragment_error_tog_3;    // From rx_eq3 of rx_enqueue.v
wire                    status_lenght_error_tog_3;      // From rx_eq3 of rx_enqueue.v
wire                    status_rxdfifo_ovflow_tog_3;    // From rx_eq3 of rx_enqueue.v
wire                    status_pause_frame_rx_tog_3;    // From rx_eq3 of rx_enqueue.v
// Wires of rx_data_fifo3
wire                    rxdfifo_ralmost_empty_3;        // From rx_data_fifo3 of rx_data_fifo.v
wire [63:0]             rxdfifo_rdata_3;                // From rx_data_fifo3 of rx_data_fifo.v
wire                    rxdfifo_rempty_3;               // From rx_data_fifo3 of rx_data_fifo.v
wire [7:0]              rxdfifo_rstatus_3;              // From rx_data_fifo3 of rx_data_fifo.v
wire                    rxdfifo_wfull_3;                // From rx_data_fifo3 of rx_data_fifo.v
// Wires of rx_hold_fifo3
wire                    rxhfifo_ralmost_empty_3;        // From rx_hold_fifo3 of rx_hold_fifo.v
wire [63:0]             rxhfifo_rdata_3;                // From rx_hold_fifo3 of rx_hold_fifo.v
wire                    rxhfifo_rempty_3;               // From rx_hold_fifo3 of rx_hold_fifo.v
wire [7:0]              rxhfifo_rstatus_3;              // From rx_hold_fifo3 of rx_hold_fifo.v

//  wires for status signals btw the rx_enqueues
// wire [7:0] local_d_status_0;
// wire [7:0] local_d_status_1;
// wire [7:0] local_d_status_2;
// wire [7:0] local_d_status_3;
//
// wire [7:0] global_d_status_0;
// wire [7:0] global_d_status_1;
// wire [7:0] global_d_status_2;
// wire [7:0] global_d_status_3;

wire local_d_wen_0;
wire local_d_wen_1;
wire local_d_wen_2;
wire local_d_wen_3;

wire global_d_wen_0;
wire global_d_wen_1;
wire global_d_wen_2;
wire global_d_wen_3;

// assign global_d_wen_0 = local_d_wen_1 || local_d_wen_2 || local_d_wen_3;
// assign global_d_wen_1 = local_d_wen_0 || local_d_wen_2 || local_d_wen_3;
// assign global_d_wen_2 = local_d_wen_0 || local_d_wen_1 || local_d_wen_3;
// assign global_d_wen_3 = local_d_wen_0 || local_d_wen_1 || local_d_wen_2;

assign global_d_wen_0 = 1'b0;
assign global_d_wen_1 = local_d_wen_0;
assign global_d_wen_2 = local_d_wen_0 || local_d_wen_1;
assign global_d_wen_3 = local_d_wen_0 || local_d_wen_1 || local_d_wen_2;

// assign global_d_status_0[0] = local_d_status_1[0] || local_d_status_2[0] || local_d_status_3[0];
// assign global_d_status_0[1] = local_d_status_1[1] || local_d_status_2[1] || local_d_status_3[1];
// assign global_d_status_0[2] = local_d_status_1[2] || local_d_status_2[2] || local_d_status_3[2];
// assign global_d_status_0[3] = local_d_status_1[3] || local_d_status_2[3] || local_d_status_3[3];
// assign global_d_status_0[4] = local_d_status_1[4] || local_d_status_2[4] || local_d_status_3[4];
// assign global_d_status_0[5] = local_d_status_1[5] || local_d_status_2[5] || local_d_status_3[5];
// assign global_d_status_0[6] = local_d_status_1[6] || local_d_status_2[6] || local_d_status_3[6];
// assign global_d_status_0[7] = local_d_status_1[7] || local_d_status_2[7] || local_d_status_3[7];
//
// assign global_d_status_1[0] = local_d_status_0[0] || local_d_status_2[0] || local_d_status_3[0];
// assign global_d_status_1[1] = local_d_status_0[1] || local_d_status_2[1] || local_d_status_3[1];
// assign global_d_status_1[2] = local_d_status_0[2] || local_d_status_2[2] || local_d_status_3[2];
// assign global_d_status_1[3] = local_d_status_0[3] || local_d_status_2[3] || local_d_status_3[3];
// assign global_d_status_1[4] = local_d_status_0[4] || local_d_status_2[4] || local_d_status_3[4];
// assign global_d_status_1[5] = local_d_status_0[5] || local_d_status_2[5] || local_d_status_3[5];
// assign global_d_status_1[6] = local_d_status_0[6] || local_d_status_2[6] || local_d_status_3[6];
// assign global_d_status_1[7] = local_d_status_0[7] || local_d_status_2[7] || local_d_status_3[7];
//
// assign global_d_status_2[0] = local_d_status_0[0] || local_d_status_1[0] || local_d_status_3[0];
// assign global_d_status_2[1] = local_d_status_0[1] || local_d_status_1[1] || local_d_status_3[1];
// assign global_d_status_2[2] = local_d_status_0[2] || local_d_status_1[2] || local_d_status_3[2];
// assign global_d_status_2[3] = local_d_status_0[3] || local_d_status_1[3] || local_d_status_3[3];
// assign global_d_status_2[4] = local_d_status_0[4] || local_d_status_1[4] || local_d_status_3[4];
// assign global_d_status_2[5] = local_d_status_0[5] || local_d_status_1[5] || local_d_status_3[5];
// assign global_d_status_2[6] = local_d_status_0[6] || local_d_status_1[6] || local_d_status_3[6];
// assign global_d_status_2[7] = local_d_status_0[7] || local_d_status_1[7] || local_d_status_3[7];
//
// assign global_d_status_3[0] = local_d_status_0[0] || local_d_status_1[0] || local_d_status_2[0];
// assign global_d_status_3[1] = local_d_status_0[1] || local_d_status_1[1] || local_d_status_2[1];
// assign global_d_status_3[2] = local_d_status_0[2] || local_d_status_1[2] || local_d_status_2[2];
// assign global_d_status_3[3] = local_d_status_0[3] || local_d_status_1[3] || local_d_status_2[3];
// assign global_d_status_3[4] = local_d_status_0[4] || local_d_status_1[4] || local_d_status_2[4];
// assign global_d_status_3[5] = local_d_status_0[5] || local_d_status_1[5] || local_d_status_2[5];
// assign global_d_status_3[6] = local_d_status_0[6] || local_d_status_1[6] || local_d_status_2[6];
// assign global_d_status_3[7] = local_d_status_0[7] || local_d_status_1[7] || local_d_status_2[7];


rx_enqueue_rx rx_eq0(/*AUTOINST*/
                  // Outputs
                  .rxdfifo_wdata        (rxdfifo_wdata_0[63:0]),
                  .rxdfifo_wstatus      (rxdfifo_wstatus_0[7:0]),
                  .rxdfifo_wen          (rxdfifo_wen_0),
                  .rxhfifo_ren          (rxhfifo_ren_0),
                  .rxhfifo_wdata        (rxhfifo_wdata_0[63:0]),
                  .rxhfifo_wstatus      (rxhfifo_wstatus_0[7:0]),
                  .rxhfifo_wen          (rxhfifo_wen_0),
                  .local_fault_msg_det  (local_fault_msg_det_0[1:0]),
                  .remote_fault_msg_det (remote_fault_msg_det_0[1:0]),
                  .status_crc_error_tog (status_crc_error_tog_0),
                  .status_fragment_error_tog(status_fragment_error_tog_0),
                  .status_lenght_error_tog(status_lenght_error_tog_0),
                  .status_rxdfifo_ovflow_tog(status_rxdfifo_ovflow_tog_0),
                  .status_pause_frame_rx_tog(status_pause_frame_rx_tog_0),
                  .rxsfifo_wen          (rxsfifo_wen_0),
                  .rxsfifo_wdata        (rxsfifo_wdata_0[13:0]),
                  // .global_d_status_out  (local_d_status_0),
                  .global_d_wen_out  (local_d_wen_0),
                  // Inputs
                  .clk_xgmii_rx         (clk_xgmii_rx),
                  .reset_xgmii_rx_n     (reset_xgmii_rx_n),
                  //.xgmii_rxd            (xgmii_rxd_0[63:0]),
                  .xgmii_rxd            (data_in_from_if[63:0]), // PARA SINTETIZAR O WRAPPER SEM CAPAR FORA
                  .xgmii_rxc            (xgmii_rxc_0[7:0]),
                  .rxdfifo_wfull        (rxdfifo_wfull_0),
                  .rxhfifo_rdata        (rxhfifo_rdata_0[63:0]),
                  .rxhfifo_rstatus      (rxhfifo_rstatus_0[7:0]),
                  .rxhfifo_rempty       (rxhfifo_rempty_0),
                  .rxhfifo_ralmost_empty(rxhfifo_ralmost_empty_0),
                  // .global_d_status_in   (global_d_status_0));
                  .global_d_wen_in   (global_d_wen_0));

rx_data_fifo rx_data_fifo0(/*AUTOINST*/
                           // Outputs
                           .rxdfifo_wfull       (rxdfifo_wfull_0),
                           .rxdfifo_rdata       (rxdfifo_rdata_0[63:0]),
                           .rxdfifo_rstatus     (rxdfifo_rstatus_0[7:0]),
                           .rxdfifo_rempty      (rxdfifo_rempty_0),
                           .rxdfifo_ralmost_empty(rxdfifo_ralmost_empty_0),
                           // Inputs
                           .clk_xgmii_rx        (clk_xgmii_rx),
                           .clk_156m25          (clk_156m25),
                           .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                           .reset_156m25_n      (reset_156m25_n),
                           .rxdfifo_wdata       (rxdfifo_wdata_0[63:0]),
                           .rxdfifo_wstatus     (rxdfifo_wstatus_0[7:0]),
                           .rxdfifo_wen         (rxdfifo_wen_0),
                           .rxdfifo_ren         (rxdfifo_ren_0));

rx_hold_fifo rx_hold_fifo0(/*AUTOINST*/
                           // Outputs
                           .rxhfifo_rdata       (rxhfifo_rdata_0[63:0]),
                           .rxhfifo_rstatus     (rxhfifo_rstatus_0[7:0]),
                           .rxhfifo_rempty      (rxhfifo_rempty_0),
                           .rxhfifo_ralmost_empty(rxhfifo_ralmost_empty_0),
                           // Inputs
                           .clk_xgmii_rx        (clk_xgmii_rx),
                           .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                           .rxhfifo_wdata       (rxhfifo_wdata_0[63:0]),
                           .rxhfifo_wstatus     (rxhfifo_wstatus_0[7:0]),
                           .rxhfifo_wen         (rxhfifo_wen_0),
                           .rxhfifo_ren         (rxhfifo_ren_0));

rx_enqueue_rx rx_eq1(/*AUTOINST*/
                  // Outputs
                  .rxdfifo_wdata        (rxdfifo_wdata_1[63:0]),
                  .rxdfifo_wstatus      (rxdfifo_wstatus_1[7:0]),
                  .rxdfifo_wen          (rxdfifo_wen_1),
                  .rxhfifo_ren          (rxhfifo_ren_1),
                  .rxhfifo_wdata        (rxhfifo_wdata_1[63:0]),
                  .rxhfifo_wstatus      (rxhfifo_wstatus_1[7:0]),
                  .rxhfifo_wen          (rxhfifo_wen_1),
                  .local_fault_msg_det  (local_fault_msg_det_1[1:0]),
                  .remote_fault_msg_det (remote_fault_msg_det_1[1:0]),
                  .status_crc_error_tog (status_crc_error_tog_1),
                  .status_fragment_error_tog(status_fragment_error_tog_1),
                  .status_lenght_error_tog(status_lenght_error_tog_1),
                  .status_rxdfifo_ovflow_tog(status_rxdfifo_ovflow_tog_1),
                  .status_pause_frame_rx_tog(status_pause_frame_rx_tog_1),
                  .rxsfifo_wen          (rxsfifo_wen_1),
                  .rxsfifo_wdata        (rxsfifo_wdata_1[13:0]),
                  // .global_d_status_out  (local_d_status_1),
                  .global_d_wen_out  (local_d_wen_1),
                  // Inputs
                  .clk_xgmii_rx         (clk_xgmii_rx),
                  .reset_xgmii_rx_n     (reset_xgmii_rx_n),
                  //.xgmii_rxd            (xgmii_rxd_1[63:0]),
                  .xgmii_rxd            (data_in_from_if[127:64]),
                  .xgmii_rxc            (xgmii_rxc_1[7:0]),
                  .rxdfifo_wfull        (rxdfifo_wfull_1),
                  .rxhfifo_rdata        (rxhfifo_rdata_1[63:0]),
                  .rxhfifo_rstatus      (rxhfifo_rstatus_1[7:0]),
                  .rxhfifo_rempty       (rxhfifo_rempty_1),
                  .rxhfifo_ralmost_empty(rxhfifo_ralmost_empty_1),
                  // .global_d_status_in   (global_d_status_1));
                  .global_d_wen_in   (global_d_wen_1));

rx_data_fifo rx_data_fifo1(/*AUTOINST*/
                           // Outputs
                           .rxdfifo_wfull       (rxdfifo_wfull_1),
                           .rxdfifo_rdata       (rxdfifo_rdata_1[63:0]),
                           .rxdfifo_rstatus     (rxdfifo_rstatus_1[7:0]),
                           .rxdfifo_rempty      (rxdfifo_rempty_1),
                           .rxdfifo_ralmost_empty(rxdfifo_ralmost_empty_1),
                           // Inputs
                           .clk_xgmii_rx        (clk_xgmii_rx),
                           .clk_156m25          (clk_156m25),
                           .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                           .reset_156m25_n      (reset_156m25_n),
                           .rxdfifo_wdata       (rxdfifo_wdata_1[63:0]),
                           .rxdfifo_wstatus     (rxdfifo_wstatus_1[7:0]),
                           .rxdfifo_wen         (rxdfifo_wen_1),
                           .rxdfifo_ren         (rxdfifo_ren_1));

rx_hold_fifo rx_hold_fifo1(/*AUTOINST*/
                           // Outputs
                           .rxhfifo_rdata       (rxhfifo_rdata_1[63:0]),
                           .rxhfifo_rstatus     (rxhfifo_rstatus_1[7:0]),
                           .rxhfifo_rempty      (rxhfifo_rempty_1),
                           .rxhfifo_ralmost_empty(rxhfifo_ralmost_empty_1),
                           // Inputs
                           .clk_xgmii_rx        (clk_xgmii_rx),
                           .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                           .rxhfifo_wdata       (rxhfifo_wdata_1[63:0]),
                           .rxhfifo_wstatus     (rxhfifo_wstatus_1[7:0]),
                           .rxhfifo_wen         (rxhfifo_wen_1),
                           .rxhfifo_ren         (rxhfifo_ren_1));

rx_enqueue_rx rx_eq2(/*AUTOINST*/
                  // Outputs
                  .rxdfifo_wdata        (rxdfifo_wdata_2[63:0]),
                  .rxdfifo_wstatus      (rxdfifo_wstatus_2[7:0]),
                  .rxdfifo_wen          (rxdfifo_wen_2),
                  .rxhfifo_ren          (rxhfifo_ren_2),
                  .rxhfifo_wdata        (rxhfifo_wdata_2[63:0]),
                  .rxhfifo_wstatus      (rxhfifo_wstatus_2[7:0]),
                  .rxhfifo_wen          (rxhfifo_wen_2),
                  .local_fault_msg_det  (local_fault_msg_det_2[1:0]),
                  .remote_fault_msg_det (remote_fault_msg_det_2[1:0]),
                  .status_crc_error_tog (status_crc_error_tog_2),
                  .status_fragment_error_tog(status_fragment_error_tog_2),
                  .status_lenght_error_tog(status_lenght_error_tog_2),
                  .status_rxdfifo_ovflow_tog(status_rxdfifo_ovflow_tog_2),
                  .status_pause_frame_rx_tog(status_pause_frame_rx_tog_2),
                  .rxsfifo_wen          (rxsfifo_wen_2),
                  .rxsfifo_wdata        (rxsfifo_wdata_2[13:0]),
                  // .global_d_status_out  (local_d_status_2),
                  .global_d_wen_out  (local_d_wen_2),
                  // Inputs
                  .clk_xgmii_rx         (clk_xgmii_rx),
                  .reset_xgmii_rx_n     (reset_xgmii_rx_n),
                  // .xgmii_rxd            (xgmii_rxd_2[63:0]),
                  .xgmii_rxd            (data_in_from_if[63:0]),
                  .xgmii_rxc            (xgmii_rxc_2[7:0]),
                  .rxdfifo_wfull        (rxdfifo_wfull_2),
                  .rxhfifo_rdata        (rxhfifo_rdata_2[63:0]),
                  .rxhfifo_rstatus      (rxhfifo_rstatus_2[7:0]),
                  .rxhfifo_rempty       (rxhfifo_rempty_2),
                  .rxhfifo_ralmost_empty(rxhfifo_ralmost_empty_2),
                  // .global_d_status_in   (global_d_status_2));
                  .global_d_wen_in   (global_d_wen_2));

rx_data_fifo rx_data_fifo2(/*AUTOINST*/
                           // Outputs
                           .rxdfifo_wfull       (rxdfifo_wfull_2),
                           .rxdfifo_rdata       (rxdfifo_rdata_2[63:0]),
                           .rxdfifo_rstatus     (rxdfifo_rstatus_2[7:0]),
                           .rxdfifo_rempty      (rxdfifo_rempty_2),
                           .rxdfifo_ralmost_empty(rxdfifo_ralmost_empty_2),
                           // Inputs
                           .clk_xgmii_rx        (clk_xgmii_rx),
                           .clk_156m25          (clk_156m25),
                           .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                           .reset_156m25_n      (reset_156m25_n),
                           .rxdfifo_wdata       (rxdfifo_wdata_2[63:0]),
                           .rxdfifo_wstatus     (rxdfifo_wstatus_2[7:0]),
                           .rxdfifo_wen         (rxdfifo_wen_2),
                           .rxdfifo_ren         (rxdfifo_ren_2));

rx_hold_fifo rx_hold_fifo2(/*AUTOINST*/
                           // Outputs
                           .rxhfifo_rdata       (rxhfifo_rdata_2[63:0]),
                           .rxhfifo_rstatus     (rxhfifo_rstatus_2[7:0]),
                           .rxhfifo_rempty      (rxhfifo_rempty_2),
                           .rxhfifo_ralmost_empty(rxhfifo_ralmost_empty_2),
                           // Inputs
                           .clk_xgmii_rx        (clk_xgmii_rx),
                           .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                           .rxhfifo_wdata       (rxhfifo_wdata_2[63:0]),
                           .rxhfifo_wstatus     (rxhfifo_wstatus_2[7:0]),
                           .rxhfifo_wen         (rxhfifo_wen_2),
                           .rxhfifo_ren         (rxhfifo_ren_2));


rx_enqueue_rx rx_eq3(/*AUTOINST*/
                  // Outputs
                  .rxdfifo_wdata        (rxdfifo_wdata_3[63:0]),
                  .rxdfifo_wstatus      (rxdfifo_wstatus_3[7:0]),
                  .rxdfifo_wen          (rxdfifo_wen_3),
                  .rxhfifo_ren          (rxhfifo_ren_3),
                  .rxhfifo_wdata        (rxhfifo_wdata_3[63:0]),
                  .rxhfifo_wstatus      (rxhfifo_wstatus_3[7:0]),
                  .rxhfifo_wen          (rxhfifo_wen_3),
                  .local_fault_msg_det  (local_fault_msg_det_3[1:0]),
                  .remote_fault_msg_det (remote_fault_msg_det_3[1:0]),
                  .status_crc_error_tog (status_crc_error_tog_3),
                  .status_fragment_error_tog(status_fragment_error_tog_3),
                  .status_lenght_error_tog(status_lenght_error_tog_3),
                  .status_rxdfifo_ovflow_tog(status_rxdfifo_ovflow_tog_3),
                  .status_pause_frame_rx_tog(status_pause_frame_rx_tog_3),
                  .rxsfifo_wen          (rxsfifo_wen_3),
                  .rxsfifo_wdata        (rxsfifo_wdata_3[13:0]),
                  // .global_d_status_out  (local_d_status_3),
                  .global_d_wen_out  (local_d_wen_3),
                  // Inputs
                  .clk_xgmii_rx         (clk_xgmii_rx),
                  .reset_xgmii_rx_n     (reset_xgmii_rx_n),
                  // .xgmii_rxd            (xgmii_rxd_3[63:0]),
                  .xgmii_rxd            (data_in_from_if[127:64]),
                  .xgmii_rxc            (xgmii_rxc_3[7:0]),
                  .rxdfifo_wfull        (rxdfifo_wfull_3),
                  .rxhfifo_rdata        (rxhfifo_rdata_3[63:0]),
                  .rxhfifo_rstatus      (rxhfifo_rstatus_3[7:0]),
                  .rxhfifo_rempty       (rxhfifo_rempty_3),
                  .rxhfifo_ralmost_empty(rxhfifo_ralmost_empty_3),
                  // .global_d_status_in   (global_d_status_3));
                  .global_d_wen_in   (global_d_wen_3));

rx_data_fifo rx_data_fifo3(/*AUTOINST*/
                           // Outputs
                           .rxdfifo_wfull       (rxdfifo_wfull_3),
                           .rxdfifo_rdata       (rxdfifo_rdata_3[63:0]),
                           .rxdfifo_rstatus     (rxdfifo_rstatus_3[7:0]),
                           .rxdfifo_rempty      (rxdfifo_rempty_3),
                           .rxdfifo_ralmost_empty(rxdfifo_ralmost_empty_3),
                           // Inputs
                           .clk_xgmii_rx        (clk_xgmii_rx),
                           .clk_156m25          (clk_156m25),
                           .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                           .reset_156m25_n      (reset_156m25_n),
                           .rxdfifo_wdata       (rxdfifo_wdata_3[63:0]),
                           .rxdfifo_wstatus     (rxdfifo_wstatus_3[7:0]),
                           .rxdfifo_wen         (rxdfifo_wen_3),
                           .rxdfifo_ren         (rxdfifo_ren_3));

rx_hold_fifo rx_hold_fifo3(/*AUTOINST*/
                           // Outputs
                           .rxhfifo_rdata       (rxhfifo_rdata_3[63:0]),
                           .rxhfifo_rstatus     (rxhfifo_rstatus_3[7:0]),
                           .rxhfifo_rempty      (rxhfifo_rempty_3),
                           .rxhfifo_ralmost_empty(rxhfifo_ralmost_empty_3),
                           // Inputs
                           .clk_xgmii_rx        (clk_xgmii_rx),
                           .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                           .rxhfifo_wdata       (rxhfifo_wdata_3[63:0]),
                           .rxhfifo_wstatus     (rxhfifo_wstatus_3[7:0]),
                           .rxhfifo_wen         (rxhfifo_wen_3),
                           .rxhfifo_ren         (rxhfifo_ren_3));

rx_dequeue rx_dq0(/*AUTOINST*/
                  // Outputs
                  .rxdfifo_ren          (rxdfifo_ren),
                  .pkt_rx_data          (pkt_rx_data[63:0]),
                  .pkt_rx_val           (pkt_rx_val),
                  .pkt_rx_sop           (pkt_rx_sop),
                  .pkt_rx_eop           (pkt_rx_eop),
                  .pkt_rx_err           (pkt_rx_err),
                  .pkt_rx_mod           (pkt_rx_mod[2:0]),
                  .pkt_rx_avail         (pkt_rx_avail),
                  .status_rxdfifo_udflow_tog(status_rxdfifo_udflow_tog),
                  // Inputs
                  .clk_156m25           (clk_156m25),
                  .reset_156m25_n       (reset_156m25_n),
                  .rxdfifo_rdata        (rxdfifo_rdata_0[63:0]),
                  .rxdfifo_rstatus      (rxdfifo_rstatus_0[7:0]),
                  .rxdfifo_rempty       (rxdfifo_rempty),
                  .rxdfifo_ralmost_empty(rxdfifo_ralmost_empty),
                  .pkt_rx_ren           (pkt_rx_ren));

tx_enqueue tx_eq0 (/*AUTOINST*/
                   // Outputs
                   .pkt_tx_full         (pkt_tx_full),
                   .txdfifo_wdata       (txdfifo_wdata[63:0]),
                   .txdfifo_wstatus     (txdfifo_wstatus[7:0]),
                   .txdfifo_wen         (txdfifo_wen),
                   .status_txdfifo_ovflow_tog(status_txdfifo_ovflow_tog),
                   // Inputs
                   .clk_156m25          (clk_156m25),
                   .reset_156m25_n      (reset_156m25_n),
                   .pkt_tx_data         (pkt_tx_data[63:0]),
                   .pkt_tx_val          (pkt_tx_val),
                   .pkt_tx_sop          (pkt_tx_sop),
                   .pkt_tx_eop          (pkt_tx_eop),
                   .pkt_tx_mod          (pkt_tx_mod[2:0]),
                   .txdfifo_wfull       (txdfifo_wfull),
                   .txdfifo_walmost_full(txdfifo_walmost_full));

tx_dequeue tx_dq0(/*AUTOINST*/
                  // Outputs
                  .txdfifo_ren          (txdfifo_ren),
                  .txhfifo_ren          (txhfifo_ren),
                  .txhfifo_wdata        (txhfifo_wdata[63:0]),
                  .txhfifo_wstatus      (txhfifo_wstatus[7:0]),
                  .txhfifo_wen          (txhfifo_wen),
                  .xgmii_txd            (xgmii_txd[63:0]),
                  .xgmii_txc            (xgmii_txc[7:0]),
                  .status_txdfifo_udflow_tog(status_txdfifo_udflow_tog),
                  .txsfifo_wen          (txsfifo_wen),
                  .txsfifo_wdata        (txsfifo_wdata[13:0]),
                  // Inputs
                  .clk_xgmii_tx         (clk_xgmii_tx),
                  .reset_xgmii_tx_n     (reset_xgmii_tx_n),
                  .ctrl_tx_enable_ctx   (ctrl_tx_enable_ctx),
                  .status_local_fault_ctx(status_local_fault_ctx),
                  .status_remote_fault_ctx(status_remote_fault_ctx),
                  .txdfifo_rdata        (txdfifo_rdata[63:0]),
                  .txdfifo_rstatus      (txdfifo_rstatus[7:0]),
                  .txdfifo_rempty       (txdfifo_rempty),
                  .txdfifo_ralmost_empty(txdfifo_ralmost_empty),
                  .txhfifo_rdata        (txhfifo_rdata[63:0]),
                  .txhfifo_rstatus      (txhfifo_rstatus[7:0]),
                  .txhfifo_rempty       (txhfifo_rempty),
                  .txhfifo_ralmost_empty(txhfifo_ralmost_empty),
                  .txhfifo_wfull        (txhfifo_wfull),
                  .txhfifo_walmost_full (txhfifo_walmost_full));

tx_data_fifo tx_data_fifo0(/*AUTOINST*/
                           // Outputs
                           .txdfifo_wfull       (txdfifo_wfull),
                           .txdfifo_walmost_full(txdfifo_walmost_full),
                           .txdfifo_rdata       (txdfifo_rdata[63:0]),
                           .txdfifo_rstatus     (txdfifo_rstatus[7:0]),
                           .txdfifo_rempty      (txdfifo_rempty),
                           .txdfifo_ralmost_empty(txdfifo_ralmost_empty),
                           // Inputs
                           .clk_xgmii_tx        (clk_xgmii_tx),
                           .clk_156m25          (clk_156m25),
                           .reset_xgmii_tx_n    (reset_xgmii_tx_n),
                           .reset_156m25_n      (reset_156m25_n),
                           .txdfifo_wdata       (txdfifo_wdata[63:0]),
                           .txdfifo_wstatus     (txdfifo_wstatus[7:0]),
                           .txdfifo_wen         (txdfifo_wen),
                           .txdfifo_ren         (txdfifo_ren));

tx_hold_fifo tx_hold_fifo0(/*AUTOINST*/
                           // Outputs
                           .txhfifo_wfull       (txhfifo_wfull),
                           .txhfifo_walmost_full(txhfifo_walmost_full),
                           .txhfifo_rdata       (txhfifo_rdata[63:0]),
                           .txhfifo_rstatus     (txhfifo_rstatus[7:0]),
                           .txhfifo_rempty      (txhfifo_rempty),
                           .txhfifo_ralmost_empty(txhfifo_ralmost_empty),
                           // Inputs
                           .clk_xgmii_tx        (clk_xgmii_tx),
                           .reset_xgmii_tx_n    (reset_xgmii_tx_n),
                           .txhfifo_wdata       (txhfifo_wdata[63:0]),
                           .txhfifo_wstatus     (txhfifo_wstatus[7:0]),
                           .txhfifo_wen         (txhfifo_wen),
                           .txhfifo_ren         (txhfifo_ren));

fault_sm fault_sm0(/*AUTOINST*/
                   // Outputs
                   .status_local_fault_crx(status_local_fault_crx),
                   .status_remote_fault_crx(status_remote_fault_crx),
                   // Inputs
                   .clk_xgmii_rx        (clk_xgmii_rx),
                   .reset_xgmii_rx_n    (reset_xgmii_rx_n),
                   .local_fault_msg_det (local_fault_msg_det_0[1:0]),
                   .remote_fault_msg_det(remote_fault_msg_det_0[1:0]));

fault_sm_rx INST_fault(  // Outputs
                   .status_local_fault_crx (status_local_fault_crx2),
                   .status_remote_fault_crx (status_remote_fault_crx2),
                   // Inputs
                   .clk_xgmii_rx         (clk_xgmii_rx),
                   .reset_xgmii_rx_n     (reset_xgmii_rx_n),
                   .local_fault_msg_det  (local_fault_msg_det_0[1:0]),
                   .remote_fault_msg_det (remote_fault_msg_det_0[1:0]) );

sync_clk_wb sync_clk_wb0(/*AUTOINST*/
                         // Outputs
                         .status_crc_error      (status_crc_error),
                         .status_fragment_error (status_fragment_error),
                         .status_lenght_error   (status_lenght_error),
                         .status_txdfifo_ovflow (status_txdfifo_ovflow),
                         .status_txdfifo_udflow (status_txdfifo_udflow),
                         .status_rxdfifo_ovflow (status_rxdfifo_ovflow),
                         .status_rxdfifo_udflow (status_rxdfifo_udflow),
                         .status_pause_frame_rx (status_pause_frame_rx),
                         .status_local_fault    (status_local_fault),
                         .status_remote_fault   (status_remote_fault),
                         // Inputs
                         .wb_clk_i              (wb_clk_i),
                         .wb_rst_i              (wb_rst_i),
                         .status_crc_error_tog  (status_crc_error_tog),
                         .status_fragment_error_tog(status_fragment_error_tog),
                         .status_lenght_error_tog(status_lenght_error_tog),
                         .status_txdfifo_ovflow_tog(status_txdfifo_ovflow_tog),
                         .status_txdfifo_udflow_tog(status_txdfifo_udflow_tog),
                         .status_rxdfifo_ovflow_tog(status_rxdfifo_ovflow_tog),
                         .status_rxdfifo_udflow_tog(status_rxdfifo_udflow_tog),
                         .status_pause_frame_rx_tog(status_pause_frame_rx_tog),
                         .status_local_fault_crx(status_local_fault_crx),
                         .status_remote_fault_crx(status_remote_fault_crx));

sync_clk_xgmii_tx sync_clk_xgmii_tx0(/*AUTOINST*/
                                     // Outputs
                                     .ctrl_tx_enable_ctx(ctrl_tx_enable_ctx),
                                     .status_local_fault_ctx(status_local_fault_ctx),
                                     .status_remote_fault_ctx(status_remote_fault_ctx),
                                     // Inputs
                                     .clk_xgmii_tx      (clk_xgmii_tx),
                                     .reset_xgmii_tx_n  (reset_xgmii_tx_n),
                                     .ctrl_tx_enable    (ctrl_tx_enable),
                                     .status_local_fault_crx(status_local_fault_crx),
                                     .status_remote_fault_crx(status_remote_fault_crx));

stats stats0(/*AUTOINST*/
             // Outputs
             .stats_rx_octets           (stats_rx_octets[31:0]),
             .stats_rx_pkts             (stats_rx_pkts[31:0]),
             .stats_tx_octets           (stats_tx_octets[31:0]),
             .stats_tx_pkts             (stats_tx_pkts[31:0]),
             // Inputs
             .clear_stats_rx_octets     (clear_stats_rx_octets),
             .clear_stats_rx_pkts       (clear_stats_rx_pkts),
             .clear_stats_tx_octets     (clear_stats_tx_octets),
             .clear_stats_tx_pkts       (clear_stats_tx_pkts),
             .clk_xgmii_rx              (clk_xgmii_rx),
             .clk_xgmii_tx              (clk_xgmii_tx),
             .reset_xgmii_rx_n          (reset_xgmii_rx_n),
             .reset_xgmii_tx_n          (reset_xgmii_tx_n),
             .rxsfifo_wdata             (rxsfifo_wdata_0[13:0]),
             .rxsfifo_wen               (rxsfifo_wen),
             .txsfifo_wdata             (txsfifo_wdata[13:0]),
             .txsfifo_wen               (txsfifo_wen),
             .wb_clk_i                  (wb_clk_i),
             .wb_rst_i                  (wb_rst_i));

//sync_clk_core sync_clk_core0(/*AUTOINST*/
//                             // Inputs
//                             .clk_xgmii_tx      (clk_xgmii_tx),
//                             .reset_xgmii_tx_n  (reset_xgmii_tx_n));

wishbone_if wishbone_if0(/*AUTOINST*/
                         // Outputs
                         .wb_dat_o              (wb_dat_o[31:0]),
                         .wb_ack_o              (wb_ack_o),
                         .wb_int_o              (wb_int_o),
                         .ctrl_tx_enable        (ctrl_tx_enable),
                         .clear_stats_tx_octets (clear_stats_tx_octets),
                         .clear_stats_tx_pkts   (clear_stats_tx_pkts),
                         .clear_stats_rx_octets (clear_stats_rx_octets),
                         .clear_stats_rx_pkts   (clear_stats_rx_pkts),
                         // Inputs
                         .wb_clk_i              (wb_clk_i),
                         .wb_rst_i              (wb_rst_i),
                         .wb_adr_i              (wb_adr_i[7:0]),
                         .wb_dat_i              (wb_dat_i[31:0]),
                         .wb_we_i               (wb_we_i),
                         .wb_stb_i              (wb_stb_i),
                         .wb_cyc_i              (wb_cyc_i),
                         .status_crc_error      (status_crc_error),
                         .status_fragment_error (status_fragment_error),
                         .status_lenght_error   (status_lenght_error),
                         .status_txdfifo_ovflow (status_txdfifo_ovflow),
                         .status_txdfifo_udflow (status_txdfifo_udflow),
                         .status_rxdfifo_ovflow (status_rxdfifo_ovflow),
                         .status_rxdfifo_udflow (status_rxdfifo_udflow),
                         .status_pause_frame_rx (status_pause_frame_rx),
                         .status_local_fault    (status_local_fault),
                         .status_remote_fault   (status_remote_fault),
                         .stats_tx_octets       (stats_tx_octets[31:0]),
                         .stats_tx_pkts         (stats_tx_pkts[31:0]),
                         .stats_rx_octets       (stats_rx_octets[31:0]),
                         .stats_rx_pkts         (stats_rx_pkts[31:0]));

endmodule
