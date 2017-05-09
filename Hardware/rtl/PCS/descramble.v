//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: descramble.v
//
//
// Begin Date: Fri Jun 18 14:04:02 2004
//
// Description: This is a Descrambler to be used in an 66/64 decoder.
//              This Descrambler is capable of processing 64-bit words
//              provided by the block synchronizer
// 
//
// Verification: I-Functional verification of the DeScrambler was done twice 
//               1- Simulating Scrambler/Descrambler loop
//               2- Simulating Encoder-Scrambler / Descrambler-Decoder loop
//
//               Verification done by auther
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
// $Log: descramble.v,v $
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

module descramble(clr_jtest_errc, write_enable, bypass_descram, rx_jtm_en, blk_lock, jtest_errc, RXD_Sync, DeScr_RXD, clk, rstb);
    
    input write_enable;
    input [65:0] RXD_Sync ; wire [65:0] RXD_Sync ;
    input        bypass_descram ; wire bypass_descram ;
    input        clr_jtest_errc;
    input        rx_jtm_en; wire rx_jtm_en;  
    input        clk ; wire clk ;
    input        rstb ; wire rstb ;
    input        blk_lock;wire blk_lock;
    output [65:0] DeScr_RXD ; reg [65:0] DeScr_RXD ;
    output [15:0] jtest_errc; reg [15:0] jtest_errc;
    reg [63:0]    jtm_data;
    reg           jtm_lock; 
    reg [6:0]     blk_ctr;
    reg [1:0]     zero_ctr, ones_ctr, LF_ctr, LF_bar_ctr; 
    reg [57:0]    DeScrambler_Register;
    reg [63:0]    RXD_input;
    reg [1:0]     RX_Sync_header;
    wire [63:0]   DeScr_wire;
    reg           jtm_d_neq_0, jtm_d_neq_1, jtm_d_neq_lf, jtm_d_neq_lfb; 
    reg           jtm_err_bit;




    assign DeScr_wire[0] = RXD_input[0]^DeScrambler_Register[38]^DeScrambler_Register[57];
    assign DeScr_wire[1] = RXD_input[1]^DeScrambler_Register[37]^DeScrambler_Register[56];
    assign DeScr_wire[2] = RXD_input[2]^DeScrambler_Register[36]^DeScrambler_Register[55];
    assign DeScr_wire[3] = RXD_input[3]^DeScrambler_Register[35]^DeScrambler_Register[54];
    assign DeScr_wire[4] = RXD_input[4]^DeScrambler_Register[34]^DeScrambler_Register[53];
    assign DeScr_wire[5] = RXD_input[5]^DeScrambler_Register[33]^DeScrambler_Register[52];
    assign DeScr_wire[6] = RXD_input[6]^DeScrambler_Register[32]^DeScrambler_Register[51];
    assign DeScr_wire[7] = RXD_input[7]^DeScrambler_Register[31]^DeScrambler_Register[50];

    assign  DeScr_wire[8] = RXD_input[8]^DeScrambler_Register[30]^DeScrambler_Register[49];
    assign  DeScr_wire[9] = RXD_input[9]^DeScrambler_Register[29]^DeScrambler_Register[48];
    assign  DeScr_wire[10] = RXD_input[10]^DeScrambler_Register[28]^DeScrambler_Register[47];
    assign  DeScr_wire[11] = RXD_input[11]^DeScrambler_Register[27]^DeScrambler_Register[46];
    assign  DeScr_wire[12] = RXD_input[12]^DeScrambler_Register[26]^DeScrambler_Register[45];
    assign  DeScr_wire[13] = RXD_input[13]^DeScrambler_Register[25]^DeScrambler_Register[44];
    assign  DeScr_wire[14] = RXD_input[14]^DeScrambler_Register[24]^DeScrambler_Register[43];
    assign  DeScr_wire[15] = RXD_input[15]^DeScrambler_Register[23]^DeScrambler_Register[42];

    assign  DeScr_wire[16] = RXD_input[16]^DeScrambler_Register[22]^DeScrambler_Register[41];
    assign  DeScr_wire[17] = RXD_input[17]^DeScrambler_Register[21]^DeScrambler_Register[40];
    assign  DeScr_wire[18] = RXD_input[18]^DeScrambler_Register[20]^DeScrambler_Register[39];
    assign  DeScr_wire[19] = RXD_input[19]^DeScrambler_Register[19]^DeScrambler_Register[38];
    assign  DeScr_wire[20] = RXD_input[20]^DeScrambler_Register[18]^DeScrambler_Register[37];
    assign  DeScr_wire[21] = RXD_input[21]^DeScrambler_Register[17]^DeScrambler_Register[36];
    assign  DeScr_wire[22] = RXD_input[22]^DeScrambler_Register[16]^DeScrambler_Register[35];
    assign  DeScr_wire[23] = RXD_input[23]^DeScrambler_Register[15]^DeScrambler_Register[34];

    assign  DeScr_wire[24] = RXD_input[24]^DeScrambler_Register[14]^DeScrambler_Register[33];
    assign  DeScr_wire[25] = RXD_input[25]^DeScrambler_Register[13]^DeScrambler_Register[32];
    assign  DeScr_wire[26] = RXD_input[26]^DeScrambler_Register[12]^DeScrambler_Register[31];
    assign  DeScr_wire[27] = RXD_input[27]^DeScrambler_Register[11]^DeScrambler_Register[30];
    assign  DeScr_wire[28] = RXD_input[28]^DeScrambler_Register[10]^DeScrambler_Register[29];
    assign  DeScr_wire[29] = RXD_input[29]^DeScrambler_Register[9]^DeScrambler_Register[28];
    assign  DeScr_wire[30] = RXD_input[30]^DeScrambler_Register[8]^DeScrambler_Register[27];
    assign  DeScr_wire[31] = RXD_input[31]^DeScrambler_Register[7]^DeScrambler_Register[26];

    assign  DeScr_wire[32] = RXD_input[32]^DeScrambler_Register[6]^DeScrambler_Register[25];
    assign  DeScr_wire[33] = RXD_input[33]^DeScrambler_Register[5]^DeScrambler_Register[24];
    assign  DeScr_wire[34] = RXD_input[34]^DeScrambler_Register[4]^DeScrambler_Register[23];
    assign  DeScr_wire[35] = RXD_input[35]^DeScrambler_Register[3]^DeScrambler_Register[22];
    assign  DeScr_wire[36] = RXD_input[36]^DeScrambler_Register[2]^DeScrambler_Register[21];
    assign  DeScr_wire[37] = RXD_input[37]^DeScrambler_Register[1]^DeScrambler_Register[20];
    assign  DeScr_wire[38] = RXD_input[38]^DeScrambler_Register[0]^DeScrambler_Register[19];

    assign  DeScr_wire[39] = RXD_input[39]^RXD_input[0]^DeScrambler_Register[18];
    assign  DeScr_wire[40] = RXD_input[40]^RXD_input[1]^DeScrambler_Register[17];
    assign  DeScr_wire[41] = RXD_input[41]^RXD_input[2]^DeScrambler_Register[16];
    assign  DeScr_wire[42] = RXD_input[42]^RXD_input[3]^DeScrambler_Register[15];
    assign  DeScr_wire[43] = RXD_input[43]^RXD_input[4]^DeScrambler_Register[14];
    assign  DeScr_wire[44] = RXD_input[44]^RXD_input[5]^DeScrambler_Register[13];
    assign  DeScr_wire[45] = RXD_input[45]^RXD_input[6]^DeScrambler_Register[12];
    assign  DeScr_wire[46] = RXD_input[46]^RXD_input[7]^DeScrambler_Register[11];
    assign  DeScr_wire[47] = RXD_input[47]^RXD_input[8]^DeScrambler_Register[10];

    assign  DeScr_wire[48] = RXD_input[48]^RXD_input[9]^DeScrambler_Register[9];
    assign  DeScr_wire[49] = RXD_input[49]^RXD_input[10]^DeScrambler_Register[8];
    assign  DeScr_wire[50] = RXD_input[50]^RXD_input[11]^DeScrambler_Register[7];
    assign  DeScr_wire[51] = RXD_input[51]^RXD_input[12]^DeScrambler_Register[6];
    assign  DeScr_wire[52] = RXD_input[52]^RXD_input[13]^DeScrambler_Register[5];
    assign  DeScr_wire[53] = RXD_input[53]^RXD_input[14]^DeScrambler_Register[4];
    assign  DeScr_wire[54] = RXD_input[54]^RXD_input[15]^DeScrambler_Register[3];

    assign  DeScr_wire[55] = RXD_input[55]^RXD_input[16]^DeScrambler_Register[2];
    assign  DeScr_wire[56] = RXD_input[56]^RXD_input[17]^DeScrambler_Register[1];
    assign  DeScr_wire[57] = RXD_input[57]^RXD_input[18]^DeScrambler_Register[0];
    assign  DeScr_wire[58] = RXD_input[58]^RXD_input[19]^RXD_input[0];
    assign  DeScr_wire[59] = RXD_input[59]^RXD_input[20]^RXD_input[1];
    assign  DeScr_wire[60] = RXD_input[60]^RXD_input[21]^RXD_input[2];
    assign  DeScr_wire[61] = RXD_input[61]^RXD_input[22]^RXD_input[3];
    assign  DeScr_wire[62] = RXD_input[62]^RXD_input[23]^RXD_input[4];
    assign  DeScr_wire[63] = RXD_input[63]^RXD_input[24]^RXD_input[5];



    // This is the jitter test mode
    
	
    always  @(posedge clk or negedge rstb)
        if (!rstb) begin
	        jtm_d_neq_0	  <= 1'b0; 
	        jtm_d_neq_1	  <= 1'b0; 
	        jtm_d_neq_lf  <= 1'b0; 
	        jtm_d_neq_lfb <= 1'b0; 
	        jtm_err_bit <= 1'b0; 
        end
        else begin
	        
	        if (jtm_data != 64'h0) 
	            jtm_d_neq_0	  <= 1'b1; 
	        else 
	            jtm_d_neq_0	  <= 1'b0; 
	        
	        if (jtm_data != 64'hFFFFFFFFFFFFFFFF) 
	            jtm_d_neq_1	  <= 1'b1;
	        else  
	            jtm_d_neq_1	  <= 1'b0;
	        
	        if (jtm_data != `PCS_LF_OS) 
	            jtm_d_neq_lf  <= 1'b1;
	        else 
	            jtm_d_neq_lf  <= 1'b0;
	        
	        if (jtm_data != ~`PCS_LF_OS) 
	            jtm_d_neq_lfb <= 1'b1; 
	        else 
	            jtm_d_neq_lfb <= 1'b0;  
            
	        jtm_err_bit <= jtm_d_neq_0 & jtm_d_neq_1 & jtm_d_neq_lf & jtm_d_neq_lfb ; 			 
	        
        end

    always @(posedge clk or negedge rstb)
        if (!rstb) begin
	        zero_ctr  <= 2'h3; 
            ones_ctr  <= 2'h3; 
            LF_ctr    <= 2'h3;   
            LF_bar_ctr <= 2'h3; 
            blk_ctr <= 7'h7F;
	        jtm_lock   <= 1'b0; 
	        jtm_data <= 64'h1;
	        jtest_errc <= 16'h0;
        end
        else if ( write_enable ) begin 
            if (!rx_jtm_en) begin
	            zero_ctr  <= 2'h3; 
                ones_ctr  <= 2'h3; 
                LF_ctr    <= 2'h3;   
                LF_bar_ctr <= 2'h3;
	            blk_ctr <= 7'h7F;   
	            jtm_lock   <= 1'b0;
	            jtm_data <= 64'h1;
	            jtest_errc <= 16'h0;
	        end
            else if (blk_lock) begin
	            jtm_data[63:0] <= DeScr_wire[63:0];
	            if (!jtm_lock) begin
	                if (!jtm_d_neq_0)
		                zero_ctr    <= zero_ctr - 1;
	                else if (!jtm_d_neq_1)
		                ones_ctr    <=  ones_ctr - 1;
	                else if (!jtm_d_neq_lf)
		                LF_ctr      <=  LF_ctr - 1;
	                else if (!jtm_d_neq_lfb)
		                LF_bar_ctr  <=  LF_bar_ctr - 1;
	                if ((zero_ctr == 2'h0)||(ones_ctr == 2'h0)||(LF_ctr == 2'h0)||(LF_bar_ctr == 2'h0)) begin
		                jtm_lock <=  1'b1;
		                blk_ctr <=  7'h7f;
	                end
	            end
	            else if (jtm_lock && !clr_jtest_errc) begin
	                blk_ctr <= blk_ctr - 1;
                    if (jtm_err_bit == 1'b1) 
                        if ((jtest_errc != 16'hffff) && (blk_ctr != 7'h0) )
                            jtest_errc <= jtest_errc + 1;
	                
	            end
	            else begin
	                jtest_errc <= 16'h0;
	            end
	        end
        end // if ( write_enable )

    // This is the normal mode of operation
    
    always @(posedge clk or negedge rstb)
        if (!rstb) begin
            DeScrambler_Register[57:0] <= 58'h3;
            RXD_input[63:0] <= 64'h0;
            RX_Sync_header <= 2'b01;
            DeScr_RXD[65:0] <= 66'h79;
        end      
        else if ( write_enable ) begin
            if (bypass_descram) begin
                RXD_input[63:0] <= RXD_Sync[65:2];
                RX_Sync_header <= RXD_Sync[1:0];
                DeScr_RXD[65:0] <= {RXD_input[63:0],RX_Sync_header};
            end
            else begin
      	        RXD_input[63:0] <= RXD_Sync[65:2];
                RX_Sync_header <= RXD_Sync[1:0];
      	        DeScr_RXD[65:0] <= {DeScr_wire[63:0],RX_Sync_header[1:0]};
	            
                DeScrambler_Register[57] <= RXD_input[6];
                DeScrambler_Register[56] <= RXD_input[7];
                DeScrambler_Register[55] <= RXD_input[8];
                DeScrambler_Register[54] <= RXD_input[9];
                DeScrambler_Register[53] <= RXD_input[10];
	            DeScrambler_Register[52] <= RXD_input[11];
                DeScrambler_Register[51] <= RXD_input[12];
                DeScrambler_Register[50] <= RXD_input[13];
	            
                DeScrambler_Register[49] <= RXD_input[14];
                DeScrambler_Register[48] <= RXD_input[15];
                DeScrambler_Register[47] <= RXD_input[16];
                DeScrambler_Register[46] <= RXD_input[17];
                DeScrambler_Register[45] <= RXD_input[18];
                DeScrambler_Register[44] <= RXD_input[19];
                DeScrambler_Register[43] <= RXD_input[20];
                DeScrambler_Register[42] <= RXD_input[21];
	            
                DeScrambler_Register[41] <= RXD_input[22];
                DeScrambler_Register[40] <= RXD_input[23];
                DeScrambler_Register[39] <= RXD_input[24];
                DeScrambler_Register[38] <= RXD_input[25];
                DeScrambler_Register[37] <= RXD_input[26];
                DeScrambler_Register[36] <= RXD_input[27];
                DeScrambler_Register[35] <= RXD_input[28];
                DeScrambler_Register[34] <= RXD_input[29];
	            
                DeScrambler_Register[33] <= RXD_input[30];
                DeScrambler_Register[32] <= RXD_input[31];
                DeScrambler_Register[31] <= RXD_input[32];
                DeScrambler_Register[30] <= RXD_input[33];
                DeScrambler_Register[29] <= RXD_input[34];
                DeScrambler_Register[28] <= RXD_input[35];
                DeScrambler_Register[27] <= RXD_input[36];
                DeScrambler_Register[26] <= RXD_input[37];
	            
                DeScrambler_Register[25] <= RXD_input[38];
                DeScrambler_Register[24] <= RXD_input[39];
                DeScrambler_Register[23] <= RXD_input[40];
                DeScrambler_Register[22] <= RXD_input[41];
                DeScrambler_Register[21] <= RXD_input[42];
                DeScrambler_Register[20] <= RXD_input[43];
                DeScrambler_Register[19] <= RXD_input[44];
                DeScrambler_Register[18] <= RXD_input[45];
	            
                DeScrambler_Register[17] <= RXD_input[46];
                DeScrambler_Register[16] <= RXD_input[47];
                DeScrambler_Register[15] <= RXD_input[48];
                DeScrambler_Register[14] <= RXD_input[49];
                DeScrambler_Register[13] <= RXD_input[50];
                DeScrambler_Register[12] <= RXD_input[51];
                DeScrambler_Register[11] <= RXD_input[52];
                DeScrambler_Register[10] <= RXD_input[53];
	            
                DeScrambler_Register[9] <= RXD_input[54];
                DeScrambler_Register[8] <= RXD_input[55];
                DeScrambler_Register[7] <= RXD_input[56];
                DeScrambler_Register[6] <= RXD_input[57];
                DeScrambler_Register[5] <= RXD_input[58];
                DeScrambler_Register[4] <= RXD_input[59];
                DeScrambler_Register[3] <= RXD_input[60];
                DeScrambler_Register[2] <= RXD_input[61];
                DeScrambler_Register[1] <= RXD_input[62];
                DeScrambler_Register[0] <= RXD_input[63];
            end // else: !if(bypass_descram)
        end
    
endmodule // descramble








