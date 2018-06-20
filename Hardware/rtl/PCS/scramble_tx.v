//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: scramble.v
//
//
// Start of Coding Date: Thu Mar 29 2001 ( 9:00 am)
//
// File Name : scramble.v
//
// Description: This is a scrambler to be used in an 64/66 encoder.
//              This scrambler is capable of processing 64-bit words
//              provided by the encoder
//
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
// $Log: scramble.v,v $
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

module  scramble_tx ( TXD_encoded, tx_jtm_en, jtm_dps_0, jtm_dps_1, seed_A, seed_B,
                      bypass_scram, TXD_Scr, clk, rst, scram_en,
                      tx_old_encod_data_in);

   input tx_jtm_en,jtm_dps_0,jtm_dps_1 ; wire tx_jtm_en,jtm_dps_0,jtm_dps_1 ;
   input bypass_scram ; wire bypass_scram ;
   input clk ; wire clk ;
   input rst ; wire rst ;
   input [57:0] seed_A, seed_B; wire [57:0] seed_A, seed_B;
   input [65:0] TXD_encoded; wire [65:0] TXD_encoded;
   input        scram_en; wire scram_en;
   output [65:0] TXD_Scr ; reg [65:0] TXD_Scr ;

   input [65:0]	  tx_old_encod_data_in;

   reg [57:0]    Scrambler_Register;
   reg [63:0]    TXD_input;
   reg [1:0]     Sync_header;
   reg [6:0]     jtm_counter;
   reg [1:0]     current_jtm_state,next_jtm_state;
   wire [63:0]   Scr_wire;
   reg [63:0]    Scr_wire_reg;

   reg  [63:0]   tx_old_block;
   reg  [57:0]   tx_old_block_scr;

   reg [63:0] TXD_data_sync;
   reg [1:0]  TXD_hdr_sync;
   reg [1:0]  TXD_hdr_sync_reg;

   always @ (posedge clk or negedge rst) begin
     if (!rst) begin
       tx_old_block[63:0] <= 64'h0;
       TXD_data_sync[63:0] <= 64'h0;
     end
       tx_old_block[63:0] <= tx_old_encod_data_in[63:0];
       TXD_data_sync[63:0] <= TXD_encoded[65:2];
       TXD_hdr_sync[1:0] <= TXD_encoded[1:0];
   end

   always @ ( tx_old_block or rst or TXD_data_sync) begin
      if (!rst) begin
        tx_old_block_scr[57:0] <= 58'h3;
      end
      else begin
        tx_old_block_scr[57] <= tx_old_block[6];
        tx_old_block_scr[56] <= tx_old_block[7];
        tx_old_block_scr[55] <= tx_old_block[8];
        tx_old_block_scr[54] <= tx_old_block[9];
        tx_old_block_scr[53] <= tx_old_block[10];
        tx_old_block_scr[52] <= tx_old_block[11];
        tx_old_block_scr[51] <= tx_old_block[12];
        tx_old_block_scr[50] <= tx_old_block[13];

        tx_old_block_scr[49] <= tx_old_block[14];
        tx_old_block_scr[48] <= tx_old_block[15];
        tx_old_block_scr[47] <= tx_old_block[16];
        tx_old_block_scr[46] <= tx_old_block[17];
        tx_old_block_scr[45] <= tx_old_block[18];
        tx_old_block_scr[44] <= tx_old_block[19];
        tx_old_block_scr[43] <= tx_old_block[20];
        tx_old_block_scr[42] <= tx_old_block[21];

        tx_old_block_scr[41] <= tx_old_block[22];
        tx_old_block_scr[40] <= tx_old_block[23];
        tx_old_block_scr[39] <= tx_old_block[24];
        tx_old_block_scr[38] <= tx_old_block[25];
        tx_old_block_scr[37] <= tx_old_block[26];
        tx_old_block_scr[36] <= tx_old_block[27];
        tx_old_block_scr[35] <= tx_old_block[28];
        tx_old_block_scr[34] <= tx_old_block[29];

        tx_old_block_scr[33] <= tx_old_block[30];
        tx_old_block_scr[32] <= tx_old_block[31];
        tx_old_block_scr[31] <= tx_old_block[32];
        tx_old_block_scr[30] <= tx_old_block[33];
        tx_old_block_scr[29] <= tx_old_block[34];
        tx_old_block_scr[28] <= tx_old_block[35];
        tx_old_block_scr[27] <= tx_old_block[36];
        tx_old_block_scr[26] <= tx_old_block[37];

        tx_old_block_scr[25] <= tx_old_block[38];
        tx_old_block_scr[24] <= tx_old_block[39];
        tx_old_block_scr[23] <= tx_old_block[40];
        tx_old_block_scr[22] <= tx_old_block[41];
        tx_old_block_scr[21] <= tx_old_block[42];
        tx_old_block_scr[20] <= tx_old_block[43];
        tx_old_block_scr[19] <= tx_old_block[44];
        tx_old_block_scr[18] <= tx_old_block[45];

        tx_old_block_scr[17] <= tx_old_block[46];
        tx_old_block_scr[16] <= tx_old_block[47];
        tx_old_block_scr[15] <= tx_old_block[48];
        tx_old_block_scr[14] <= tx_old_block[49];
        tx_old_block_scr[13] <= tx_old_block[50];
        tx_old_block_scr[12] <= tx_old_block[51];
        tx_old_block_scr[11] <= tx_old_block[52];
        tx_old_block_scr[10] <= tx_old_block[53];

        tx_old_block_scr[9]  <= tx_old_block[54];
        tx_old_block_scr[8]  <= tx_old_block[55];
        tx_old_block_scr[7]  <= tx_old_block[56];
        tx_old_block_scr[6]  <= tx_old_block[57];
        tx_old_block_scr[5]  <= tx_old_block[58];
        tx_old_block_scr[4]  <= tx_old_block[59];
        tx_old_block_scr[3]  <= tx_old_block[60];
        tx_old_block_scr[2]  <= tx_old_block[61];
        tx_old_block_scr[1]  <= tx_old_block[62];
        tx_old_block_scr[0]  <= tx_old_block[63];
        //  end
      end
    end

   assign Scr_wire[0] =  TXD_data_sync[0]^ tx_old_block_scr[38]^tx_old_block_scr[57];
   assign Scr_wire[1] =  TXD_data_sync[1]^ tx_old_block_scr[37]^tx_old_block_scr[56];
   assign Scr_wire[2] =  TXD_data_sync[2]^ tx_old_block_scr[36]^tx_old_block_scr[55];
   assign Scr_wire[3] =  TXD_data_sync[3]^ tx_old_block_scr[35]^tx_old_block_scr[54];
   assign Scr_wire[4] =  TXD_data_sync[4]^ tx_old_block_scr[34]^tx_old_block_scr[53];
   assign Scr_wire[5] =  TXD_data_sync[5]^ tx_old_block_scr[33]^tx_old_block_scr[52];
   assign Scr_wire[6] =  TXD_data_sync[6]^ tx_old_block_scr[32]^tx_old_block_scr[51];
   assign Scr_wire[7] =  TXD_data_sync[7]^ tx_old_block_scr[31]^tx_old_block_scr[50];

   assign Scr_wire[8] =  TXD_data_sync[8]^ tx_old_block_scr[30]^tx_old_block_scr[49];
   assign Scr_wire[9] =  TXD_data_sync[9]^ tx_old_block_scr[29]^tx_old_block_scr[48];
   assign Scr_wire[10] = TXD_data_sync[10]^tx_old_block_scr[28]^tx_old_block_scr[47];
   assign Scr_wire[11] = TXD_data_sync[11]^tx_old_block_scr[27]^tx_old_block_scr[46];
   assign Scr_wire[12] = TXD_data_sync[12]^tx_old_block_scr[26]^tx_old_block_scr[45];
   assign Scr_wire[13] = TXD_data_sync[13]^tx_old_block_scr[25]^tx_old_block_scr[44];
   assign Scr_wire[14] = TXD_data_sync[14]^tx_old_block_scr[24]^tx_old_block_scr[43];
   assign Scr_wire[15] = TXD_data_sync[15]^tx_old_block_scr[23]^tx_old_block_scr[42];

   assign Scr_wire[16] = TXD_data_sync[16]^tx_old_block_scr[22]^tx_old_block_scr[41];
   assign Scr_wire[17] = TXD_data_sync[17]^tx_old_block_scr[21]^tx_old_block_scr[40];
   assign Scr_wire[18] = TXD_data_sync[18]^tx_old_block_scr[20]^tx_old_block_scr[39];
   assign Scr_wire[19] = TXD_data_sync[19]^tx_old_block_scr[19]^tx_old_block_scr[38];
   assign Scr_wire[20] = TXD_data_sync[20]^tx_old_block_scr[18]^tx_old_block_scr[37];
   assign Scr_wire[21] = TXD_data_sync[21]^tx_old_block_scr[17]^tx_old_block_scr[36];
   assign Scr_wire[22] = TXD_data_sync[22]^tx_old_block_scr[16]^tx_old_block_scr[35];
   assign Scr_wire[23] = TXD_data_sync[23]^tx_old_block_scr[15]^tx_old_block_scr[34];

   assign Scr_wire[24] = TXD_data_sync[24]^tx_old_block_scr[14]^tx_old_block_scr[33];
   assign Scr_wire[25] = TXD_data_sync[25]^tx_old_block_scr[13]^tx_old_block_scr[32];
   assign Scr_wire[26] = TXD_data_sync[26]^tx_old_block_scr[12]^tx_old_block_scr[31];
   assign Scr_wire[27] = TXD_data_sync[27]^tx_old_block_scr[11]^tx_old_block_scr[30];
   assign Scr_wire[28] = TXD_data_sync[28]^tx_old_block_scr[10]^tx_old_block_scr[29];
   assign Scr_wire[29] = TXD_data_sync[29]^tx_old_block_scr[9]^ tx_old_block_scr[28];
   assign Scr_wire[30] = TXD_data_sync[30]^tx_old_block_scr[8]^ tx_old_block_scr[27];
   assign Scr_wire[31] = TXD_data_sync[31]^tx_old_block_scr[7]^ tx_old_block_scr[26];

   assign Scr_wire[32] = TXD_data_sync[32]^tx_old_block_scr[6]^ tx_old_block_scr[25];
   assign Scr_wire[33] = TXD_data_sync[33]^tx_old_block_scr[5]^ tx_old_block_scr[24];
   assign Scr_wire[34] = TXD_data_sync[34]^tx_old_block_scr[4]^ tx_old_block_scr[23];
   assign Scr_wire[35] = TXD_data_sync[35]^tx_old_block_scr[3]^ tx_old_block_scr[22];
   assign Scr_wire[36] = TXD_data_sync[36]^tx_old_block_scr[2]^ tx_old_block_scr[21];
   assign Scr_wire[37] = TXD_data_sync[37]^tx_old_block_scr[1]^ tx_old_block_scr[20];
   assign Scr_wire[38] = TXD_data_sync[38]^tx_old_block_scr[0]^ tx_old_block_scr[19];

   assign Scr_wire[39] = TXD_data_sync[39]^ TXD_data_sync[0]^tx_old_block_scr[38]^tx_old_block_scr[57]^ tx_old_block_scr[18];
   assign Scr_wire[40] = TXD_data_sync[40]^(TXD_data_sync[1]^tx_old_block_scr[37]^tx_old_block_scr[56])^tx_old_block_scr[17];
   assign Scr_wire[41] = TXD_data_sync[41]^(TXD_data_sync[2]^tx_old_block_scr[36]^tx_old_block_scr[55])^tx_old_block_scr[16];
   assign Scr_wire[42] = TXD_data_sync[42]^(TXD_data_sync[3]^tx_old_block_scr[35]^tx_old_block_scr[54])^tx_old_block_scr[15];
   assign Scr_wire[43] = TXD_data_sync[43]^(TXD_data_sync[4]^tx_old_block_scr[34]^tx_old_block_scr[53])^tx_old_block_scr[14];
   assign Scr_wire[44] = TXD_data_sync[44]^(TXD_data_sync[5]^tx_old_block_scr[33]^tx_old_block_scr[52])^tx_old_block_scr[13];
   assign Scr_wire[45] = TXD_data_sync[45]^(TXD_data_sync[6]^tx_old_block_scr[32]^tx_old_block_scr[51])^tx_old_block_scr[12];
   assign Scr_wire[46] = TXD_data_sync[46]^(TXD_data_sync[7]^tx_old_block_scr[31]^tx_old_block_scr[50])^tx_old_block_scr[11];
   assign Scr_wire[47] = TXD_data_sync[47]^(TXD_data_sync[8]^tx_old_block_scr[30]^tx_old_block_scr[49])^tx_old_block_scr[10];

   assign Scr_wire[48] = TXD_data_sync[48]^(TXD_data_sync[9]^tx_old_block_scr[29]^tx_old_block_scr[48])^tx_old_block_scr[9];
   assign Scr_wire[49] = TXD_data_sync[49]^(TXD_data_sync[10]^tx_old_block_scr[28]^tx_old_block_scr[47])^tx_old_block_scr[8];
   assign Scr_wire[50] = TXD_data_sync[50]^(TXD_data_sync[11]^tx_old_block_scr[27]^tx_old_block_scr[46])^tx_old_block_scr[7];
   assign Scr_wire[51] = TXD_data_sync[51]^(TXD_data_sync[12]^tx_old_block_scr[26]^tx_old_block_scr[45])^tx_old_block_scr[6];
   assign Scr_wire[52] = TXD_data_sync[52]^(TXD_data_sync[13]^tx_old_block_scr[25]^tx_old_block_scr[44])^tx_old_block_scr[5];
   assign Scr_wire[53] = TXD_data_sync[53]^(TXD_data_sync[14]^tx_old_block_scr[24]^tx_old_block_scr[43])^tx_old_block_scr[4];
   assign Scr_wire[54] = TXD_data_sync[54]^(TXD_data_sync[15]^tx_old_block_scr[23]^tx_old_block_scr[42])^tx_old_block_scr[3];
   assign Scr_wire[55] = TXD_data_sync[55]^(TXD_data_sync[16]^tx_old_block_scr[22]^tx_old_block_scr[41])^tx_old_block_scr[2];

   assign Scr_wire[56] = TXD_data_sync[56]^(TXD_data_sync[17]^tx_old_block_scr[21]^tx_old_block_scr[40])^tx_old_block_scr[1];
   assign Scr_wire[57] = TXD_data_sync[57]^(TXD_data_sync[18]^tx_old_block_scr[20]^tx_old_block_scr[39])^tx_old_block_scr[0];
   assign Scr_wire[58] = TXD_data_sync[58]^(TXD_data_sync[19]^tx_old_block_scr[19]^tx_old_block_scr[38])^(TXD_data_sync[0]^tx_old_block_scr[38]^tx_old_block_scr[57]);
   assign Scr_wire[59] = TXD_data_sync[59]^(TXD_data_sync[20]^tx_old_block_scr[18]^tx_old_block_scr[37])^(TXD_data_sync[1]^tx_old_block_scr[37]^tx_old_block_scr[56]);
   assign Scr_wire[60] = TXD_data_sync[60]^(TXD_data_sync[21]^tx_old_block_scr[17]^tx_old_block_scr[36])^(TXD_data_sync[2]^tx_old_block_scr[36]^tx_old_block_scr[55]);
   assign Scr_wire[61] = TXD_data_sync[61]^(TXD_data_sync[22]^tx_old_block_scr[16]^tx_old_block_scr[35])^(TXD_data_sync[3]^tx_old_block_scr[35]^tx_old_block_scr[54]);
   assign Scr_wire[62] = TXD_data_sync[62]^(TXD_data_sync[23]^tx_old_block_scr[15]^tx_old_block_scr[34])^(TXD_data_sync[4]^tx_old_block_scr[34]^tx_old_block_scr[53]);
   assign Scr_wire[63] = TXD_data_sync[63]^(TXD_data_sync[24]^tx_old_block_scr[14]^tx_old_block_scr[33])^(TXD_data_sync[5]^tx_old_block_scr[33]^tx_old_block_scr[52]);


   always @(posedge clk or posedge rst)
     if (rst) begin
      Scrambler_Register[57:0] <= 58'h3;
      TXD_input[63:0] <= 0;
      Sync_header[1:0] <= 2'b10;
      TXD_Scr[65:0] <= 66'h2;
	    jtm_counter   <= 7'h0;
	    current_jtm_state <=  2'h0;
      next_jtm_state <=  2'h0;
     end

     else if (!scram_en) begin
	    Scrambler_Register[57:0] <= Scrambler_Register[57:0];
      TXD_input[63:0] <= TXD_input[63:0];
      Sync_header[1:0] <= Sync_header[1:0];
      TXD_Scr[65:0] <= TXD_Scr[65:0];
	    jtm_counter   <= jtm_counter;
	    current_jtm_state <=  current_jtm_state;
      next_jtm_state <=  next_jtm_state;
     end

     else if (bypass_scram) begin
      jtm_counter   <= 7'h0;
      current_jtm_state <=  2'h0;
      next_jtm_state <=  2'h0;
      TXD_input[63:0] <= TXD_encoded[65:2];
      Sync_header[1:0] <= TXD_encoded[1:0];
      TXD_Scr[65:0] <= {TXD_input[63:0],Sync_header[1:0]};
     end

     else begin
	    if (!tx_jtm_en)  // Jitter test Disabled
	      begin
      	     TXD_input[63:0] <= TXD_encoded[65:2];
             Sync_header[1:0] <= TXD_encoded[1:0];
	           TXD_Scr[65:0] <= {Scr_wire[63:0], TXD_hdr_sync[1:0]};
             jtm_counter   <= 7'h0;
	           current_jtm_state <=  2'h0;
	           next_jtm_state <=  2'h0;

	      end // if (!tx_jtm_en)
	    else          // Jitter Test enabled
	      begin
             // in Jitter test mode input data select
	         if (!jtm_dps_1)  //pseudo random test
	           begin
	              jtm_counter <= jtm_counter + 1;

                  TXD_Scr[65:0] <= {Scr_wire[63:0],2'b10};
                  if (jtm_counter != 0) begin
		             current_jtm_state <= next_jtm_state;
		             Scrambler_Register[57] <= Scr_wire[6];
      		         Scrambler_Register[56] <= Scr_wire[7];
      		         Scrambler_Register[55] <= Scr_wire[8];
      		         Scrambler_Register[54] <= Scr_wire[9];
      		         Scrambler_Register[53] <= Scr_wire[10];
      		         Scrambler_Register[52] <= Scr_wire[11];
      		         Scrambler_Register[51] <= Scr_wire[12];
      		         Scrambler_Register[50] <= Scr_wire[13];

		             Scrambler_Register[49] <= Scr_wire[14];
      		         Scrambler_Register[48] <= Scr_wire[15];
      		         Scrambler_Register[47] <= Scr_wire[16];
      		         Scrambler_Register[46] <= Scr_wire[17];
      		         Scrambler_Register[45] <= Scr_wire[18];
      		         Scrambler_Register[44] <= Scr_wire[19];
      		         Scrambler_Register[43] <= Scr_wire[20];
      		         Scrambler_Register[42] <= Scr_wire[21];

		             Scrambler_Register[41] <= Scr_wire[22];
   		             Scrambler_Register[40] <= Scr_wire[23];
      		         Scrambler_Register[39] <= Scr_wire[24];
      		         Scrambler_Register[38] <= Scr_wire[25];
      		         Scrambler_Register[37] <= Scr_wire[26];
      		         Scrambler_Register[36] <= Scr_wire[27];
      		         Scrambler_Register[35] <= Scr_wire[28];
      		         Scrambler_Register[34] <= Scr_wire[29];

		             Scrambler_Register[33] <= Scr_wire[30];
      		         Scrambler_Register[32] <= Scr_wire[31];
      		         Scrambler_Register[31] <= Scr_wire[32];
      		         Scrambler_Register[30] <= Scr_wire[33];
      		         Scrambler_Register[29] <= Scr_wire[34];
      		         Scrambler_Register[28] <= Scr_wire[35];
      		         Scrambler_Register[27] <= Scr_wire[36];
      		         Scrambler_Register[26] <= Scr_wire[37];

		             Scrambler_Register[25] <= Scr_wire[38];
  		             Scrambler_Register[24] <= Scr_wire[39];
      		         Scrambler_Register[23] <= Scr_wire[40];
      		         Scrambler_Register[22] <= Scr_wire[41];
      		         Scrambler_Register[21] <= Scr_wire[42];
      		         Scrambler_Register[20] <= Scr_wire[43];
      		         Scrambler_Register[19] <= Scr_wire[44];
      		         Scrambler_Register[18] <= Scr_wire[45];

		             Scrambler_Register[17] <= Scr_wire[46];
      		         Scrambler_Register[16] <= Scr_wire[47];
      		         Scrambler_Register[15] <= Scr_wire[48];
      		         Scrambler_Register[14] <= Scr_wire[49];
      		         Scrambler_Register[13] <= Scr_wire[50];
      		         Scrambler_Register[12] <= Scr_wire[51];
      		         Scrambler_Register[11] <= Scr_wire[52];
      		         Scrambler_Register[10] <= Scr_wire[53];

		             Scrambler_Register[9] <= Scr_wire[54];
      		         Scrambler_Register[8] <= Scr_wire[55];
      		         Scrambler_Register[7] <= Scr_wire[56];
      		         Scrambler_Register[6] <= Scr_wire[57];
      		         Scrambler_Register[5] <= Scr_wire[58];
      		         Scrambler_Register[4] <= Scr_wire[59];
      		         Scrambler_Register[3] <= Scr_wire[60];
      		         Scrambler_Register[2] <= Scr_wire[61];
      		         Scrambler_Register[1] <= Scr_wire[62];
      		         Scrambler_Register[0] <= Scr_wire[63];
                  end // if (jtm_counter != 0)
	              else
	                begin
		               case (current_jtm_state)
		                 2'b00:	begin
                            Scrambler_Register <= seed_A;
			                if (jtm_dps_0)   // Zeros data pattern
		                      TXD_input[63:0] <= 64'h0;
			                else             // LF data Pattern
		                      TXD_input[63:0] <= `PCS_LF_OS;
			                next_jtm_state <= 2'b01;
		                 end
                         2'b01:	begin
                            Scrambler_Register <= ~seed_A;
			                if (jtm_dps_0)   // Zeros data pattern
		                      TXD_input[63:0] <= 64'hFFFFFFFFFFFFFFFF;
		                    else             // LF data Pattern
		                      TXD_input[63:0] <= ~`PCS_LF_OS;
                            next_jtm_state <= 2'b10;
                         end
		                 2'b10:	begin
                            Scrambler_Register <= seed_B;
			                if (jtm_dps_0)   // Zeros data pattern
		                      TXD_input[63:0] <= 64'h0;
		                    else             // LF data Pattern
		                      TXD_input[63:0] <= `PCS_LF_OS;
			                next_jtm_state <= 2'b11;
		                 end
                         2'b11:	begin
                            Scrambler_Register <= ~seed_B;
			                if (jtm_dps_0)   // Zeros data pattern
		                      TXD_input[63:0] <= 64'hFFFFFFFFFFFFFFFF;
		                    else             // LF data Pattern
		                      TXD_input[63:0] <= ~`PCS_LF_OS;
			                next_jtm_state <= 2'b00;
		                 end
                       endcase // case(current_jtm_state)
	                end // else: !if(jtm_counter != 0)

	           end // if (!jtm_dps_1)
	         else             // Square Wave Test
               begin         // I have temporarely chosen to send a sequence of 11 zeros and 11 ones
	              TXD_Scr[65:0] <= 66'h0007FF001FFC007FF;
	              current_jtm_state <= 2'b0;
	              jtm_counter <= 7'b0;
	           end // else: !if(!jtm_dps_1)

	      end // else: !if(!tx_jtm_en)


     end // else: !if(bypass_scram)

endmodule // scramble
