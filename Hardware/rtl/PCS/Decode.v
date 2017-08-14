//------------------------------------------------------------------------------
// Xilinx Proprietary and Confidential
//
// FileName: Decode.v
//
//
//------------------------------------------------------------------------------

module Decode (
               //  input ports
               DeScr_RXD, blk_lock, bypass_66decoder, lpbk,
               clear_errblk, clk156, hi_ber, rstb156,
               //  output ports
               rxlf, errd_blks, rxcontrol, rxdata
               );

//  input ports
    input [65:0] DeScr_RXD;
    wire [65:0]  DeScr_RXD;
    input        blk_lock;
    wire         blk_lock;
    input        bypass_66decoder;
    wire         bypass_66decoder;
    input        lpbk;
    wire         lpbk;
    input        clear_errblk;
    wire         clear_errblk;
    input        clk156;
    wire         clk156;
    input        hi_ber;
    wire         hi_ber;
    input        rstb156;
    wire         rstb156;

//  output ports
    output       rxlf;
    wire         rxlf;
    output [7:0] errd_blks;
    wire [7:0]   errd_blks;
    output [7:0] rxcontrol;
    wire [7:0]   rxcontrol;
    output [63:0] rxdata;
    wire [63:0]   rxdata;

//  local signals
    wire [2:0]    R_TYPE;
    wire [7:0]    rx_control;
    wire [63:0]   rx_data;

R_TYPE_Decode  R_TYPE_Decode(
                             //  input ports
                             .rstb156(rstb156),
                             .clk156(clk156),
                             .DeScr_RXD(DeScr_RXD[65:0]),
                             //  output ports
                             .R_TYPE(R_TYPE[2:0]),
                             .rx_data(rx_data[63:0]),
                             .rx_control(rx_control[7:0])
                             );

RX_FSM  RX_FSM(
               //  input ports
               .clk156(clk156),
               .rstb156(rstb156),
               .lpbk(lpbk),
               .clear_errblk(clear_errblk),
               .hi_ber(hi_ber),
               .blk_lock(blk_lock),
               .bypass_66decoder(bypass_66decoder),
               .rx_data(rx_data[63:0]),
               .rx_control(rx_control[7:0]),
               .R_TYPE(R_TYPE[2:0]),
               .DeScr_RXD(DeScr_RXD[65:2]),
               //  output ports
               .errd_blks(errd_blks[7:0]),
               .rxcontrol(rxcontrol[7:0]),
               .rxdata(rxdata[63:0]),
               .rxlf(rxlf)
               );


endmodule // Decode
