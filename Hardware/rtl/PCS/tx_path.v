//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: tx_path_block.v
//
//
// Begin Date: Tue Jun 22 10:28:13 2004
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
// $Log: tx_path.v,v $
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

module tx_path (/*AUTOARG*/

		        // Outputs
		        //gb_data_out,
		        spill, txlf,tx_data_out, tx_header_out, tx_sequence_out,
		        // Inputs
		        bypass_66encoder, bypass_scram, clk156, tx_clk161, jtm_dps_0, jtm_dps_1,
		        arstb, seed_A, seed_B, tx_jtm_en,
		        xgmii_txc, xgmii_txd,
						// Para uso do Testbench
						start_fifo

		        );

// Inputs

    // Clocks
    input         tx_clk161;
    input         clk156;
    input         bypass_66encoder;
    input         bypass_scram;
    input         jtm_dps_0;
    input         jtm_dps_1;
    input [57:0]  seed_A;
    input [57:0]  seed_B;
    input         tx_jtm_en;
    input [7:0]   xgmii_txc;
    input [63:0]  xgmii_txd;
    input         arstb;

		//For Testbench use
		input					start_fifo;


    // Outputs
    output        spill;
    output        txlf;
    output [63:0] tx_data_out;
    output [1:0]  tx_header_out;
    output [6:0]  tx_sequence_out;


    wire          bypass_66encoder;
    wire          bypass_scram;
    wire          clk156;
    wire          jtm_dps_0;
    wire          jtm_dps_1;
    wire          arstb;
    wire [57:0]   seed_A;
    wire [57:0]   seed_B;
    wire          spill;
    wire          tx_jtm_en;
    wire          txlf;
    wire [7:0]    xgmii_txc;
    wire [63:0]   xgmii_txd;
    wire [65:0]   TXD_Scr;
    wire [65:0]   encoded_data;
    wire [65:0]   fifo_rd_data;
    wire          tx_clk161;
    wire [6:0]  tx_sequence_out;
    wire        data_pause;
    wire [63:0] tx_data_out;
    wire [1:0]  tx_header_out;

    assign tx_header_out = TXD_Scr[1:0];
    assign tx_data_out = TXD_Scr[65:2];

    txsequence_counter INST_txsequence_counter
        (
        .clk_161_in             (tx_clk161),
        .reset_n_in             (arstb),
        .TX_SEQUENCE_OUT        (tx_sequence_out),
        .DATA_PAUSE             (data_pause)
        );



    scramble  INST_TX_PATH_SCRAMBLE
        (
         .TXD_encoded           (fifo_rd_data[65:0]),
         .tx_jtm_en             (tx_jtm_en),
         .jtm_dps_0             (jtm_dps_0),
         .jtm_dps_1             (jtm_dps_1),
         .seed_A                (seed_A[57:0]),
         .seed_B                (seed_B[57:0]),
         .bypass_scram          (bypass_scram),
         .TXD_Scr               (TXD_Scr[65:0]),
         .clk                   (tx_clk161),
         .scram_en              (data_pause),
         .rst                   (!arstb)
         );

		opt_fifo_new  INST_TX_PATH_FIFO
         (
          .readdata              (fifo_rd_data[65:0]),
          .spill                 (spill),
          .rclk                  (tx_clk161),
          //.readen                (data_pause),
					.readen                (data_pause & start_fifo),
          .wclk                  (clk156),
          //.writen                (1'b1),
					.writen                (1'b1 & start_fifo),
          .writedata             (encoded_data[65:0]),
          .rst                   (!arstb)
          );

    Encode  INST_TX_PATH_ENCODE
        (
         .bypass_66encoder      (bypass_66encoder),
         .clk156                (clk156),
         .rstb                  (arstb),
         .txcontrol             (xgmii_txc[7:0]),
         .txdata                (xgmii_txd[63:0]),
         .TXD_encoded           (encoded_data[65:0]),
         .txlf                  (txlf)
         );

endmodule
