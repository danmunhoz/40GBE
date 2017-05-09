//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: R_TYPE_Decode.v
//
//
// Start of Coding Date: Mon May 14 2001 ( 1:00 pm)
//
// File name: R_Type_Decode.v
//
// Description: This file has the code for checking the validity of the
//              codes received from the PMA and does the translation into
//              XGMII codes. This function is part of the decodeing function
//              performed by the PCS.
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
// $Log: R_TYPE_Decode.v,v $
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

module  R_TYPE_Decode (rstb156, clk156, DeScr_RXD, R_TYPE, rx_data, rx_control);
    input rstb156 ; wire rstb156 ;
    input clk156 ; wire clk156 ;
    input [65:0] DeScr_RXD ; wire [65:0] DeScr_RXD ;


    output [2:0] R_TYPE ; reg [2:0] R_TYPE ;
    output [63:0] rx_data ; reg [63:0] rx_data ;
    output [7:0]  rx_control ; reg [7:0] rx_control ;
    wire [7:0]    C_7, C_6, C_5, C_4, C_3, C_2, C_1, C_0;
    reg           err_7t7, err_6t7, err_5t7, err_4t7, err_3t7, err_2t7, err_1t7, err_0t7, err_0t3;
    wire          err_7_0, err_6_0, err_5_0, err_4_0, err_3_0, err_2_0, err_1_0, err_0_0;

    reg [65:0]    DeScr_RXD_reg ;
    reg [1:0]     sync_header;
    reg [63:0]    coded_data, decoded_data;
    reg [15:0]    block_type_dec, block_type_dec_r;

    reg           coded39dt36_seq,coded39dt36_ones,coded39dt36_zers,coded35dt32_seq ,coded35dt32_ones;

PCS_to_XGMII Con_7(DeScr_RXD_reg[65:59],C_7);
PCS_to_XGMII Con_6(DeScr_RXD_reg[58:52],C_6);
PCS_to_XGMII Con_5(DeScr_RXD_reg[51:45],C_5);
PCS_to_XGMII Con_4(DeScr_RXD_reg[44:38],C_4);
PCS_to_XGMII Con_3(DeScr_RXD_reg[37:31],C_3);
PCS_to_XGMII Con_2(DeScr_RXD_reg[30:24],C_2);
PCS_to_XGMII Con_1(DeScr_RXD_reg[23:17],C_1);
PCS_to_XGMII Con_0(DeScr_RXD_reg[16:10],C_0);

assign err_7_0 = &C_7;
assign err_6_0 = &C_6;
assign err_5_0 = &C_5;
assign err_4_0 = &C_4;
assign err_3_0 = &C_3;
assign err_2_0 = &C_2;
assign err_1_0 = &C_1;
assign err_0_0 = &C_0;

always @( DeScr_RXD_reg )
    begin
        case ( DeScr_RXD_reg[9:2] )
            8'h1e:      block_type_dec[15:0] = 16'h0001;
            8'h2d:      block_type_dec[15:0] = 16'h0002;
            8'h33:      block_type_dec[15:0] = 16'h0004;
            8'h66:      block_type_dec[15:0] = 16'h0008;
            8'h55:      block_type_dec[15:0] = 16'h0010;
            8'h78:      block_type_dec[15:0] = 16'h0020;
            8'h4b:      block_type_dec[15:0] = 16'h0040;
            8'h87:      block_type_dec[15:0] = 16'h0080;
            8'h99:      block_type_dec[15:0] = 16'h0100;
            8'haa:      block_type_dec[15:0] = 16'h0200;
            8'hb4:      block_type_dec[15:0] = 16'h0400;
            8'hcc:      block_type_dec[15:0] = 16'h0800;
            8'hd2:      block_type_dec[15:0] = 16'h1000;
            8'he1:      block_type_dec[15:0] = 16'h2000;
            8'hff:      block_type_dec[15:0] = 16'h4000;
            default:    block_type_dec[15:0] = 16'h0 ;
        endcase
    end
