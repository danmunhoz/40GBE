//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: Encode.v
//
// Begin Date: Fri Jun 18 15:36:32 2004
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
// $Log: Encode.v,v $
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

module Encode (
               //  input ports
               bypass_66encoder, clk156, 
               rstb, txcontrol, txdata,
               //  output ports
               TXD_encoded, txlf
               );

   //  input ports
   input bypass_66encoder;
   input clk156;
   input rstb;
   input [7:0] txcontrol;
   input [63:0] txdata;
   
   //  output ports
   output [65:0] TXD_encoded;
   output 	 txlf;
   
   //  local signals 
   wire  bypass_66encoder;
   wire  clk156;
   wire  rstb;
   wire [7:0]  txcontrol;
   wire [63:0] 	txdata;
   wire [65:0] 	 TXD_encoded;
   wire 	 txlf;
   wire 	 LF_init_state;
   wire [2:0]      T_TYPE;
   wire [65:0]      coded_vec;  
   
   
   T_TYPE_Encode  T_TYPE_Encode
     (
      //  input ports
      .clk156(clk156),
      .rstb(rstb),
      .txdata(txdata[63:0]),
      .txcontrol(txcontrol[7:0]),
      //  output ports
      .coded_vec(coded_vec[65:0]),
      .T_TYPE(T_TYPE[2:0])
      );
   
   TX_FSM  TX_FSM
     (
      //  input ports
      .clk156(clk156),
      .rstb(rstb),
      .T_TYPE(T_TYPE[2:0]),
      .coded_vec(coded_vec[65:0]),
      .txdata(txdata[63:0]),
      .bypass_66encoder(bypass_66encoder),
      //  output ports
      .TXD_encoded(TXD_encoded[65:0]),
      .txlf(txlf)
      );
   
   
   
endmodule

