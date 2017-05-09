//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: PCS_to_XGMII.v
//
//
// Begin Date: Fri Jun 18 15:46:11 2004
//
// Description: This file has the code for PCS to XGMII code conversion
//              It is used as a part of the decoding function
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
// $Log: PCS_to_XGMII.v,v $
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

module  PCS_to_XGMII (in_code, out_code);
   input [6:0] in_code ; wire [6:0] in_code ;
   output [7:0] out_code ; reg [7:0] out_code ;

   always @(in_code)
      case (in_code)
         `PCS_reserved_0 :out_code = `XGMII_reserved_0 ;
         `PCS_reserved_1 :out_code = `XGMII_reserved_1 ;
         `PCS_reserved_2 :out_code = `XGMII_reserved_2 ;
         `PCS_reserved_3 :out_code = `XGMII_reserved_3 ;
         `PCS_reserved_4 :out_code = `XGMII_reserved_4 ;
         `PCS_reserved_5 :out_code = `XGMII_reserved_5 ;
         `PCS_idle       :out_code = `XGMII_idle ;
         `PCS_error      :out_code = `XGMII_error ;
         default          :out_code = 8'hff ;
      endcase

endmodule // PCS_to_XGMII


