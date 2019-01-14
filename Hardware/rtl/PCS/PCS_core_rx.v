//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: PCS_core.v
//
// Begin Date: Fri Jun 18 15:26:25 2004
//
// Description:
//
//
//  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are
//              provided to you "as is". Xilinx and its licensors make, and you
//              receive no warranties or conditions, express, implied,
//              statutory or otherwise, and Xilinx specifically disclaims any
//              implied warranties of merchantability, non-infringement, or
//              fitness for a particular purpose. Xilinx does not warrant that
//              the functions contained in these designs will meet your
//              requirements, or that the operation of these designs will be
//              uninterrupted or error free, or that defects in the Designs
//              will be corrected. Furthermore, Xilinx does not warrant or
//              make any representations regarding use or the results of the
//              use of the designs in terms of correctness, accuracy,
//              reliability, or otherwise.
//
//              LIMITATION OF LIABILITY. In no event will Xilinx or its
//              licensors be liable for any loss of data, lost profits, cost
//              or procurement of substitute goods or services, or for any
//              special, incidental, consequential, or indirect damages
//              arising from the use or operation of the designs or
//              accompanying documentation, however caused and on any theory
//              of liability. This limitation will apply even if Xilinx
//              has been advised of the possibility of such damage. This
//              limitation shall apply not-withstanding the failure of the
//              essential purpose of any limited remedies herein.
//
//  Copyright  2002 Xilinx, Inc.
//  All rights reserved
//
//                       Revision History
//-----------------------------------------------------------------
// Date Modified             User Name            Full Name
//        Descrition of Changes
//-----------------------------------------------------------------
// $Log: PCS_core.v,v $
// Revision 1.1  2014-07-15 19:51:18  thomas.volpato
// Modificado diretorio de arquivos conforme especificado no documento da datacom
//
// Revision 1.1  2014-07-07 23:58:22  ricardo.guazzelli
// adicionado arquivos atualizados
//
//
//
//-----------------------------------------------------------------
// NOTES:
//-----------------------------------------------------------------
//
//
//-----------------------------------------------------------------