always @(posedge clk156 or negedge rstb156)
    if (!rstb156)
        begin
            DeScr_RXD_reg <= {`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`Type_1, `Sync_cont};
            
            sync_header <=2'b01;
            coded_data[63:0] <= {`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`Type_1};
            decoded_data[63:0] <= {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};

            err_7t7 <=0; 
            err_6t7 <=0;
            err_5t7 <=0;
            err_4t7 <=0;
            err_3t7 <=0;
            err_2t7 <=0;
            err_1t7 <=0;
            err_0t7 <=0;
            err_0t3 <=0;
            
            coded39dt36_seq <= 1'b0;
            coded39dt36_ones <= 1'b0;
            coded39dt36_zers <= 1'b0;
            coded35dt32_seq <= 1'b0;
            coded35dt32_ones <= 1'b0;
            block_type_dec_r <= 16'h0000;

        end
    else
        begin
            DeScr_RXD_reg <= DeScr_RXD;

            sync_header <= DeScr_RXD_reg[1:0];
            coded_data[63:0] <= DeScr_RXD_reg[65:2];

            decoded_data[63:0] <= {C_7, C_6, C_5, C_4, C_3, C_2, C_1, C_0};
            
            if (DeScr_RXD_reg[41:38] == `PCS_Sequence_OS) // coded_data[39:36]
                coded39dt36_seq <= 1'b1;
            else
                coded39dt36_seq <= 1'b0;
            
            if (DeScr_RXD_reg[41:38] == 4'b1111) // coded_data[39:36]
                coded39dt36_ones <= 1'b1;
            else
                coded39dt36_ones <= 1'b0;
            
            if (DeScr_RXD_reg[41:38] == 4'b0000) // coded_data[39:36]
                coded39dt36_zers <= 1'b1;
            else
                coded39dt36_zers <= 1'b0;

            if (DeScr_RXD_reg[37:34] == `PCS_Sequence_OS) // coded_data[35:32]
                coded35dt32_seq <= 1'b1;
            else
                coded35dt32_seq <= 1'b0;
            
            if (DeScr_RXD_reg[37:34] == 4'b1111) // coded_data[35:32]
                coded35dt32_ones <= 1'b1;
            else
                coded35dt32_ones <= 1'b0;
            
            block_type_dec_r <= block_type_dec;

            err_0t7 <= err_7_0 | err_6_0 | err_5_0 | err_4_0 | err_3_0 | err_2_0 | err_1_0 | err_0_0;
            err_1t7 <= err_7_0 | err_6_0 | err_5_0 | err_4_0 | err_3_0 | err_2_0 | err_1_0;
            err_2t7 <= err_7_0 | err_6_0 | err_5_0 | err_4_0 | err_3_0 | err_2_0;
            err_3t7 <= err_7_0 | err_6_0 | err_5_0 | err_4_0 | err_3_0;
            err_4t7 <= err_7_0 | err_6_0 | err_5_0 | err_4_0;
            err_5t7 <= err_7_0 | err_6_0 | err_5_0;
            err_6t7 <= err_7_0 | err_6_0;
            err_7t7 <= err_7_0;
            err_0t3 <= err_3_0 | err_2_0 | err_1_0 | err_0_0;
        end

always @(posedge clk156 or negedge rstb156)
    if(!rstb156) begin
        rx_control <= 8'hFF;
        rx_data <= {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
        R_TYPE <= `C;
    end
    else begin
        case (sync_header)
            2'b10  : // data frame
                begin
                    rx_control <= 8'h00;
                    rx_data <= coded_data;
                    R_TYPE <= `D;
                end
            2'b01  : // check for control , start , terminate, or error frame
                begin
                    case (block_type_dec_r[15:0])
                        16'h0001: begin
                            if (
                                (decoded_data[63:56] == `XGMII_error) ||
                                (decoded_data[55:48] == `XGMII_error) ||
                                (decoded_data[47:40] == `XGMII_error) ||
                                (decoded_data[39:32] == `XGMII_error) ||
                                (decoded_data[31:24] == `XGMII_error) ||
                                (decoded_data[23:16] == `XGMII_error) ||
                                (decoded_data[15:8]  == `XGMII_error) ||
                                (decoded_data[7:0]   == `XGMII_error)
                                ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end // if ( err_7 || err_6 || err_5 || err_4 || err_3 || err_2 || err_1 || err_0 ||...
                            else if ( err_0t7 ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;    
                                end
                            else 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= decoded_data;
                                    R_TYPE <= `C;
                                end
                        end
                        16'h0002: begin
                            if ( err_0t3 || ( !coded39dt36_seq && !coded39dt36_ones) ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else if (coded39dt36_seq ) 
                                begin
                                    rx_data <= {coded_data[63:40],`XGMII_Sequence_OS,decoded_data[31:0]};
                                    rx_control <= 8'h1f;
                                    R_TYPE <= `C;  
                                end
                            else 
                                begin
                                    rx_data <= {coded_data[63:40],`XGMII_reserved_6,decoded_data[31:0]}; //Latch!!!fixed
                                    rx_control <= 8'h1f;
                                    R_TYPE <= `C;
                                end
                        end
                        16'h0004: begin
                            if ( err_0t3 ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else
                                begin
                                    rx_control <= 8'h1f;
                                    rx_data <= {coded_data[63:40],`XGMII_start,decoded_data[31:0]};
                                    R_TYPE <= `S;
                                end
                        end
                        16'h0008: begin
                            if ( !coded39dt36_zers  || (!coded35dt32_seq  && !coded35dt32_ones )) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else if (coded35dt32_seq ) 
                                begin
                                    rx_control <= 8'h11;
                                    rx_data <= {coded_data[63:40],`XGMII_start,coded_data[31:8],`XGMII_Sequence_OS};
                                    R_TYPE <= `S;   
                                end
                            else 
                                begin
                                    rx_data <= {coded_data[63:40],`XGMII_start,coded_data[31:8],`XGMII_reserved_6}; //Latch!fixed
                                    rx_control <= 8'h11;   
                                    R_TYPE <= `S;
                                end
                        end
                        16'h0010: begin
                            if ((!coded39dt36_seq && !coded39dt36_ones) || (!coded35dt32_seq  && !coded35dt32_ones ))
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else if ( coded39dt36_seq && coded35dt32_seq ) 
                                begin
                                    rx_data <= {coded_data[63:40],`XGMII_Sequence_OS,coded_data[31:8],`XGMII_Sequence_OS};
                                    R_TYPE <= `C;
                                    rx_control <= 8'h11;
                                end
                            else if ( coded39dt36_seq && coded35dt32_ones) 
                                begin
                                    rx_data <= {coded_data[63:40],`XGMII_Sequence_OS,coded_data[31:8],`XGMII_reserved_6};
                                    R_TYPE <= `C;
                                    rx_control <= 8'h11;
                                end
                            else if ( coded39dt36_ones && coded35dt32_seq)
                                begin
                                    rx_data <= {coded_data[63:40],`XGMII_reserved_6,coded_data[31:8],`XGMII_Sequence_OS};
                                    R_TYPE <= `C;
                                    rx_control <= 8'h11;   
                                end
                            else 
                                begin
                                    rx_data <= {coded_data[63:40],`XGMII_reserved_6,coded_data[31:8],`XGMII_reserved_6}; // LATCH!!!fixed
                                    R_TYPE <= `C;
                                    rx_control <= 8'h11;
                                end
                        end
                        
                        16'h0020: begin
                            rx_control <= 8'h01;
                            rx_data <= {coded_data[63:8],`XGMII_start};
                            R_TYPE <= `S;
                        end
                        16'h0040: begin
                            if ( err_4t7 || (!coded35dt32_seq && !coded35dt32_ones )) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else if (coded35dt32_seq) 
                                begin
                                    rx_data <= {decoded_data[63:32],coded_data[31:8],`XGMII_Sequence_OS};  //Latch!fixed
                                    R_TYPE <= `C;
                                    rx_control <= 8'hf1;   
                                end
                            else 
                                begin
                                    rx_data <= {decoded_data[63:32],coded_data[31:8],`XGMII_reserved_6}; //Latch!fixed
                                    R_TYPE <= `C;
                                    rx_control <= 8'hf1;
                                end
                        end
                        
                        16'h0080: begin
                            if (  err_1t7 ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= {decoded_data[63:8], `XGMII_terminate};
                                    R_TYPE <= `T;
                                end
                        end
                        16'h0100: begin
                            if (  err_2t7 ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else 
                                begin
                                    rx_control <= 8'hfe;
                                    rx_data <= {decoded_data[63:16],`XGMII_terminate, coded_data[15:8]};
                                    R_TYPE <= `T;
                                end
                        end
                        16'h0200: begin
                            if (  err_3t7 ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else 
                                begin
                                    rx_control <= 8'hfc;
                                    rx_data <= {decoded_data[63:24],`XGMII_terminate, coded_data[23:8]};
                                    R_TYPE <= `T;
                                end
                        end
                        16'h0400: begin
                            if ( err_4t7  ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else 
                                begin
                                    rx_control <= 8'hf8;
                                    rx_data <= {decoded_data[63:32],`XGMII_terminate, coded_data[31:8]};
                                    R_TYPE <= `T;
                                end
                        end
                        16'h0800: begin
                            if ( err_5t7 ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else 
                                begin
                                    rx_control <= 8'hf0;
                                    rx_data <= {decoded_data[63:40],`XGMII_terminate, coded_data[39:8]};
                                    R_TYPE <= `T;
                                end
                        end
                        16'h1000: begin
                            if (  err_6t7 ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else 
                                begin
                                    rx_control <= 8'he0;
                                    rx_data <= {decoded_data[63:48],`XGMII_terminate, coded_data[47:8]};
                                    R_TYPE <= `T;
                                end
                        end
                        16'h2000: begin
                            if ( err_7t7 ) 
                                begin
                                    rx_control <= 8'hff;
                                    rx_data <= `EBLOCK_R;
                                    R_TYPE <= `E;
                                end
                            else 
                                begin
                                    rx_control <= 8'hc0;
                                    rx_data <= {decoded_data[63:56],`XGMII_terminate, coded_data[55:8]};
                                    R_TYPE <= `T;
                                end
                        end
                        16'h4000: begin
                            rx_control <= 8'h80;
                            rx_data <= {`XGMII_terminate, coded_data[63:8]};
                            R_TYPE <= `T;
                        end
                        default: begin
                            rx_control <= 8'hff;
                            rx_data <= `EBLOCK_R;
                            R_TYPE <= `E;
                        end
                    endcase
                end
            default: begin
//                $display("[Time: %t] Sync Header == 0", $time);
                rx_control <= 8'hff;
                rx_data <= `EBLOCK_R;
                R_TYPE <= `E;
            end
        endcase
    end
endmodule


