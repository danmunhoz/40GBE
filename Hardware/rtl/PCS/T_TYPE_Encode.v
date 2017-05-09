//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: T_TYPE_Encode.v
//
//
// Start of Coding Date: SUN April 22 2001 ( 2:00 pm)
//
// File name: T_Type_Encode.v
//
// Description: This file has the code for checking the validity of the
//              codes received from the XGMII and does the translation into
//              PCS codes. This function is part of the encodeing function
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
// $Log: T_TYPE_Encode.v,v $
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

module  T_TYPE_Encode (clk156, rstb, coded_vec, txdata, txcontrol, T_TYPE);
   input clk156; wire clk156;
   input rstb; wire rstb;
   output [65:0] coded_vec ; reg [65:0] coded_vec ;
   input [63:0]  txdata ; wire [63:0] txdata ;
   input [7:0] 	 txcontrol ; wire [7:0] txcontrol ;
   
   output [2:0]  T_TYPE ; reg [2:0] T_TYPE ;

   reg [63:0] 	 tx_data,tx_data_0;
   reg [7:0] 	 tx_control,tx_control_0;
   wire [6:0] 	 C_7, C_6, C_5, C_4, C_3, C_2, C_1, C_0;
   reg 		 err_7, err_6, err_5, err_4, err_3, err_2, err_1, err_0;
   wire 	 err_7_0, err_6_0, err_5_0, err_4_0, err_3_0, err_2_0, err_1_0, err_0_0;
   reg [55:0] 	 PCS_Controls;
   
   XGMII_to_PCS Con_7(tx_data_0[63:56],C_7);
   XGMII_to_PCS Con_6(tx_data_0[55:48],C_6);
   XGMII_to_PCS Con_5(tx_data_0[47:40],C_5);
   XGMII_to_PCS Con_4(tx_data_0[39:32],C_4);
   XGMII_to_PCS Con_3(tx_data_0[31:24],C_3);
   XGMII_to_PCS Con_2(tx_data_0[23:16],C_2);
   XGMII_to_PCS Con_1(tx_data_0[15:8],C_1);
   XGMII_to_PCS Con_0(tx_data_0[7:0],C_0);
   
   assign err_7_0 = &C_7;
   assign err_6_0 = &C_6;
   assign err_5_0 = &C_5;
   assign err_4_0 = &C_4;
   assign err_3_0 = &C_3;
   assign err_2_0 = &C_2;
   assign err_1_0 = &C_1;
   assign err_0_0 = &C_0;

   always @(posedge clk156 or negedge rstb)
      if (!rstb) begin
	 tx_data <=  {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
	 tx_control <=  8'hff;
	 PCS_Controls <=  {`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle};
	 tx_data_0 <=  {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
	 tx_control_0 <=  8'hff;
     
	 err_7 <= 0;
	 err_6 <= 0;
	 err_5 <= 0;
	 err_4 <= 0;
	 err_3 <= 0;
	 err_2 <= 0;
	 err_1 <= 0;
	 err_0 <= 0;
      end
      else begin
	 tx_data_0 <=  txdata;
	 tx_control_0 <=  txcontrol;
	 
	 tx_data <=  tx_data_0;
	 tx_control <=  tx_control_0;
	 
	 PCS_Controls <=  {C_7, C_6, C_5, C_4, C_3, C_2, C_1, C_0};
	 
	 err_7 <= err_7_0;
	 err_6 <= err_6_0;
	 err_5 <= err_5_0;
	 err_4 <= err_4_0;
	 err_3 <= err_3_0;
	 err_2 <= err_2_0;
	 err_1 <= err_1_0;
	 err_0 <= err_0_0;
      end
   

   always @(tx_data or tx_control or PCS_Controls or err_7 or err_6 or err_5 or err_4 or err_3 or err_2 or err_1 or err_0 ) begin
      case (tx_control)
	 8'h0:              //data frame
            begin
               coded_vec = {tx_data[63:0], `Sync_data};
               T_TYPE = `D;
            end
	 8'hff:              // all control or terminate_0
            if (tx_data[7:0] == `XGMII_terminate) begin
               if (  err_7 || err_6 || err_5 || err_4 || err_3 || err_2 || err_1  ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:7],7'b0,`Type_8, `Sync_cont};
                  T_TYPE = `T;
               end
            end
            else begin
               if ( err_7 || err_6 || err_5 || err_4 || err_3 || err_2 || err_1 || err_0  ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  if  ((PCS_Controls[55:49] == `PCS_error) ||
                       (PCS_Controls[48:42] == `PCS_error) || 
                       (PCS_Controls[41:35] == `PCS_error) || 
                       (PCS_Controls[34:28] == `PCS_error) || 
                       (PCS_Controls[27:21] == `PCS_error) || 
                       (PCS_Controls[20:14] == `PCS_error) || 
                       (PCS_Controls[13:7]  == `PCS_error) ||
                       (PCS_Controls[6:0]   == `PCS_error)  ) begin
                     coded_vec = `EBLOCK_T;
                     T_TYPE = `E;
                  end
                  else begin
                     coded_vec = {PCS_Controls[55:0],`Type_1, `Sync_cont};
                     T_TYPE = `C;
                  end
               end
            end
	 8'h1f:              // 4-control with ordered_4 set   or 4-control with start_4
            if (tx_data[39:32] == `XGMII_Sequence_OS) begin
               if ( err_3 || err_2 || err_1 || err_0 ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {tx_data[63:40],`PCS_Sequence_OS,PCS_Controls[27:0],`Type_2, `Sync_cont};
                  T_TYPE = `C;
               end
            end
            else if (tx_data[39:32] == `XGMII_reserved_6) // This is an Fsig ordered set
            begin
               if ( err_3 || err_2 || err_1 || err_0 ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {tx_data[63:40],4'b1111,PCS_Controls[27:0],`Type_2, `Sync_cont};
                  T_TYPE = `C;
               end
            end
            else begin
               if (tx_data[39:32] == `XGMII_start) begin
                  if ( err_3 || err_2 || err_1 || err_0 ) begin
                     coded_vec = `EBLOCK_T;
                     T_TYPE = `E;
                  end
                  else begin
                     coded_vec = {tx_data[63:40],4'b0,PCS_Controls[27:0],`Type_3, `Sync_cont};
                     T_TYPE = `S;
                  end
               end
               else begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
            end
           
	 8'h11:              // ordered_0 with start_4 or ordered_0 with ordered_4
            if (tx_data[7:0] == `XGMII_Sequence_OS) begin
               if (tx_data[39:32] == `XGMII_Sequence_OS) begin
                  coded_vec = {tx_data[63:40],`PCS_Sequence_OS,`PCS_Sequence_OS,tx_data[31:8],`Type_5, `Sync_cont};
                  T_TYPE = `C;
               end
               else if (tx_data[39:32] == `XGMII_reserved_6) begin
                  coded_vec = {tx_data[63:40],4'b1111,`PCS_Sequence_OS,tx_data[31:8],`Type_5, `Sync_cont};
                  T_TYPE = `C;
               end
               else begin
                  if (tx_data[39:32] == `XGMII_start) begin
                     coded_vec = {tx_data[63:40],4'b0,`PCS_Sequence_OS,tx_data[31:8],`Type_4, `Sync_cont};
                     T_TYPE = `S;
                  end
                  else begin
                     coded_vec = `EBLOCK_T;
                     T_TYPE = `E;
                  end 
               end
            end 
            else if (tx_data[7:0] == `XGMII_reserved_6) begin
               if (tx_data[39:32] == `XGMII_Sequence_OS) begin
                  coded_vec = {tx_data[63:40],`PCS_Sequence_OS,4'b1111,tx_data[31:8],`Type_5, `Sync_cont};
                  T_TYPE = `C;
               end
               else if (tx_data[39:32] == `XGMII_reserved_6) begin
                  coded_vec = {tx_data[63:40],4'b1111,4'b1111,tx_data[31:8],`Type_5, `Sync_cont};
                  T_TYPE = `C;
               end
               else begin
                  if (tx_data[39:32] == `XGMII_start) begin
                     coded_vec = {tx_data[63:40],4'b0,4'b1111,tx_data[31:8],`Type_4, `Sync_cont};
                     T_TYPE = `S;
                  end
                  else begin
                     coded_vec = `EBLOCK_T;
                     T_TYPE = `E;
                  end 
               end
            end 
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end
	 8'h1:              // start_0 with data
            if (tx_data[7:0] == `XGMII_start) begin
               coded_vec = {tx_data[63:8],`Type_6, `Sync_cont };
               T_TYPE = `S;
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end
	 8'hf1:              // orderd_0 with control
            if (tx_data[7:0] == `XGMII_Sequence_OS) begin
               if ( err_7 || err_6 || err_5 || err_4 ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:28],`PCS_Sequence_OS,tx_data[31:8],`Type_7, `Sync_cont};
                  T_TYPE = `C;
               end
            end
            else if (tx_data[7:0] == `XGMII_reserved_6) begin
               if ( err_7 || err_6 || err_5 || err_4 ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:28],4'b1111,tx_data[31:8],`Type_7, `Sync_cont};
                  T_TYPE = `C;
               end
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end 
	 8'hfe:              // terminate_1 with control
            if (tx_data[15:8] == `XGMII_terminate) begin
               if ( err_7 || err_6 || err_5 || err_4 || err_3 || err_2  ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:14],6'b0,tx_data[7:0],`Type_9, `Sync_cont};
                  T_TYPE = `T;
               end
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end
	 8'hfc:              // terminate_2 with control
            if (tx_data[23:16] == `XGMII_terminate) begin
               if ( err_7 || err_6 || err_5 || err_4 || err_3 ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:21],5'b0,tx_data[15:0],`Type_10, `Sync_cont};
                  T_TYPE = `T;
               end
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end
	 8'hf8:              // terminate_3 with control
            if (tx_data[31:24] == `XGMII_terminate) begin
               if ( err_7 || err_6 || err_5 || err_4 ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:28],4'b0,tx_data[23:0],`Type_11, `Sync_cont};
                  T_TYPE = `T;
               end
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end
	 8'hf0:              // terminate_4 with control
            if (tx_data[39:32] == `XGMII_terminate) begin
               if ( err_7 || err_6 || err_5   ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:35],3'b0,tx_data[31:0],`Type_12, `Sync_cont};
                  T_TYPE = `T;
               end
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end
	 8'he0:              // terminate_5 with control
            if (tx_data[47:40] == `XGMII_terminate) begin
               if ( err_7 || err_6  ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:42],2'b0,tx_data[39:0],`Type_13, `Sync_cont};
                  T_TYPE = `T;
               end
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end
	 8'hc0:              // terminate_6 with control
            if (tx_data[55:48] == `XGMII_terminate) begin
               if (err_7 ) begin
                  coded_vec = `EBLOCK_T;
                  T_TYPE = `E;
               end
               else begin
                  coded_vec = {PCS_Controls[55:49],1'b0,tx_data[47:0],`Type_14, `Sync_cont};
                  T_TYPE = `T;
               end
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end

	 8'h80:              // terminate_7
            if (tx_data[63:56] == `XGMII_terminate) begin
               coded_vec = {tx_data[55:0],`Type_15, `Sync_cont };
               T_TYPE = `T;
            end
            else begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end
	 default:              // error
            begin
               coded_vec = `EBLOCK_T;
               T_TYPE = `E;
            end 
      endcase // case(tx_control)
   end // always @ (tx_data or tx_control or PCS_Controls or err_7 or err_6 or err_5 or err_4 or err_3 or err_2 or err_1 or err_0 )
   

endmodule // T_TYPE_Encode