`include "definitions.v"

module PCS_core_rx  (  /*AUTOARG*/
                    // Inputs
                    clk156, tx_clk161, rx_clk161,
                    arstb, reset_tx_n, reset_rx_n,
                    rx_jtm_en, bypass_descram, bypass_scram, bypass_66decoder, bypass_66encoder,
                    clear_errblk, clear_ber_cnt, tx_jtm_en, jtm_dps_0, jtm_dps_1,
                    seed_A, seed_B, xgmii_txc, xgmii_txd,
                    rx_header_valid_in, rx_header_in, rx_data_valid_in, rx_data_in,
                    rx_old_header_in, rx_old_data_in,
                    terminate_in_rx, start_in_rx, terminate_in_tx, start_in_tx,
                    tx_old_scr_data_in, tx_old_scr_data_out, pcs_sync,
                    // gap, setIPG,
                    is_alig, fifo_in, val_in,

                    // Outputs
                    jtest_errc, ber_cnt, hi_ber, blk_lock, linkstatus, rx_fifo_spill,
                    tx_fifo_spill, rxlf, txlf, errd_blks, xgmii_rxc, xgmii_rxd, scram_en,
                    tx_data_out, tx_header_out, tx_sequence_out, rxgearboxslip_out,
                    terminate_out_rx, start_out_rx, terminate_out_tx, start_out_tx, dscr_out,
                    // Para uso do Testbench
        						RDEN_FIFO_PCS40, start_fifo, start_fifo_rd
                    );

    parameter PCS_ID = 2;

    // Clocks and reset
    input         clk156;
    input         tx_clk161;
    input         rx_clk161;

    input         arstb;
    input         reset_tx_n;
    input         reset_rx_n;

    // PCS Inputs
    input         rx_jtm_en;
    input         bypass_descram;
    input         bypass_scram;
    input         bypass_66decoder;
    input         bypass_66encoder;
    input         clear_errblk;
    input         clear_ber_cnt;
    input         tx_jtm_en;
    input         jtm_dps_0;
    input         jtm_dps_1;
    input [57:0]  seed_A;
    input [57:0]  seed_B;
    input [7:0]   xgmii_txc;
    input [63:0]  xgmii_txd;
    input         rx_header_valid_in;
    input [1:0]   rx_header_in;
    input         rx_data_valid_in;
    input [63:0]  rx_data_in;

    input [1:0]   rx_old_header_in;
    input [63:0]  rx_old_data_in;

    input  [65:0]	tx_old_scr_data_in;
    output [65:0]	tx_old_scr_data_out;

    input 				pcs_sync;

    input [65:0]  fifo_in;
    input         val_in;

    input          terminate_in_rx;
    wire           terminate_in_rx;
    input          start_in_rx;
    wire           start_in_rx;

    input          terminate_in_tx;
    wire           terminate_in_tx;
    input          start_in_tx;
    wire           start_in_tx;

    // input         gap;
    // input         setIPG;
    input         is_alig;

    //For Testbench use
		input					start_fifo;
		input					start_fifo_rd;
		input					RDEN_FIFO_PCS40;

    output        hi_ber;
    output        blk_lock;
    output        linkstatus;
    output        rx_fifo_spill;
    output        tx_fifo_spill;
    output        rxlf;
    output        txlf;
    output [5:0]  ber_cnt;
    output [7:0]  errd_blks;
    output [15:0] jtest_errc;
    output [7:0]  xgmii_rxc;
    output [63:0] xgmii_rxd;
    output [63:0] tx_data_out;
    output [1:0]  tx_header_out;
    output        rxgearboxslip_out;
    output [6:0]  tx_sequence_out;
    output        scram_en;

    output [65:0] dscr_out;

    output         terminate_out_rx;
    wire           terminate_out_rx;
    output         start_out_rx;
    wire           start_out_rx;

    output         terminate_out_tx;
    wire           terminate_out_tx;
    output         start_out_tx;
    wire           start_out_tx;

    wire          txpclkn_int;
    wire          txpclkp_int;
    wire          tx_clk161;
    wire          rx_clk161;
    wire [7:0]    xgmii_txc;
    wire [7:0]    xgmii_rxc;
    wire [63:0]   xgmii_txd;
    wire [63:0]   xgmii_rxd;

    wire [63:0]   tx_data_out;
    wire [1:0]    tx_header_out;
    wire          rx_header_valid_in;
    wire [1:0]    rx_header_in;
    wire          rx_data_valid_in;
    wire [63:0]   rx_data_in;
    wire [6:0]    tx_sequence_out;
    wire          rxgearboxslip_out;


tx_path_tx #(
    .PCS_ID(PCS_ID)
  ) INST_tx_path(   // Inputs
                        .clk156                (clk156),
                        .tx_clk161             (tx_clk161),
                        .arstb                 (reset_tx_n),
                        .bypass_66encoder      (bypass_66encoder),
                        .bypass_scram          (bypass_scram),
                        .tx_jtm_en             (tx_jtm_en),
                        .jtm_dps_0             (jtm_dps_0),
                        .jtm_dps_1             (jtm_dps_1),
                        .seed_A                (seed_A),
                        .seed_B                (seed_B),
                        .xgmii_txc             (xgmii_txc[7:0]),
                        .xgmii_txd             (xgmii_txd[63:0]),
                        .terminate_in          (terminate_in_tx),
                        .start_in              (start_in_tx),
                        .tx_old_scr_data_in	 (tx_old_scr_data_in),
                        .tx_old_scr_data_out (tx_old_scr_data_out),
                        .start_fifo         (start_fifo),
                        .start_fifo_rd      (start_fifo_rd),
                        .pcs_sync           (pcs_sync),
                        // Outputs
                        .txlf               (txlf),
                        .spill              (tx_fifo_spill),
                        .tx_data_out        (tx_data_out[63:0]),
                        .tx_header_out      (tx_header_out[1:0]),
                        .tx_sequence_out    (tx_sequence_out),
                        .terminate_out      (terminate_out_tx),
                        .start_out          (start_out_tx),
                        .scram_en           (scram_en)
                        );

rx_path_rx INST_rx_path(   // Input Ports
                        .clk156             (clk156),
                        .rx_clk161          (rx_clk161),
                        .arstb              (reset_rx_n),
                        .rx_jtm_en          (rx_jtm_en),
                        .bypass_descram     (bypass_descram),
                        .bypass_66decoder   (bypass_66decoder),
                        .clear_errblk       (clear_errblk),
                        .clear_ber_cnt      (clear_ber_cnt),
                        //.lpbk               (1'b0),
                        .lpbk               (1'b1),
                        // New inputs.
                        .rx_header_valid_in (rx_header_valid_in),
                        .rx_header_in       (rx_header_in[1:0]),
                        .rx_data_valid_in   (rx_data_valid_in),
                        .rx_data_in         (rx_data_in[63:0]),
                        .rx_old_header_in   (rx_old_header_in),
                        .rx_old_data_in     (rx_old_data_in),
                        .terminate_in       (terminate_in_rx),
                        .start_in           (start_in_rx),
                        // .gap                (gap),
                        // .setIPG             (setIPG),
                        .is_alig            (is_alig),
                        .fifo_in            (fifo_in),
                        .val_in             (val_in),

                        // Output Ports
                        .xgmii_rxc          (xgmii_rxc[7:0]),
                        .xgmii_rxd          (xgmii_rxd[63:0]),
                        .jtest_errc_out     (jtest_errc),
                        .ber_cnt            (ber_cnt),
                        .hi_ber             (hi_ber),
                        .blk_lock           (blk_lock),
                        .linkstatus         (linkstatus),
                        .spill              (rx_fifo_spill),
                        .rxlf               (rxlf),
                        .errd_blks          (errd_blks),
                        .rxgearboxslip_out  (rxgearboxslip_out),
                        .terminate_out      (terminate_out_rx),
                        .start_out          (start_out_rx),
                        .RDEN_FIFO_PCS40    (RDEN_FIFO_PCS40),
                        .dscr_out           (dscr_out),
                        .start_fifo         (start_fifo)
                        );

endmodule
