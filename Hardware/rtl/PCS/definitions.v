//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: definitions.v
//
// Author: Justin Gaither
//
// Begin Date: Fri Jun 18 15:59:48 2004
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
// $Log: definitions.v,v $
// Revision 1.1  2014-07-15 19:51:01  thomas.volpato
// Modificado diretorio de arquivos conforme especificado no documento da datacom
//
// Revision 1.1  2014-07-07 23:58:23  ricardo.guazzelli
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

// idle decoding (Extra two bits to denote idle next)
`define A_next    2'b11
`define R_K_next  2'b01
`define Q_next    2'b10
`define None_next 2'b00


// GMII code groups
`define GMII_A         8'h7c
`define GMII_R         8'h1c
`define GMII_K         8'hbc
`define GMII_IDLE      8'h07
`define GMII_START     8'hfb
`define GMII_TERMINATE 8'hfd
`define GMII_T         8'hfd
`define GMII_ERROR     8'hfe
`define GMII_SEQ       8'h9c
`define GMII_INVALID   8'hdd
`define GMII_A_Rnext   8'h01 // special R next codes
`define GMII_K_Rnext   8'h02 // they get remapped to 
`define GMII_R_Rnext   8'h03 // Idle or appropiate code
// before leaving.

`define A_NORMAL 2'h0
`define A_ADD 2'h1
`define A_DEL 2'h2
`define A_RESTART 2'h3

// for sync state machine
`define PUDI_COMMA 2'b01
`define PUDI_INVALID 2'b11
`define PUDI_VALID 2'b00


// TX code select
`define TX_CODE_K    4'h1
`define TX_CODE_A    4'h2
`define TX_CODE_R    4'h3
`define TX_CODE_DATA 4'h4
`define TX_CODE_Q    4'h5


`define CG_RDN_K 10'h17c  // bit reversed from spec(a=bit0)
`define CG_RDP_K 10'h283
`define CG_RDN_R 10'h0bc
`define CG_RDP_R 10'h343
`define CG_RDN_S 10'h05b
`define CG_RDP_S 10'h3a4
`define CG_RDN_T 10'h05d
`define CG_RDP_T 10'h3a2
`define CG_RDN_E 10'h05e
`define CG_RDP_E 10'h3a1
`define CG_RDN_A 10'h33c
`define CG_RDP_A 10'h0c3
`define CG_RDN_P 10'h13c
`define CG_RDP_P 10'h2c3
`define CG_RDP_A_Rnext  10'h001 // special R next codes
`define CG_RDP_K_Rnext  10'h002 // they get remapped to 
`define CG_RDP_R_Rnext  10'h003 // appropiate codes later
`define CG_RDN_A_Rnext  10'h005 // special R next codes
`define CG_RDN_K_Rnext  10'h006 // they get remapped to 
`define CG_RDN_R_Rnext  10'h007 // appropiate code later

`define RXD_IDLE {2'b10,`GMII_IDLE,2'b10,`GMII_IDLE,2'b10,`GMII_IDLE,2'b10,`GMII_IDLE}
`define LOCAL_FAULT {2'b00,8'h01,2'b00,8'h00,2'b00,8'h00,2'b10,`GMII_SEQ}

// For Encoder
`define  XGMII_LF_OS       64'h0100009c0100009c
`define  XGMII_Sequence_OS 8'b10011100
`define  XGMII_reserved_0  8'b00011100
`define  XGMII_reserved_1  8'b00111100
`define  XGMII_reserved_2  8'b01111100
`define  XGMII_reserved_3  8'b10111100
`define  XGMII_reserved_4  8'b11011100
`define  XGMII_reserved_5  8'b11110111
`define  XGMII_reserved_6  8'b01011100
`define  XGMII_idle        8'b00000111
`define  XGMII_start       8'b11111011
`define  XGMII_terminate   8'b11111101
`define  XGMII_error       8'b11111110
`define  PCS_LF_OS         64'h0100000001000055
`define  PCS_idle          7'b0000000
`define  PCS_error         7'b0011110
`define  PCS_Sequence_OS   4'b0000
`define  PCS_reserved_0    7'b0101101
`define  PCS_reserved_1    7'b0110011
`define  PCS_reserved_2    7'b1001011
`define  PCS_reserved_3    7'b1010101
`define  PCS_reserved_4    7'b1100110
`define  PCS_reserved_5    7'b1111000
`define  PCS_reserved_6    4'b1111
`define  Type_1  8'b00011110
`define  Type_2  8'b00101101
`define  Type_3  8'b00110011
`define  Type_4  8'b01100110
`define  Type_5  8'b01010101
`define  Type_6  8'b01111000
`define  Type_7  8'b01001011
`define  Type_8  8'b10000111
`define  Type_9  8'b10011001
`define  Type_10 8'b10101010
`define  Type_11 8'b10110100
`define  Type_12 8'b11001100
`define  Type_13 8'b11010010
`define  Type_14 8'b11100001
`define  Type_15 8'b11111111
`define  Sync_data 2'b10
`define  Sync_cont 2'b01

//`define  EBLOCK_R {`XGMII_error,`XGMII_error,`XGMII_error,`XGMII_error,`XGMII_error,`XGMII_error,`XGMII_error,`XGMII_error}
//`define  EBLOCK_T {`PCS_error,`PCS_error,`PCS_error,`PCS_error,`PCS_error,`PCS_error,`PCS_error,`PCS_error,`Type_1,`Sync_cont}
`define EBLOCK_R {8'b11111110,8'b11111110,8'b11111110,8'b11111110,8'b11111110,8'b11111110,8'b11111110,8'b11111110}
`define EBLOCK_T {7'b0011110,7'b0011110,7'b0011110,7'b0011110,7'b0011110,7'b0011110,7'b0011110,7'b0011110,8'b00011110,2'b01}

`define  LBLOCK_T {8'b00000001,8'b00000000,8'b00000000,`PCS_Sequence_OS,`PCS_Sequence_OS,8'b00000001,8'b00000000,8'b00000000,`Type_5,`Sync_cont}
`define  LBLOCK_R {8'b00000001,8'b00000000,8'b00000000,`XGMII_Sequence_OS,8'b00000001,8'b00000000,8'b00000000,`XGMII_Sequence_OS}
`define  TX_INIT 3'b000
`define  TX_C    3'b001
`define  TX_S    3'b010
`define  TX_D    3'b011
`define  TX_T    3'b100
`define  TX_E    3'b101
`define  RX_INIT 3'b000
`define  RX_C    3'b001
`define  RX_S    3'b010
`define  RX_D    3'b011
`define  RX_T    3'b100
`define  RX_E    3'b101
`define  C 3'b000
`define  S 3'b001
`define  T 3'b010
`define  D 3'b011
`define  E 3'b100
