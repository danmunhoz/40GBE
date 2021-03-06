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

module  scramble ( TXD_encoded, tx_jtm_en, jtm_dps_0, jtm_dps_1, seed_A, seed_B, bypass_scram, TXD_Scr, clk, rst, scram_en);
   
   input tx_jtm_en,jtm_dps_0,jtm_dps_1 ; wire tx_jtm_en,jtm_dps_0,jtm_dps_1 ;
   input bypass_scram ; wire bypass_scram ;
   input clk ; wire clk ;
   input rst ; wire rst ;
   input [57:0] seed_A, seed_B; wire [57:0] seed_A, seed_B;
   input [65:0] TXD_encoded; wire [65:0] TXD_encoded;
   input        scram_en; wire scram_en;
   output [65:0] TXD_Scr ; reg [65:0] TXD_Scr ;
   
   reg [57:0]    Scrambler_Register;
   reg [63:0]    TXD_input;
   reg [1:0]     Sync_header;
   reg [6:0]     jtm_counter;
   reg [1:0]     current_jtm_state,next_jtm_state; 
   wire [63:0]   Scr_wire;
   
   assign Scr_wire[0] = TXD_input[0]^Scrambler_Register[38]^Scrambler_Register[57];
   assign Scr_wire[1] = TXD_input[1]^Scrambler_Register[37]^Scrambler_Register[56];
   assign Scr_wire[2] = TXD_input[2]^Scrambler_Register[36]^Scrambler_Register[55];
   assign Scr_wire[3] = TXD_input[3]^Scrambler_Register[35]^Scrambler_Register[54];
   assign Scr_wire[4] = TXD_input[4]^Scrambler_Register[34]^Scrambler_Register[53];
   assign Scr_wire[5] = TXD_input[5]^Scrambler_Register[33]^Scrambler_Register[52];
   assign Scr_wire[6] = TXD_input[6]^Scrambler_Register[32]^Scrambler_Register[51];
   assign Scr_wire[7] = TXD_input[7]^Scrambler_Register[31]^Scrambler_Register[50];
   
   assign Scr_wire[8] = TXD_input[8]^Scrambler_Register[30]^Scrambler_Register[49];
   assign Scr_wire[9] = TXD_input[9]^Scrambler_Register[29]^Scrambler_Register[48];
   assign Scr_wire[10] = TXD_input[10]^Scrambler_Register[28]^Scrambler_Register[47];
   assign Scr_wire[11] = TXD_input[11]^Scrambler_Register[27]^Scrambler_Register[46];
   assign Scr_wire[12] = TXD_input[12]^Scrambler_Register[26]^Scrambler_Register[45];
   assign Scr_wire[13] = TXD_input[13]^Scrambler_Register[25]^Scrambler_Register[44];
   assign Scr_wire[14] = TXD_input[14]^Scrambler_Register[24]^Scrambler_Register[43];
   assign Scr_wire[15] = TXD_input[15]^Scrambler_Register[23]^Scrambler_Register[42];
   
   assign Scr_wire[16] = TXD_input[16]^Scrambler_Register[22]^Scrambler_Register[41];
   assign Scr_wire[17] = TXD_input[17]^Scrambler_Register[21]^Scrambler_Register[40];
   assign Scr_wire[18] = TXD_input[18]^Scrambler_Register[20]^Scrambler_Register[39];
   assign Scr_wire[19] = TXD_input[19]^Scrambler_Register[19]^Scrambler_Register[38];
   assign Scr_wire[20] = TXD_input[20]^Scrambler_Register[18]^Scrambler_Register[37];
   assign Scr_wire[21] = TXD_input[21]^Scrambler_Register[17]^Scrambler_Register[36];
   assign Scr_wire[22] = TXD_input[22]^Scrambler_Register[16]^Scrambler_Register[35];
   assign Scr_wire[23] = TXD_input[23]^Scrambler_Register[15]^Scrambler_Register[34];
   
   assign Scr_wire[24] = TXD_input[24]^Scrambler_Register[14]^Scrambler_Register[33];
   assign Scr_wire[25] = TXD_input[25]^Scrambler_Register[13]^Scrambler_Register[32];
   assign Scr_wire[26] = TXD_input[26]^Scrambler_Register[12]^Scrambler_Register[31];
   assign Scr_wire[27] = TXD_input[27]^Scrambler_Register[11]^Scrambler_Register[30];
   assign Scr_wire[28] = TXD_input[28]^Scrambler_Register[10]^Scrambler_Register[29];
   assign Scr_wire[29] = TXD_input[29]^Scrambler_Register[9]^Scrambler_Register[28];
   assign Scr_wire[30] = TXD_input[30]^Scrambler_Register[8]^Scrambler_Register[27];
   assign Scr_wire[31] = TXD_input[31]^Scrambler_Register[7]^Scrambler_Register[26];
   
   assign Scr_wire[32] = TXD_input[32]^Scrambler_Register[6]^Scrambler_Register[25];
   assign Scr_wire[33] = TXD_input[33]^Scrambler_Register[5]^Scrambler_Register[24];
   assign Scr_wire[34] = TXD_input[34]^Scrambler_Register[4]^Scrambler_Register[23];
   assign Scr_wire[35] = TXD_input[35]^Scrambler_Register[3]^Scrambler_Register[22];
   assign Scr_wire[36] = TXD_input[36]^Scrambler_Register[2]^Scrambler_Register[21];
   assign Scr_wire[37] = TXD_input[37]^Scrambler_Register[1]^Scrambler_Register[20];
   assign Scr_wire[38] = TXD_input[38]^Scrambler_Register[0]^Scrambler_Register[19];
   //assign Scr_wire[39] = TXD_input[39]^Scr_wire[0]^Scrambler_Register[18];
   assign Scr_wire[39] = TXD_input[39]^TXD_input[0]^Scrambler_Register[38]^Scrambler_Register[57]^Scrambler_Register[18];
   //assign Scr_wire[40] = TXD_input[40]^Scr_wire[1]^Scrambler_Register[17];
   assign Scr_wire[40] = TXD_input[40]^(TXD_input[1]^Scrambler_Register[37]^Scrambler_Register[56])^Scrambler_Register[17];
   //assign Scr_wire[41] = TXD_input[41]^Scr_wire[2]^Scrambler_Register[16];
   assign Scr_wire[41] = TXD_input[41]^(TXD_input[2]^Scrambler_Register[36]^Scrambler_Register[55])^Scrambler_Register[16];
   //assign Scr_wire[42] = TXD_input[42]^Scr_wire[3]^Scrambler_Register[15];
   assign Scr_wire[42] = TXD_input[42]^(TXD_input[3]^Scrambler_Register[35]^Scrambler_Register[54])^Scrambler_Register[15];
   //assign Scr_wire[43] = TXD_input[43]^Scr_wire[4]^Scrambler_Register[14];
   assign Scr_wire[43] = TXD_input[43]^(TXD_input[4]^Scrambler_Register[34]^Scrambler_Register[53])^Scrambler_Register[14];
   //assign Scr_wire[44] = TXD_input[44]^Scr_wire[5]^Scrambler_Register[13];
   assign Scr_wire[44] = TXD_input[44]^(TXD_input[5]^Scrambler_Register[33]^Scrambler_Register[52])^Scrambler_Register[13];
   //assign Scr_wire[45] = TXD_input[45]^Scr_wire[6]^Scrambler_Register[12];
   assign Scr_wire[45] = TXD_input[45]^(TXD_input[6]^Scrambler_Register[32]^Scrambler_Register[51])^Scrambler_Register[12];
   //assign Scr_wire[46] = TXD_input[46]^Scr_wire[7]^Scrambler_Register[11];
   assign Scr_wire[46] = TXD_input[46]^(TXD_input[7]^Scrambler_Register[31]^Scrambler_Register[50])^Scrambler_Register[11];
   //assign Scr_wire[47] = TXD_input[47]^Scr_wire[8]^Scrambler_Register[10];
   assign Scr_wire[47] = TXD_input[47]^(TXD_input[8]^Scrambler_Register[30]^Scrambler_Register[49])^Scrambler_Register[10];
   
   //assign Scr_wire[48] = TXD_input[48]^Scr_wire[9]^Scrambler_Register[9];
   assign Scr_wire[48] = TXD_input[48]^(TXD_input[9]^Scrambler_Register[29]^Scrambler_Register[48])^Scrambler_Register[9];
   //assign Scr_wire[49] = TXD_input[49]^Scr_wire[10]^Scrambler_Register[8];
   assign Scr_wire[49] = TXD_input[49]^(TXD_input[10]^Scrambler_Register[28]^Scrambler_Register[47])^Scrambler_Register[8];
   //assign Scr_wire[50] = TXD_input[50]^Scr_wire[11]^Scrambler_Register[7];
   assign Scr_wire[50] = TXD_input[50]^(TXD_input[11]^Scrambler_Register[27]^Scrambler_Register[46])^Scrambler_Register[7];
   //assign Scr_wire[51] = TXD_input[51]^Scr_wire[12]^Scrambler_Register[6];
   assign Scr_wire[51] = TXD_input[51]^(TXD_input[12]^Scrambler_Register[26]^Scrambler_Register[45])^Scrambler_Register[6];
   //assign Scr_wire[52] = TXD_input[52]^Scr_wire[13]^Scrambler_Register[5];
   assign Scr_wire[52] = TXD_input[52]^(TXD_input[13]^Scrambler_Register[25]^Scrambler_Register[44])^Scrambler_Register[5];
   //assign Scr_wire[53] = TXD_input[53]^Scr_wire[14]^Scrambler_Register[4];
   assign Scr_wire[53] = TXD_input[53]^(TXD_input[14]^Scrambler_Register[24]^Scrambler_Register[43])^Scrambler_Register[4];
   //assign Scr_wire[54] = TXD_input[54]^Scr_wire[15]^Scrambler_Register[3];
   assign Scr_wire[54] = TXD_input[54]^(TXD_input[15]^Scrambler_Register[23]^Scrambler_Register[42])^Scrambler_Register[3];
   //assign Scr_wire[55] = TXD_input[55]^Scr_wire[16]^Scrambler_Register[2];
   assign Scr_wire[55] = TXD_input[55]^(TXD_input[16]^Scrambler_Register[22]^Scrambler_Register[41])^Scrambler_Register[2];
   
   //assign Scr_wire[56] = TXD_input[56]^Scr_wire[17]^Scrambler_Register[1];
   assign Scr_wire[56] = TXD_input[56]^(TXD_input[17]^Scrambler_Register[21]^Scrambler_Register[40])^Scrambler_Register[1];
   //assign Scr_wire[57] = TXD_input[57]^Scr_wire[18]^Scrambler_Register[0];
   assign Scr_wire[57] = TXD_input[57]^(TXD_input[18]^Scrambler_Register[20]^Scrambler_Register[39])^Scrambler_Register[0];
   //assign Scr_wire[58] = TXD_input[58]^Scr_wire[19]^Scr_wire[0];
   assign Scr_wire[58] = TXD_input[58]^(TXD_input[19]^Scrambler_Register[19]^Scrambler_Register[38])^(TXD_input[0]^Scrambler_Register[38]^Scrambler_Register[57]);
   //assign Scr_wire[59] = TXD_input[59]^Scr_wire[20]^Scr_wire[1];
   assign Scr_wire[59] = TXD_input[59]^(TXD_input[20]^Scrambler_Register[18]^Scrambler_Register[37])^(TXD_input[1]^Scrambler_Register[37]^Scrambler_Register[56]);
   //assign Scr_wire[60] = TXD_input[60]^Scr_wire[21]^Scr_wire[2];
   assign Scr_wire[60] = TXD_input[60]^(TXD_input[21]^Scrambler_Register[17]^Scrambler_Register[36])^(TXD_input[2]^Scrambler_Register[36]^Scrambler_Register[55]);
   //assign Scr_wire[61] = TXD_input[61]^Scr_wire[22]^Scr_wire[3];
   assign Scr_wire[61] = TXD_input[61]^(TXD_input[22]^Scrambler_Register[16]^Scrambler_Register[35])^(TXD_input[3]^Scrambler_Register[35]^Scrambler_Register[54]);
   //assign Scr_wire[62] = TXD_input[62]^Scr_wire[23]^Scr_wire[4];
   assign Scr_wire[62] = TXD_input[62]^(TXD_input[23]^Scrambler_Register[15]^Scrambler_Register[34])^(TXD_input[4]^Scrambler_Register[34]^Scrambler_Register[53]);
   //assign Scr_wire[63] = TXD_input[63]^Scr_wire[24]^Scr_wire[5];
   assign Scr_wire[63] = TXD_input[63]^(TXD_input[24]^Scrambler_Register[14]^Scrambler_Register[33])^(TXD_input[5]^Scrambler_Register[33]^Scrambler_Register[52]);
   
   
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
        TXD_input[63:0] <= TXD_encoded[65:2];
        Sync_header[1:0] <= TXD_encoded[1:0];
      	TXD_Scr[65:0] <= {TXD_input[63:0],Sync_header[1:0]};
	    jtm_counter   <= 7'h0;
	    current_jtm_state <=  2'h0;
	    next_jtm_state <=  2'h0;	  
     end
   
     else begin
	    if (!tx_jtm_en)  // Jitter test Disabled
	      begin
      	     TXD_input[63:0] <= TXD_encoded[65:2];
             Sync_header[1:0] <= TXD_encoded[1:0];
	         TXD_Scr[65:0] <= {Scr_wire[63:0], Sync_header[1:0]};
             jtm_counter   <= 7'h0;
	         current_jtm_state <=  2'h0;
	         next_jtm_state <=  2'h0;
	         
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
