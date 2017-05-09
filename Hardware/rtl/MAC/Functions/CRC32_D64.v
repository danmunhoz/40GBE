///////////////////////////////////////////////////////////////////////
// File:  CRC32_D64.v
// Date:  Fri Feb  8 19:30:02 2008
//
// Copyright (C) 1999-2003 Easics NV.
// This source file may be used and distributed without restriction
// provided that this copyright statement is not removed from the file
// and that any derivative work contains the original copyright notice
// and the associated disclaimer.
//
// THIS SOURCE FILE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
// OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
//
// Purpose: Verilog module containing a synthesizable CRC function
//   * polynomial: (0 1 2 4 5 7 8 10 11 12 16 22 23 26 32)
//   * data width: 64
//
// Info: tools@easics.be
//       http://www.easics.com
///////////////////////////////////////////////////////////////////////


//module CRC32_D64;

  // polynomial: (0 1 2 4 5 7 8 10 11 12 16 22 23 26 32)
  // data width: 64
  // convention: the first serial data bit is D[63]
  function [31:0] nextCRC32_D64;

    input [63:0] Data;
    input [31:0] CRC;

    reg [63:0] D;
    reg [31:0] C;
    reg [31:0] NewCRC;

  begin

    D = Data;
    C = CRC;

    NewCRC[0] = D[63] ^ D[61] ^ D[60] ^ D[58] ^ D[55] ^ D[54] ^ D[53] ^
                D[50] ^ D[48] ^ D[47] ^ D[45] ^ D[44] ^ D[37] ^ D[34] ^
                D[32] ^ D[31] ^ D[30] ^ D[29] ^ D[28] ^ D[26] ^ D[25] ^
                D[24] ^ D[16] ^ D[12] ^ D[10] ^ D[9] ^ D[6] ^ D[0] ^
                C[0] ^ C[2] ^ C[5] ^ C[12] ^ C[13] ^ C[15] ^ C[16] ^
                C[18] ^ C[21] ^ C[22] ^ C[23] ^ C[26] ^ C[28] ^ C[29] ^
                C[31];
    NewCRC[1] = D[63] ^ D[62] ^ D[60] ^ D[59] ^ D[58] ^ D[56] ^ D[53] ^
                D[51] ^ D[50] ^ D[49] ^ D[47] ^ D[46] ^ D[44] ^ D[38] ^
                D[37] ^ D[35] ^ D[34] ^ D[33] ^ D[28] ^ D[27] ^ D[24] ^
                D[17] ^ D[16] ^ D[13] ^ D[12] ^ D[11] ^ D[9] ^ D[7] ^
                D[6] ^ D[1] ^ D[0] ^ C[1] ^ C[2] ^ C[3] ^ C[5] ^ C[6] ^
                C[12] ^ C[14] ^ C[15] ^ C[17] ^ C[18] ^ C[19] ^ C[21] ^
                C[24] ^ C[26] ^ C[27] ^ C[28] ^ C[30] ^ C[31];
    NewCRC[2] = D[59] ^ D[58] ^ D[57] ^ D[55] ^ D[53] ^ D[52] ^ D[51] ^
                D[44] ^ D[39] ^ D[38] ^ D[37] ^ D[36] ^ D[35] ^ D[32] ^
                D[31] ^ D[30] ^ D[26] ^ D[24] ^ D[18] ^ D[17] ^ D[16] ^
                D[14] ^ D[13] ^ D[9] ^ D[8] ^ D[7] ^ D[6] ^ D[2] ^
                D[1] ^ D[0] ^ C[0] ^ C[3] ^ C[4] ^ C[5] ^ C[6] ^ C[7] ^
                C[12] ^ C[19] ^ C[20] ^ C[21] ^ C[23] ^ C[25] ^ C[26] ^
                C[27];
    NewCRC[3] = D[60] ^ D[59] ^ D[58] ^ D[56] ^ D[54] ^ D[53] ^ D[52] ^
                D[45] ^ D[40] ^ D[39] ^ D[38] ^ D[37] ^ D[36] ^ D[33] ^
                D[32] ^ D[31] ^ D[27] ^ D[25] ^ D[19] ^ D[18] ^ D[17] ^
                D[15] ^ D[14] ^ D[10] ^ D[9] ^ D[8] ^ D[7] ^ D[3] ^
                D[2] ^ D[1] ^ C[0] ^ C[1] ^ C[4] ^ C[5] ^ C[6] ^ C[7] ^
                C[8] ^ C[13] ^ C[20] ^ C[21] ^ C[22] ^ C[24] ^ C[26] ^
                C[27] ^ C[28];
    NewCRC[4] = D[63] ^ D[59] ^ D[58] ^ D[57] ^ D[50] ^ D[48] ^ D[47] ^
                D[46] ^ D[45] ^ D[44] ^ D[41] ^ D[40] ^ D[39] ^ D[38] ^
                D[33] ^ D[31] ^ D[30] ^ D[29] ^ D[25] ^ D[24] ^ D[20] ^
                D[19] ^ D[18] ^ D[15] ^ D[12] ^ D[11] ^ D[8] ^ D[6] ^
                D[4] ^ D[3] ^ D[2] ^ D[0] ^ C[1] ^ C[6] ^ C[7] ^ C[8] ^
                C[9] ^ C[12] ^ C[13] ^ C[14] ^ C[15] ^ C[16] ^ C[18] ^
                C[25] ^ C[26] ^ C[27] ^ C[31];
    NewCRC[5] = D[63] ^ D[61] ^ D[59] ^ D[55] ^ D[54] ^ D[53] ^ D[51] ^
                D[50] ^ D[49] ^ D[46] ^ D[44] ^ D[42] ^ D[41] ^ D[40] ^
                D[39] ^ D[37] ^ D[29] ^ D[28] ^ D[24] ^ D[21] ^ D[20] ^
                D[19] ^ D[13] ^ D[10] ^ D[7] ^ D[6] ^ D[5] ^ D[4] ^
                D[3] ^ D[1] ^ D[0] ^ C[5] ^ C[7] ^ C[8] ^ C[9] ^ C[10] ^
                C[12] ^ C[14] ^ C[17] ^ C[18] ^ C[19] ^ C[21] ^ C[22] ^
                C[23] ^ C[27] ^ C[29] ^ C[31];
    NewCRC[6] = D[62] ^ D[60] ^ D[56] ^ D[55] ^ D[54] ^ D[52] ^ D[51] ^
                D[50] ^ D[47] ^ D[45] ^ D[43] ^ D[42] ^ D[41] ^ D[40] ^
                D[38] ^ D[30] ^ D[29] ^ D[25] ^ D[22] ^ D[21] ^ D[20] ^
                D[14] ^ D[11] ^ D[8] ^ D[7] ^ D[6] ^ D[5] ^ D[4] ^
                D[2] ^ D[1] ^ C[6] ^ C[8] ^ C[9] ^ C[10] ^ C[11] ^
                C[13] ^ C[15] ^ C[18] ^ C[19] ^ C[20] ^ C[22] ^ C[23] ^
                C[24] ^ C[28] ^ C[30];
    NewCRC[7] = D[60] ^ D[58] ^ D[57] ^ D[56] ^ D[54] ^ D[52] ^ D[51] ^
                D[50] ^ D[47] ^ D[46] ^ D[45] ^ D[43] ^ D[42] ^ D[41] ^
                D[39] ^ D[37] ^ D[34] ^ D[32] ^ D[29] ^ D[28] ^ D[25] ^
                D[24] ^ D[23] ^ D[22] ^ D[21] ^ D[16] ^ D[15] ^ D[10] ^
                D[8] ^ D[7] ^ D[5] ^ D[3] ^ D[2] ^ D[0] ^ C[0] ^ C[2] ^
                C[5] ^ C[7] ^ C[9] ^ C[10] ^ C[11] ^ C[13] ^ C[14] ^
                C[15] ^ C[18] ^ C[19] ^ C[20] ^ C[22] ^ C[24] ^ C[25] ^
                C[26] ^ C[28];
    NewCRC[8] = D[63] ^ D[60] ^ D[59] ^ D[57] ^ D[54] ^ D[52] ^ D[51] ^
                D[50] ^ D[46] ^ D[45] ^ D[43] ^ D[42] ^ D[40] ^ D[38] ^
                D[37] ^ D[35] ^ D[34] ^ D[33] ^ D[32] ^ D[31] ^ D[28] ^
                D[23] ^ D[22] ^ D[17] ^ D[12] ^ D[11] ^ D[10] ^ D[8] ^
                D[4] ^ D[3] ^ D[1] ^ D[0] ^ C[0] ^ C[1] ^ C[2] ^ C[3] ^
                C[5] ^ C[6] ^ C[8] ^ C[10] ^ C[11] ^ C[13] ^ C[14] ^
                C[18] ^ C[19] ^ C[20] ^ C[22] ^ C[25] ^ C[27] ^ C[28] ^
                C[31];
    NewCRC[9] = D[61] ^ D[60] ^ D[58] ^ D[55] ^ D[53] ^ D[52] ^ D[51] ^
                D[47] ^ D[46] ^ D[44] ^ D[43] ^ D[41] ^ D[39] ^ D[38] ^
                D[36] ^ D[35] ^ D[34] ^ D[33] ^ D[32] ^ D[29] ^ D[24] ^
                D[23] ^ D[18] ^ D[13] ^ D[12] ^ D[11] ^ D[9] ^ D[5] ^
                D[4] ^ D[2] ^ D[1] ^ C[0] ^ C[1] ^ C[2] ^ C[3] ^ C[4] ^
                C[6] ^ C[7] ^ C[9] ^ C[11] ^ C[12] ^ C[14] ^ C[15] ^
                C[19] ^ C[20] ^ C[21] ^ C[23] ^ C[26] ^ C[28] ^ C[29];
    NewCRC[10] = D[63] ^ D[62] ^ D[60] ^ D[59] ^ D[58] ^ D[56] ^ D[55] ^
                 D[52] ^ D[50] ^ D[42] ^ D[40] ^ D[39] ^ D[36] ^ D[35] ^
                 D[33] ^ D[32] ^ D[31] ^ D[29] ^ D[28] ^ D[26] ^ D[19] ^
                 D[16] ^ D[14] ^ D[13] ^ D[9] ^ D[5] ^ D[3] ^ D[2] ^
                 D[0] ^ C[0] ^ C[1] ^ C[3] ^ C[4] ^ C[7] ^ C[8] ^ C[10] ^
                 C[18] ^ C[20] ^ C[23] ^ C[24] ^ C[26] ^ C[27] ^ C[28] ^
                 C[30] ^ C[31];
    NewCRC[11] = D[59] ^ D[58] ^ D[57] ^ D[56] ^ D[55] ^ D[54] ^ D[51] ^
                 D[50] ^ D[48] ^ D[47] ^ D[45] ^ D[44] ^ D[43] ^ D[41] ^
                 D[40] ^ D[36] ^ D[33] ^ D[31] ^ D[28] ^ D[27] ^ D[26] ^
                 D[25] ^ D[24] ^ D[20] ^ D[17] ^ D[16] ^ D[15] ^ D[14] ^
                 D[12] ^ D[9] ^ D[4] ^ D[3] ^ D[1] ^ D[0] ^ C[1] ^ C[4] ^
                 C[8] ^ C[9] ^ C[11] ^ C[12] ^ C[13] ^ C[15] ^ C[16] ^
                 C[18] ^ C[19] ^ C[22] ^ C[23] ^ C[24] ^ C[25] ^ C[26] ^
                 C[27];
    NewCRC[12] = D[63] ^ D[61] ^ D[59] ^ D[57] ^ D[56] ^ D[54] ^ D[53] ^
                 D[52] ^ D[51] ^ D[50] ^ D[49] ^ D[47] ^ D[46] ^ D[42] ^
                 D[41] ^ D[31] ^ D[30] ^ D[27] ^ D[24] ^ D[21] ^ D[18] ^
                 D[17] ^ D[15] ^ D[13] ^ D[12] ^ D[9] ^ D[6] ^ D[5] ^
                 D[4] ^ D[2] ^ D[1] ^ D[0] ^ C[9] ^ C[10] ^ C[14] ^
                 C[15] ^ C[17] ^ C[18] ^ C[19] ^ C[20] ^ C[21] ^ C[22] ^
                 C[24] ^ C[25] ^ C[27] ^ C[29] ^ C[31];
    NewCRC[13] = D[62] ^ D[60] ^ D[58] ^ D[57] ^ D[55] ^ D[54] ^ D[53] ^
                 D[52] ^ D[51] ^ D[50] ^ D[48] ^ D[47] ^ D[43] ^ D[42] ^
                 D[32] ^ D[31] ^ D[28] ^ D[25] ^ D[22] ^ D[19] ^ D[18] ^
                 D[16] ^ D[14] ^ D[13] ^ D[10] ^ D[7] ^ D[6] ^ D[5] ^
                 D[3] ^ D[2] ^ D[1] ^ C[0] ^ C[10] ^ C[11] ^ C[15] ^
                 C[16] ^ C[18] ^ C[19] ^ C[20] ^ C[21] ^ C[22] ^ C[23] ^
                 C[25] ^ C[26] ^ C[28] ^ C[30];
    NewCRC[14] = D[63] ^ D[61] ^ D[59] ^ D[58] ^ D[56] ^ D[55] ^ D[54] ^
                 D[53] ^ D[52] ^ D[51] ^ D[49] ^ D[48] ^ D[44] ^ D[43] ^
                 D[33] ^ D[32] ^ D[29] ^ D[26] ^ D[23] ^ D[20] ^ D[19] ^
                 D[17] ^ D[15] ^ D[14] ^ D[11] ^ D[8] ^ D[7] ^ D[6] ^
                 D[4] ^ D[3] ^ D[2] ^ C[0] ^ C[1] ^ C[11] ^ C[12] ^
                 C[16] ^ C[17] ^ C[19] ^ C[20] ^ C[21] ^ C[22] ^ C[23] ^
                 C[24] ^ C[26] ^ C[27] ^ C[29] ^ C[31];
    NewCRC[15] = D[62] ^ D[60] ^ D[59] ^ D[57] ^ D[56] ^ D[55] ^ D[54] ^
                 D[53] ^ D[52] ^ D[50] ^ D[49] ^ D[45] ^ D[44] ^ D[34] ^
                 D[33] ^ D[30] ^ D[27] ^ D[24] ^ D[21] ^ D[20] ^ D[18] ^
                 D[16] ^ D[15] ^ D[12] ^ D[9] ^ D[8] ^ D[7] ^ D[5] ^
                 D[4] ^ D[3] ^ C[1] ^ C[2] ^ C[12] ^ C[13] ^ C[17] ^
                 C[18] ^ C[20] ^ C[21] ^ C[22] ^ C[23] ^ C[24] ^ C[25] ^
                 C[27] ^ C[28] ^ C[30];
    NewCRC[16] = D[57] ^ D[56] ^ D[51] ^ D[48] ^ D[47] ^ D[46] ^ D[44] ^
                 D[37] ^ D[35] ^ D[32] ^ D[30] ^ D[29] ^ D[26] ^ D[24] ^
                 D[22] ^ D[21] ^ D[19] ^ D[17] ^ D[13] ^ D[12] ^ D[8] ^
                 D[5] ^ D[4] ^ D[0] ^ C[0] ^ C[3] ^ C[5] ^ C[12] ^ C[14] ^
                 C[15] ^ C[16] ^ C[19] ^ C[24] ^ C[25];
    NewCRC[17] = D[58] ^ D[57] ^ D[52] ^ D[49] ^ D[48] ^ D[47] ^ D[45] ^
                 D[38] ^ D[36] ^ D[33] ^ D[31] ^ D[30] ^ D[27] ^ D[25] ^
                 D[23] ^ D[22] ^ D[20] ^ D[18] ^ D[14] ^ D[13] ^ D[9] ^
                 D[6] ^ D[5] ^ D[1] ^ C[1] ^ C[4] ^ C[6] ^ C[13] ^ C[15] ^
                 C[16] ^ C[17] ^ C[20] ^ C[25] ^ C[26];
    NewCRC[18] = D[59] ^ D[58] ^ D[53] ^ D[50] ^ D[49] ^ D[48] ^ D[46] ^
                 D[39] ^ D[37] ^ D[34] ^ D[32] ^ D[31] ^ D[28] ^ D[26] ^
                 D[24] ^ D[23] ^ D[21] ^ D[19] ^ D[15] ^ D[14] ^ D[10] ^
                 D[7] ^ D[6] ^ D[2] ^ C[0] ^ C[2] ^ C[5] ^ C[7] ^ C[14] ^
                 C[16] ^ C[17] ^ C[18] ^ C[21] ^ C[26] ^ C[27];
    NewCRC[19] = D[60] ^ D[59] ^ D[54] ^ D[51] ^ D[50] ^ D[49] ^ D[47] ^
                 D[40] ^ D[38] ^ D[35] ^ D[33] ^ D[32] ^ D[29] ^ D[27] ^
                 D[25] ^ D[24] ^ D[22] ^ D[20] ^ D[16] ^ D[15] ^ D[11] ^
                 D[8] ^ D[7] ^ D[3] ^ C[0] ^ C[1] ^ C[3] ^ C[6] ^ C[8] ^
                 C[15] ^ C[17] ^ C[18] ^ C[19] ^ C[22] ^ C[27] ^ C[28];
    NewCRC[20] = D[61] ^ D[60] ^ D[55] ^ D[52] ^ D[51] ^ D[50] ^ D[48] ^
                 D[41] ^ D[39] ^ D[36] ^ D[34] ^ D[33] ^ D[30] ^ D[28] ^
                 D[26] ^ D[25] ^ D[23] ^ D[21] ^ D[17] ^ D[16] ^ D[12] ^
                 D[9] ^ D[8] ^ D[4] ^ C[1] ^ C[2] ^ C[4] ^ C[7] ^ C[9] ^
                 C[16] ^ C[18] ^ C[19] ^ C[20] ^ C[23] ^ C[28] ^ C[29];
    NewCRC[21] = D[62] ^ D[61] ^ D[56] ^ D[53] ^ D[52] ^ D[51] ^ D[49] ^
                 D[42] ^ D[40] ^ D[37] ^ D[35] ^ D[34] ^ D[31] ^ D[29] ^
                 D[27] ^ D[26] ^ D[24] ^ D[22] ^ D[18] ^ D[17] ^ D[13] ^
                 D[10] ^ D[9] ^ D[5] ^ C[2] ^ C[3] ^ C[5] ^ C[8] ^ C[10] ^
                 C[17] ^ C[19] ^ C[20] ^ C[21] ^ C[24] ^ C[29] ^ C[30];
    NewCRC[22] = D[62] ^ D[61] ^ D[60] ^ D[58] ^ D[57] ^ D[55] ^ D[52] ^
                 D[48] ^ D[47] ^ D[45] ^ D[44] ^ D[43] ^ D[41] ^ D[38] ^
                 D[37] ^ D[36] ^ D[35] ^ D[34] ^ D[31] ^ D[29] ^ D[27] ^
                 D[26] ^ D[24] ^ D[23] ^ D[19] ^ D[18] ^ D[16] ^ D[14] ^
                 D[12] ^ D[11] ^ D[9] ^ D[0] ^ C[2] ^ C[3] ^ C[4] ^
                 C[5] ^ C[6] ^ C[9] ^ C[11] ^ C[12] ^ C[13] ^ C[15] ^
                 C[16] ^ C[20] ^ C[23] ^ C[25] ^ C[26] ^ C[28] ^ C[29] ^
                 C[30];
    NewCRC[23] = D[62] ^ D[60] ^ D[59] ^ D[56] ^ D[55] ^ D[54] ^ D[50] ^
                 D[49] ^ D[47] ^ D[46] ^ D[42] ^ D[39] ^ D[38] ^ D[36] ^
                 D[35] ^ D[34] ^ D[31] ^ D[29] ^ D[27] ^ D[26] ^ D[20] ^
                 D[19] ^ D[17] ^ D[16] ^ D[15] ^ D[13] ^ D[9] ^ D[6] ^
                 D[1] ^ D[0] ^ C[2] ^ C[3] ^ C[4] ^ C[6] ^ C[7] ^ C[10] ^
                 C[14] ^ C[15] ^ C[17] ^ C[18] ^ C[22] ^ C[23] ^ C[24] ^
                 C[27] ^ C[28] ^ C[30];
    NewCRC[24] = D[63] ^ D[61] ^ D[60] ^ D[57] ^ D[56] ^ D[55] ^ D[51] ^
                 D[50] ^ D[48] ^ D[47] ^ D[43] ^ D[40] ^ D[39] ^ D[37] ^
                 D[36] ^ D[35] ^ D[32] ^ D[30] ^ D[28] ^ D[27] ^ D[21] ^
                 D[20] ^ D[18] ^ D[17] ^ D[16] ^ D[14] ^ D[10] ^ D[7] ^
                 D[2] ^ D[1] ^ C[0] ^ C[3] ^ C[4] ^ C[5] ^ C[7] ^ C[8] ^
                 C[11] ^ C[15] ^ C[16] ^ C[18] ^ C[19] ^ C[23] ^ C[24] ^
                 C[25] ^ C[28] ^ C[29] ^ C[31];
    NewCRC[25] = D[62] ^ D[61] ^ D[58] ^ D[57] ^ D[56] ^ D[52] ^ D[51] ^
                 D[49] ^ D[48] ^ D[44] ^ D[41] ^ D[40] ^ D[38] ^ D[37] ^
                 D[36] ^ D[33] ^ D[31] ^ D[29] ^ D[28] ^ D[22] ^ D[21] ^
                 D[19] ^ D[18] ^ D[17] ^ D[15] ^ D[11] ^ D[8] ^ D[3] ^
                 D[2] ^ C[1] ^ C[4] ^ C[5] ^ C[6] ^ C[8] ^ C[9] ^ C[12] ^
                 C[16] ^ C[17] ^ C[19] ^ C[20] ^ C[24] ^ C[25] ^ C[26] ^
                 C[29] ^ C[30];
    NewCRC[26] = D[62] ^ D[61] ^ D[60] ^ D[59] ^ D[57] ^ D[55] ^ D[54] ^
                 D[52] ^ D[49] ^ D[48] ^ D[47] ^ D[44] ^ D[42] ^ D[41] ^
                 D[39] ^ D[38] ^ D[31] ^ D[28] ^ D[26] ^ D[25] ^ D[24] ^
                 D[23] ^ D[22] ^ D[20] ^ D[19] ^ D[18] ^ D[10] ^ D[6] ^
                 D[4] ^ D[3] ^ D[0] ^ C[6] ^ C[7] ^ C[9] ^ C[10] ^ C[12] ^
                 C[15] ^ C[16] ^ C[17] ^ C[20] ^ C[22] ^ C[23] ^ C[25] ^
                 C[27] ^ C[28] ^ C[29] ^ C[30];
    NewCRC[27] = D[63] ^ D[62] ^ D[61] ^ D[60] ^ D[58] ^ D[56] ^ D[55] ^
                 D[53] ^ D[50] ^ D[49] ^ D[48] ^ D[45] ^ D[43] ^ D[42] ^
                 D[40] ^ D[39] ^ D[32] ^ D[29] ^ D[27] ^ D[26] ^ D[25] ^
                 D[24] ^ D[23] ^ D[21] ^ D[20] ^ D[19] ^ D[11] ^ D[7] ^
                 D[5] ^ D[4] ^ D[1] ^ C[0] ^ C[7] ^ C[8] ^ C[10] ^ C[11] ^
                 C[13] ^ C[16] ^ C[17] ^ C[18] ^ C[21] ^ C[23] ^ C[24] ^
                 C[26] ^ C[28] ^ C[29] ^ C[30] ^ C[31];
    NewCRC[28] = D[63] ^ D[62] ^ D[61] ^ D[59] ^ D[57] ^ D[56] ^ D[54] ^
                 D[51] ^ D[50] ^ D[49] ^ D[46] ^ D[44] ^ D[43] ^ D[41] ^
                 D[40] ^ D[33] ^ D[30] ^ D[28] ^ D[27] ^ D[26] ^ D[25] ^
                 D[24] ^ D[22] ^ D[21] ^ D[20] ^ D[12] ^ D[8] ^ D[6] ^
                 D[5] ^ D[2] ^ C[1] ^ C[8] ^ C[9] ^ C[11] ^ C[12] ^
                 C[14] ^ C[17] ^ C[18] ^ C[19] ^ C[22] ^ C[24] ^ C[25] ^
                 C[27] ^ C[29] ^ C[30] ^ C[31];
    NewCRC[29] = D[63] ^ D[62] ^ D[60] ^ D[58] ^ D[57] ^ D[55] ^ D[52] ^
                 D[51] ^ D[50] ^ D[47] ^ D[45] ^ D[44] ^ D[42] ^ D[41] ^
                 D[34] ^ D[31] ^ D[29] ^ D[28] ^ D[27] ^ D[26] ^ D[25] ^
                 D[23] ^ D[22] ^ D[21] ^ D[13] ^ D[9] ^ D[7] ^ D[6] ^
                 D[3] ^ C[2] ^ C[9] ^ C[10] ^ C[12] ^ C[13] ^ C[15] ^
                 C[18] ^ C[19] ^ C[20] ^ C[23] ^ C[25] ^ C[26] ^ C[28] ^
                 C[30] ^ C[31];
    NewCRC[30] = D[63] ^ D[61] ^ D[59] ^ D[58] ^ D[56] ^ D[53] ^ D[52] ^
                 D[51] ^ D[48] ^ D[46] ^ D[45] ^ D[43] ^ D[42] ^ D[35] ^
                 D[32] ^ D[30] ^ D[29] ^ D[28] ^ D[27] ^ D[26] ^ D[24] ^
                 D[23] ^ D[22] ^ D[14] ^ D[10] ^ D[8] ^ D[7] ^ D[4] ^
                 C[0] ^ C[3] ^ C[10] ^ C[11] ^ C[13] ^ C[14] ^ C[16] ^
                 C[19] ^ C[20] ^ C[21] ^ C[24] ^ C[26] ^ C[27] ^ C[29] ^
                 C[31];
    NewCRC[31] = D[62] ^ D[60] ^ D[59] ^ D[57] ^ D[54] ^ D[53] ^ D[52] ^
                 D[49] ^ D[47] ^ D[46] ^ D[44] ^ D[43] ^ D[36] ^ D[33] ^
                 D[31] ^ D[30] ^ D[29] ^ D[28] ^ D[27] ^ D[25] ^ D[24] ^
                 D[23] ^ D[15] ^ D[11] ^ D[9] ^ D[8] ^ D[5] ^ C[1] ^
                 C[4] ^ C[11] ^ C[12] ^ C[14] ^ C[15] ^ C[17] ^ C[20] ^
                 C[21] ^ C[22] ^ C[25] ^ C[27] ^ C[28] ^ C[30];

    nextCRC32_D64 = NewCRC;

  end

  endfunction

//endmodule
