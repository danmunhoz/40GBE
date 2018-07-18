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

module  scramble_tx2 ( TXD_encoded, tx_jtm_en, jtm_dps_0, jtm_dps_1, seed_A,
  seed_B, bypass_scram, TXD_Scr, clk, rst, scram_en,
  tx_old_scr_data_in, tx_old_scr_data_out);

   parameter PCS_ID = 2;


   input tx_jtm_en,jtm_dps_0,jtm_dps_1 ; wire tx_jtm_en,jtm_dps_0,jtm_dps_1 ;
   input bypass_scram ; wire bypass_scram ;
   input clk ; wire clk ;
   input rst ; wire rst ;
   input [57:0] seed_A, seed_B; wire [57:0] seed_A, seed_B;
   input [65:0] TXD_encoded; wire [65:0] TXD_encoded;
   input        scram_en; wire scram_en;
   output [65:0] TXD_Scr ;
   reg [65:0] TXD_Scr ;
   reg [65:0] TXD_Scr_10 ;
   wire [65:0] TXD_Scr_40 ;

   input  [63:0] tx_old_scr_data_in;
   output [63:0] tx_old_scr_data_out;

   reg [57:0]    Scrambler_Register;
   reg [57:0]    tx_old_scr;
   reg [63:0]    tx_old_scr_data_reg;

   reg [63:0]    TXD_input;
   reg [1:0]     Sync_header;
   reg [6:0]     jtm_counter;
   reg [1:0]     current_jtm_state,next_jtm_state;
   wire [63:0]   Scr_wire;

   reg seeded;
   reg scram_en_d;

   reg [1:0] cnt;

   assign tx_old_scr_data_out[63:0] = Scr_wire[63:0];

   // always @ (negedge rst or scram_en or tx_old_scr_data_in) begin
   always @ (posedge clk or negedge rst) begin
     if (rst) begin
      tx_old_scr_data_reg[63:0] <= 64'd0;
     end
     if (scram_en) begin
      tx_old_scr_data_reg[63:0] <= tx_old_scr_data_in[63:0];
     end
   end

   always @ (posedge clk or negedge rst) begin
     if (rst) begin
      scram_en_d <= 1'b0;
     end
     if (scram_en) begin
      scram_en_d <= scram_en;
     end
   end

   assign TXD_Scr_40 = {Scr_wire[63:0], Sync_header[1:0]};

   always @ ( TXD_Scr_10 or TXD_Scr_40 ) begin
    if (PCS_ID == 32'd0 && cnt < 2'd2)
      TXD_Scr[65:0] <= TXD_Scr_10[65:0];
    else
      TXD_Scr[65:0] <= TXD_Scr_40[65:0];
   end

   always @ (posedge clk or negedge rst) begin
     if (rst) begin
      cnt <= 2'd0;
     end begin
       if (scram_en)
        if (cnt != 2'b11)
          cnt <= cnt + 1;
     end
   end


   always @ ( negedge rst or tx_old_scr_data_reg or tx_old_scr_data_in or scram_en_d or cnt) begin
   // always @ (posedge clk or negedge rst ) begin
      if (rst) begin
        tx_old_scr[57:0] <= 58'h0;
        seeded <= 1'b0;
      end
      else if ( scram_en_d && (PCS_ID == 32'd0 || PCS_ID == 32'd1) && cnt < 2'd2) begin
          seeded <= 1'b1;
          tx_old_scr[57] <= tx_old_scr_data_reg[6];
          tx_old_scr[56] <= tx_old_scr_data_reg[7];
          tx_old_scr[55] <= tx_old_scr_data_reg[8];
          tx_old_scr[54] <= tx_old_scr_data_reg[9];
          tx_old_scr[53] <= tx_old_scr_data_reg[10];
          tx_old_scr[52] <= tx_old_scr_data_reg[11];
          tx_old_scr[51] <= tx_old_scr_data_reg[12];
          tx_old_scr[50] <= tx_old_scr_data_reg[13];

          tx_old_scr[49] <= tx_old_scr_data_reg[14];
          tx_old_scr[48] <= tx_old_scr_data_reg[15];
          tx_old_scr[47] <= tx_old_scr_data_reg[16];
          tx_old_scr[46] <= tx_old_scr_data_reg[17];
          tx_old_scr[45] <= tx_old_scr_data_reg[18];
          tx_old_scr[44] <= tx_old_scr_data_reg[19];
          tx_old_scr[43] <= tx_old_scr_data_reg[20];
          tx_old_scr[42] <= tx_old_scr_data_reg[21];

          tx_old_scr[41] <= tx_old_scr_data_reg[22];
          tx_old_scr[40] <= tx_old_scr_data_reg[23];
          tx_old_scr[39] <= tx_old_scr_data_reg[24];
          tx_old_scr[38] <= tx_old_scr_data_reg[25];
          tx_old_scr[37] <= tx_old_scr_data_reg[26];
          tx_old_scr[36] <= tx_old_scr_data_reg[27];
          tx_old_scr[35] <= tx_old_scr_data_reg[28];
          tx_old_scr[34] <= tx_old_scr_data_reg[29];

          tx_old_scr[33] <= tx_old_scr_data_reg[30];
          tx_old_scr[32] <= tx_old_scr_data_reg[31];
          tx_old_scr[31] <= tx_old_scr_data_reg[32];
          tx_old_scr[30] <= tx_old_scr_data_reg[33];
          tx_old_scr[29] <= tx_old_scr_data_reg[34];
          tx_old_scr[28] <= tx_old_scr_data_reg[35];
          tx_old_scr[27] <= tx_old_scr_data_reg[36];
          tx_old_scr[26] <= tx_old_scr_data_reg[37];

          tx_old_scr[25] <= tx_old_scr_data_reg[38];
          tx_old_scr[24] <= tx_old_scr_data_reg[39];
          tx_old_scr[23] <= tx_old_scr_data_reg[40];
          tx_old_scr[22] <= tx_old_scr_data_reg[41];
          tx_old_scr[21] <= tx_old_scr_data_reg[42];
          tx_old_scr[20] <= tx_old_scr_data_reg[43];
          tx_old_scr[19] <= tx_old_scr_data_reg[44];
          tx_old_scr[18] <= tx_old_scr_data_reg[45];

          tx_old_scr[17] <= tx_old_scr_data_reg[46];
          tx_old_scr[16] <= tx_old_scr_data_reg[47];
          tx_old_scr[15] <= tx_old_scr_data_reg[48];
          tx_old_scr[14] <= tx_old_scr_data_reg[49];
          tx_old_scr[13] <= tx_old_scr_data_reg[50];
          tx_old_scr[12] <= tx_old_scr_data_reg[51];
          tx_old_scr[11] <= tx_old_scr_data_reg[52];
          tx_old_scr[10] <= tx_old_scr_data_reg[53];

          tx_old_scr[9] <= tx_old_scr_data_reg[54];
          tx_old_scr[8] <= tx_old_scr_data_reg[55];
          tx_old_scr[7] <= tx_old_scr_data_reg[56];
          tx_old_scr[6] <= tx_old_scr_data_reg[57];
          tx_old_scr[5] <= tx_old_scr_data_reg[58];
          tx_old_scr[4] <= tx_old_scr_data_reg[59];
          tx_old_scr[3] <= tx_old_scr_data_reg[60];
          tx_old_scr[2] <= tx_old_scr_data_reg[61];
          tx_old_scr[1] <= tx_old_scr_data_reg[62];
          tx_old_scr[0] <= tx_old_scr_data_reg[63];
        end
        else if (scram_en) begin
          seeded <= 1'b1;
          tx_old_scr[57] <= tx_old_scr_data_in[6];
          tx_old_scr[56] <= tx_old_scr_data_in[7];
          tx_old_scr[55] <= tx_old_scr_data_in[8];
          tx_old_scr[54] <= tx_old_scr_data_in[9];
          tx_old_scr[53] <= tx_old_scr_data_in[10];
          tx_old_scr[52] <= tx_old_scr_data_in[11];
          tx_old_scr[51] <= tx_old_scr_data_in[12];
          tx_old_scr[50] <= tx_old_scr_data_in[13];

          tx_old_scr[49] <= tx_old_scr_data_in[14];
          tx_old_scr[48] <= tx_old_scr_data_in[15];
          tx_old_scr[47] <= tx_old_scr_data_in[16];
          tx_old_scr[46] <= tx_old_scr_data_in[17];
          tx_old_scr[45] <= tx_old_scr_data_in[18];
          tx_old_scr[44] <= tx_old_scr_data_in[19];
          tx_old_scr[43] <= tx_old_scr_data_in[20];
          tx_old_scr[42] <= tx_old_scr_data_in[21];

          tx_old_scr[41] <= tx_old_scr_data_in[22];
          tx_old_scr[40] <= tx_old_scr_data_in[23];
          tx_old_scr[39] <= tx_old_scr_data_in[24];
          tx_old_scr[38] <= tx_old_scr_data_in[25];
          tx_old_scr[37] <= tx_old_scr_data_in[26];
          tx_old_scr[36] <= tx_old_scr_data_in[27];
          tx_old_scr[35] <= tx_old_scr_data_in[28];
          tx_old_scr[34] <= tx_old_scr_data_in[29];

          tx_old_scr[33] <= tx_old_scr_data_in[30];
          tx_old_scr[32] <= tx_old_scr_data_in[31];
          tx_old_scr[31] <= tx_old_scr_data_in[32];
          tx_old_scr[30] <= tx_old_scr_data_in[33];
          tx_old_scr[29] <= tx_old_scr_data_in[34];
          tx_old_scr[28] <= tx_old_scr_data_in[35];
          tx_old_scr[27] <= tx_old_scr_data_in[36];
          tx_old_scr[26] <= tx_old_scr_data_in[37];

          tx_old_scr[25] <= tx_old_scr_data_in[38];
          tx_old_scr[24] <= tx_old_scr_data_in[39];
          tx_old_scr[23] <= tx_old_scr_data_in[40];
          tx_old_scr[22] <= tx_old_scr_data_in[41];
          tx_old_scr[21] <= tx_old_scr_data_in[42];
          tx_old_scr[20] <= tx_old_scr_data_in[43];
          tx_old_scr[19] <= tx_old_scr_data_in[44];
          tx_old_scr[18] <= tx_old_scr_data_in[45];

          tx_old_scr[17] <= tx_old_scr_data_in[46];
          tx_old_scr[16] <= tx_old_scr_data_in[47];
          tx_old_scr[15] <= tx_old_scr_data_in[48];
          tx_old_scr[14] <= tx_old_scr_data_in[49];
          tx_old_scr[13] <= tx_old_scr_data_in[50];
          tx_old_scr[12] <= tx_old_scr_data_in[51];
          tx_old_scr[11] <= tx_old_scr_data_in[52];
          tx_old_scr[10] <= tx_old_scr_data_in[53];

          tx_old_scr[9] <= tx_old_scr_data_in[54];
          tx_old_scr[8] <= tx_old_scr_data_in[55];
          tx_old_scr[7] <= tx_old_scr_data_in[56];
          tx_old_scr[6] <= tx_old_scr_data_in[57];
          tx_old_scr[5] <= tx_old_scr_data_in[58];
          tx_old_scr[4] <= tx_old_scr_data_in[59];
          tx_old_scr[3] <= tx_old_scr_data_in[60];
          tx_old_scr[2] <= tx_old_scr_data_in[61];
          tx_old_scr[1] <= tx_old_scr_data_in[62];
          tx_old_scr[0] <= tx_old_scr_data_in[63];
        end
        else if (PCS_ID == 32'd0 && seeded == 1'b0) begin
          tx_old_scr[57:0] <= 58'h3;
        end
    end


   assign Scr_wire[0] = TXD_input[0]^tx_old_scr[38]^tx_old_scr[57];
   assign Scr_wire[1] = TXD_input[1]^tx_old_scr[37]^tx_old_scr[56];
   assign Scr_wire[2] = TXD_input[2]^tx_old_scr[36]^tx_old_scr[55];
   assign Scr_wire[3] = TXD_input[3]^tx_old_scr[35]^tx_old_scr[54];
   assign Scr_wire[4] = TXD_input[4]^tx_old_scr[34]^tx_old_scr[53];
   assign Scr_wire[5] = TXD_input[5]^tx_old_scr[33]^tx_old_scr[52];
   assign Scr_wire[6] = TXD_input[6]^tx_old_scr[32]^tx_old_scr[51];
   assign Scr_wire[7] = TXD_input[7]^tx_old_scr[31]^tx_old_scr[50];

   assign Scr_wire[8] = TXD_input[8]^tx_old_scr[30]^tx_old_scr[49];
   assign Scr_wire[9] = TXD_input[9]^tx_old_scr[29]^tx_old_scr[48];
   assign Scr_wire[10] = TXD_input[10]^tx_old_scr[28]^tx_old_scr[47];
   assign Scr_wire[11] = TXD_input[11]^tx_old_scr[27]^tx_old_scr[46];
   assign Scr_wire[12] = TXD_input[12]^tx_old_scr[26]^tx_old_scr[45];
   assign Scr_wire[13] = TXD_input[13]^tx_old_scr[25]^tx_old_scr[44];
   assign Scr_wire[14] = TXD_input[14]^tx_old_scr[24]^tx_old_scr[43];
   assign Scr_wire[15] = TXD_input[15]^tx_old_scr[23]^tx_old_scr[42];

   assign Scr_wire[16] = TXD_input[16]^tx_old_scr[22]^tx_old_scr[41];
   assign Scr_wire[17] = TXD_input[17]^tx_old_scr[21]^tx_old_scr[40];
   assign Scr_wire[18] = TXD_input[18]^tx_old_scr[20]^tx_old_scr[39];
   assign Scr_wire[19] = TXD_input[19]^tx_old_scr[19]^tx_old_scr[38];
   assign Scr_wire[20] = TXD_input[20]^tx_old_scr[18]^tx_old_scr[37];
   assign Scr_wire[21] = TXD_input[21]^tx_old_scr[17]^tx_old_scr[36];
   assign Scr_wire[22] = TXD_input[22]^tx_old_scr[16]^tx_old_scr[35];
   assign Scr_wire[23] = TXD_input[23]^tx_old_scr[15]^tx_old_scr[34];

   assign Scr_wire[24] = TXD_input[24]^tx_old_scr[14]^tx_old_scr[33];
   assign Scr_wire[25] = TXD_input[25]^tx_old_scr[13]^tx_old_scr[32];
   assign Scr_wire[26] = TXD_input[26]^tx_old_scr[12]^tx_old_scr[31];
   assign Scr_wire[27] = TXD_input[27]^tx_old_scr[11]^tx_old_scr[30];
   assign Scr_wire[28] = TXD_input[28]^tx_old_scr[10]^tx_old_scr[29];
   assign Scr_wire[29] = TXD_input[29]^tx_old_scr[9]^tx_old_scr[28];
   assign Scr_wire[30] = TXD_input[30]^tx_old_scr[8]^tx_old_scr[27];
   assign Scr_wire[31] = TXD_input[31]^tx_old_scr[7]^tx_old_scr[26];

   assign Scr_wire[32] = TXD_input[32]^tx_old_scr[6]^tx_old_scr[25];
   assign Scr_wire[33] = TXD_input[33]^tx_old_scr[5]^tx_old_scr[24];
   assign Scr_wire[34] = TXD_input[34]^tx_old_scr[4]^tx_old_scr[23];
   assign Scr_wire[35] = TXD_input[35]^tx_old_scr[3]^tx_old_scr[22];
   assign Scr_wire[36] = TXD_input[36]^tx_old_scr[2]^tx_old_scr[21];
   assign Scr_wire[37] = TXD_input[37]^tx_old_scr[1]^tx_old_scr[20];
   assign Scr_wire[38] = TXD_input[38]^tx_old_scr[0]^tx_old_scr[19];
   assign Scr_wire[39] = TXD_input[39]^TXD_input[0]^tx_old_scr[38]^tx_old_scr[57]^tx_old_scr[18];
   assign Scr_wire[40] = TXD_input[40]^(TXD_input[1]^tx_old_scr[37]^tx_old_scr[56])^tx_old_scr[17];
   assign Scr_wire[41] = TXD_input[41]^(TXD_input[2]^tx_old_scr[36]^tx_old_scr[55])^tx_old_scr[16];
   assign Scr_wire[42] = TXD_input[42]^(TXD_input[3]^tx_old_scr[35]^tx_old_scr[54])^tx_old_scr[15];
   assign Scr_wire[43] = TXD_input[43]^(TXD_input[4]^tx_old_scr[34]^tx_old_scr[53])^tx_old_scr[14];
   assign Scr_wire[44] = TXD_input[44]^(TXD_input[5]^tx_old_scr[33]^tx_old_scr[52])^tx_old_scr[13];
   assign Scr_wire[45] = TXD_input[45]^(TXD_input[6]^tx_old_scr[32]^tx_old_scr[51])^tx_old_scr[12];
   assign Scr_wire[46] = TXD_input[46]^(TXD_input[7]^tx_old_scr[31]^tx_old_scr[50])^tx_old_scr[11];
   assign Scr_wire[47] = TXD_input[47]^(TXD_input[8]^tx_old_scr[30]^tx_old_scr[49])^tx_old_scr[10];

   assign Scr_wire[48] = TXD_input[48]^(TXD_input[9]^tx_old_scr[29]^tx_old_scr[48])^tx_old_scr[9];
   assign Scr_wire[49] = TXD_input[49]^(TXD_input[10]^tx_old_scr[28]^tx_old_scr[47])^tx_old_scr[8];
   assign Scr_wire[50] = TXD_input[50]^(TXD_input[11]^tx_old_scr[27]^tx_old_scr[46])^tx_old_scr[7];
   assign Scr_wire[51] = TXD_input[51]^(TXD_input[12]^tx_old_scr[26]^tx_old_scr[45])^tx_old_scr[6];
   assign Scr_wire[52] = TXD_input[52]^(TXD_input[13]^tx_old_scr[25]^tx_old_scr[44])^tx_old_scr[5];
   assign Scr_wire[53] = TXD_input[53]^(TXD_input[14]^tx_old_scr[24]^tx_old_scr[43])^tx_old_scr[4];
   assign Scr_wire[54] = TXD_input[54]^(TXD_input[15]^tx_old_scr[23]^tx_old_scr[42])^tx_old_scr[3];
   assign Scr_wire[55] = TXD_input[55]^(TXD_input[16]^tx_old_scr[22]^tx_old_scr[41])^tx_old_scr[2];

   assign Scr_wire[56] = TXD_input[56]^(TXD_input[17]^tx_old_scr[21]^tx_old_scr[40])^tx_old_scr[1];
   assign Scr_wire[57] = TXD_input[57]^(TXD_input[18]^tx_old_scr[20]^tx_old_scr[39])^tx_old_scr[0];
   assign Scr_wire[58] = TXD_input[58]^(TXD_input[19]^tx_old_scr[19]^tx_old_scr[38])^(TXD_input[0]^tx_old_scr[38]^tx_old_scr[57]);
   assign Scr_wire[59] = TXD_input[59]^(TXD_input[20]^tx_old_scr[18]^tx_old_scr[37])^(TXD_input[1]^tx_old_scr[37]^tx_old_scr[56]);
   assign Scr_wire[60] = TXD_input[60]^(TXD_input[21]^tx_old_scr[17]^tx_old_scr[36])^(TXD_input[2]^tx_old_scr[36]^tx_old_scr[55]);
   assign Scr_wire[61] = TXD_input[61]^(TXD_input[22]^tx_old_scr[16]^tx_old_scr[35])^(TXD_input[3]^tx_old_scr[35]^tx_old_scr[54]);
   assign Scr_wire[62] = TXD_input[62]^(TXD_input[23]^tx_old_scr[15]^tx_old_scr[34])^(TXD_input[4]^tx_old_scr[34]^tx_old_scr[53]);
   assign Scr_wire[63] = TXD_input[63]^(TXD_input[24]^tx_old_scr[14]^tx_old_scr[33])^(TXD_input[5]^tx_old_scr[33]^tx_old_scr[52]);


   always @(posedge clk or posedge rst)
     if (rst) begin
        Scrambler_Register[57:0] <= 58'h3;
        TXD_input[63:0] <= 0;
        Sync_header[1:0] <= 2'b10;
        TXD_Scr_10[65:0] <= 66'h2;
	    jtm_counter   <= 7'h0;
	    current_jtm_state <=  2'h0;
        next_jtm_state <=  2'h0;
     end

     else if (!scram_en) begin
	    Scrambler_Register[57:0] <= Scrambler_Register[57:0];
        TXD_input[63:0] <= TXD_input[63:0];
        Sync_header[1:0] <= Sync_header[1:0];
        TXD_Scr_10[65:0] <= TXD_Scr[65:0];
	    jtm_counter   <= jtm_counter;
	    current_jtm_state <=  current_jtm_state;
        next_jtm_state <=  next_jtm_state;
     end

     else if (bypass_scram) begin
        TXD_input[63:0] <= TXD_encoded[65:2];
        Sync_header[1:0] <= TXD_encoded[1:0];
      	TXD_Scr_10[65:0] <= {TXD_input[63:0],Sync_header[1:0]};
	    jtm_counter   <= 7'h0;
	    current_jtm_state <=  2'h0;
	    next_jtm_state <=  2'h0;
     end

     else begin
	    if (!tx_jtm_en)  // Jitter test Disabled
	      begin
      	     TXD_input[63:0] <= TXD_encoded[65:2];
             Sync_header[1:0] <= TXD_encoded[1:0];
	           TXD_Scr_10[65:0] <= {Scr_wire[63:0], Sync_header[1:0]};
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

                  TXD_Scr_10[65:0] <= {Scr_wire[63:0],2'b10};
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
	              TXD_Scr_10[65:0] <= 66'h0007FF001FFC007FF;
	              current_jtm_state <= 2'b0;
	              jtm_counter <= 7'b0;
	           end // else: !if(!jtm_dps_1)

	      end // else: !if(!tx_jtm_en)


     end // else: !if(bypass_scram)

endmodule // scramble
