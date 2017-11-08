//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: rx_path.v
//
// Author: Justin Gaither
//
// Begin Date: Tue Jun 22 10:43:49 2004
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
// $Log: rx_path.v,v $
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

module rx_path_rx (/*AUTOARG*/
                // Inputs
                bypass_66decoder, bypass_descram, clear_ber_cnt, clear_errblk,
                clk156, lpbk, arstb, rx_jtm_en, rx_clk161,
                rx_header_in, rx_data_in, rx_header_valid_in, rx_data_valid_in,
                rx_old_header_in, rx_old_data_in, terminate_in, start_in,

		        // Outputs
		        ber_cnt, blk_lock, jtest_errc_out, errd_blks, hi_ber, rxlf,
		        spill, xgmii_rxc, xgmii_rxd, linkstatus, rxgearboxslip_out,
            terminate_out, start_out,
            // Para uso do Testbench
						start_fifo
		        );

    input           bypass_66decoder;
    input           bypass_descram;
    input           clear_ber_cnt;
    input           clear_errblk;
    input           clk156;
    input           rx_clk161;
    input           lpbk;
    input           arstb;
    input           rx_jtm_en;
    input [1:0]     rx_header_in;
    input [63:0]    rx_data_in;
    input           rx_header_valid_in;
    input           rx_data_valid_in;

    input [1:0]     rx_old_header_in;
    input [63:0]    rx_old_data_in;

    input           terminate_in;
    input           start_in;

    //For Testbench use
		input					start_fifo;

    output [5:0]    ber_cnt;
    output          blk_lock;
    output [15:0]   jtest_errc_out;
    output [7:0]    errd_blks;
    output          hi_ber;
    output          rxlf;
    output          spill;
    output [7:0]    xgmii_rxc;
    output [63:0]   xgmii_rxd;
    output          linkstatus;
    output          rxgearboxslip_out;

    output          terminate_out;
    output          start_out;

    wire [15:0]     jtest_errc_out;
    wire            blk_lock;
    wire            rxgearboxslip_out;
    wire [1:0]      rx_header_in;
    wire            rx_header_valid_in;
    wire            rx_data_valid_in;
    wire [5:0]      ber_cnt;
    wire            bypass_66decoder;
    wire            bypass_descram;
    wire [15:0]     jtest_errc;
    wire            lpbk;
    wire            clear_errblk;
    wire            clk156;
    wire [7:0]      errd_blks;
    wire            hi_ber;
    wire            spill;
    wire            rx_jtm_en;
    wire            rxlf;
    wire [7:0]      xgmii_rxc;
    wire [63:0]     xgmii_rxd;
    wire [65:0]     decoder_data_in;
    wire [65:0]     descram_data;
    wire [65:0]     descram_data_old;
    wire [65:0]     rxd_sync_out;
    wire [65:0]     rxd_sync_out_old;
    wire            rx_clk161;


    assign rxd_sync_out = {rx_data_in,rx_header_in};

   frame_sync  INST_FRAME_SYNC
   (
       //Inputs
       .rstb               (arstb),
       .rx_clk161          (rx_clk161),
       .rx_jtm_en          (rx_jtm_en),
       .clear_ber_count    (clear_ber_cnt),
       .rx_header_in       (rx_header_in),
       .rx_header_valid_in (rx_header_valid_in),

       //Outputs
       .hi_ber             (hi_ber),
       .blk_lock           (blk_lock),
       .linkstatus         (linkstatus),
       .ber_count          (ber_cnt[5:0]),
       .slip_out           (rxgearboxslip_out)
   );

   //   block_sync#
   //  (
   //      .SH_CNT_MAX(64),
   //      .SH_INVALID_CNT_MAX(16)
   //  )
   //  INST_BLOCK_SYNC
   //  (
   //      // User Interface
   //      .BLOCKSYNC_OUT        (blk_lock),
   //      .RXGEARBOXSLIP_OUT    (rxgearboxslip_out),
   //      .RXHEADER_IN          ({1'b0,rx_header_in}),
   //      .RXHEADERVALID_IN     (rx_header_valid_in),

   //      // System Interface
   //      .USER_CLK             (rx_clk161),
   //      .SYSTEM_RESET         (!arstb)
   //  );

   // assign linkstatus = blk_lock;

    descramble_rx  INST_RX_PATH_DESCRAMBLE_OLD
        (
         .clr_jtest_errc    (1'b0),
         .write_enable      (rx_data_valid_in),
         .bypass_descram    (bypass_descram),
         .rx_jtm_en         (rx_jtm_en),
         .blk_lock          (blk_lock),
         .jtest_errc        (jtest_errc),
         .RXD_Sync          (rxd_sync_out[65:0]),
         .DeScr_RXD         (descram_data[65:0]),
         .clk               (rx_clk161),
         .rstb              (arstb),
         .rx_old_header_in  (rx_old_header_in),
         .rx_old_data_in    (rx_old_data_in)
         );

  //  descramble  INST_RX_PATH_DESCRAMBLE
  //      (
  //       .clr_jtest_errc    (1'b0),
  //       .write_enable      (rx_data_valid_in),
  //       .bypass_descram    (bypass_descram),
  //       .rx_jtm_en         (rx_jtm_en),
  //       .blk_lock          (blk_lock),
  //       .jtest_errc        (jtest_errc),
  //       .RXD_Sync          (rxd_sync_out[65:0]),
  //       .DeScr_RXD         (descram_data[65:0]),
  //       .clk               (rx_clk161),
  //       .rstb              (arstb)
  //       );

    (* dont_touch = "true" *) opt_fifo_new  INST_RX_PATH_FIFO
        (
         .readdata          (decoder_data_in[65:0]),
         .spill             (spill),
         .rclk              (clk156),
         //.readen            (1'b1),
         .readen            (start_fifo),
         .wclk              (rx_clk161),
         .writen            (rx_data_valid_in),
        //  .writedata         (descram_data[65:0]),
        .writedata         (descram_data[65:0]),
         .rst               (!arstb)
         );

    Decode_rx  INST_RX_PATH_DECODER
        (
         .DeScr_RXD         (decoder_data_in[65:0]),
         .blk_lock          (blk_lock),
         .bypass_66decoder  (bypass_66decoder),
         .lpbk              (lpbk),
         .clear_errblk      (clear_errblk),
         .clk156            (clk156),
         .hi_ber            (hi_ber),
         .rstb156           (arstb),
         .rxlf              (rxlf),
         .errd_blks         (errd_blks[7:0]),
         .rxcontrol         (xgmii_rxc[7:0]),
         .rxdata            (xgmii_rxd[63:0]),
         .terminate_in      (terminate_in),
         .terminate_out     (terminate_out),
         .start_in          (start_in),
         .start_out         (start_out)
         );

    assign jtest_errc_out = jtest_errc;

endmodule
