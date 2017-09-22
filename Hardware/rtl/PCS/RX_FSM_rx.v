//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: RX_FSM.v
//
//
// Start of Coding Date: MON May 14 2001 ( 1:00 pm)
//
// File Name : RX_FSM.v
//
// Description: This file has the code for the Receive State Machine it is
//              part of the decoding function
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
// $Log: RX_FSM.v,v $
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

module  RX_FSM_rx (clk156, rstb156, errd_blks, lpbk, clear_errblk,  hi_ber,
                blk_lock, bypass_66decoder, rx_data, rx_control, rxcontrol,
                rxdata, R_TYPE, DeScr_RXD, rxlf, terminate_in, terminate_out);

    input clk156 ; wire clk156 ;
    input rstb156 ; wire rstb156 ;
    input [63:0] DeScr_RXD; wire [63:0] DeScr_RXD;
    input        clear_errblk; wire clear_errblk;
    input        hi_ber ; wire hi_ber ;
    input        blk_lock ; wire blk_lock ;
    input        bypass_66decoder ; wire bypass_66decoder ;
    input [63:0] rx_data ; wire [63:0] rx_data ;
    input [7:0]  rx_control ; wire [7:0] rx_control ;
    input [2:0]  R_TYPE ; wire [2:0] R_TYPE ;
    input        lpbk; wire lpbk;
    input        terminate_in; wire terminate_in;

    output       rxlf; reg rxlf;
    output [7:0] rxcontrol ; reg [7:0] rxcontrol ;
    output [63:0] rxdata ; reg [63:0] rxdata ;
    output [7:0]  errd_blks; reg [7:0] errd_blks;
    output        terminate_out; reg terminate_out;


    reg [2:0]     Current_state, Next_state;
    reg [63:0]    Code, next_Code;
    reg [7:0]     Control, next_control;
    reg [2:0]     TYPE, next_TYPE;

// Detect Local Fault
always @(posedge clk156 or negedge rstb156)
    if (!rstb156)
        rxlf <= 1'b0;
    else if (Current_state == `RX_INIT)
        rxlf <= 1'b1;
    else
        rxlf <= 1'b0;

always @(posedge clk156 or negedge rstb156)
    if (!rstb156) begin
        Current_state <= `RX_INIT;
        TYPE <= `C;
        Code <= {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
        Control <= 8'hff;
        next_TYPE <= `C;
        next_Code <= {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
        next_control <= 8'hff;
        rxdata <= `LBLOCK_R;
        rxcontrol <= 8'h11;
        terminate_out <= 1'b0;
    end
    else if (hi_ber && !lpbk) begin
        Current_state <= `RX_INIT;
        TYPE <= `C;
        Code <= {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
        Control <= 8'hff;
        next_TYPE <= `C;
        next_Code <= {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
        next_control <= 8'hff;

        rxdata <= `LBLOCK_R;
        rxcontrol <= 8'h11;
    end
    else if (!blk_lock && !lpbk) begin
        Current_state <= `RX_INIT;
        TYPE <= `C;
        Code <= {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
        Control <= 8'hff;
        next_TYPE <= `C;
        next_Code <= {`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle,`XGMII_idle};
        next_control <= 8'hff;

        rxdata <= `LBLOCK_R;
        rxcontrol <= 8'h11;
    end
    else if (!bypass_66decoder) begin
        TYPE <= next_TYPE;
        Code <= next_Code;
        Control <= next_control;
        next_TYPE <= R_TYPE ;
        next_Code <= rx_data;
        next_control <= rx_control;
        if (Next_state == `RX_E) begin
            rxdata <= `EBLOCK_R;
            rxcontrol <= 8'hff;
        end
        else begin
            rxdata <= Code;
            rxcontrol <= Control;
        end
        Current_state <= Next_state;
    end
    else begin
        rxdata <= DeScr_RXD[63:0];
        rxcontrol <= 8'h00;
    end

always@(posedge clk156 or negedge rstb156) //jg changed to posedge clk 7/17/02
    if (!rstb156)
        errd_blks <= 8'h0;
    else if ((!bypass_66decoder) && (!hi_ber || lpbk) && (blk_lock || lpbk)) begin
        if (!clear_errblk) begin
            if  ((Next_state == `RX_E) && (errd_blks != 8'hff))
                errd_blks <= errd_blks + 1;
        end
        else
            errd_blks <= 8'h0;
    end

// Rise terminate flag for others FSMs
always @(TYPE or rstb156) begin
  if (!rstb156)
    terminate_out <= 1'b0;
  else
    if (TYPE == `T)
      terminate_out <= 1'b1;
    else
      terminate_out <= 1'b0;
end

// always @(Current_state or Code or Control or TYPE or next_TYPE or posedge terminate_in)
always @(Current_state or Code or Control or TYPE or next_TYPE or terminate_in)
    case (Current_state)
        `RX_INIT: begin
            if (TYPE == `S || TYPE == `D)
                Next_state = `RX_D;
            else
                if (TYPE == `C)
                    Next_state = `RX_C;
                else
                    Next_state = `RX_E;
        end
        `RX_C: begin
            if (terminate_in == 1'b1)
              Next_state = `RX_INIT;
            else
                if (TYPE == `S || TYPE == `D)
                    Next_state = `RX_D;
                else
                    if (TYPE == `C)
                        Next_state = `RX_C;
                    else
                        Next_state = `RX_E;
        end
        `RX_D: begin
            if (terminate_in == 1'b1)
                Next_state = `RX_INIT;
            else
              if (TYPE == `T)
                  Next_state = `RX_T;
              else
                if(TYPE == `D)
                    Next_state = `RX_D;
                else
                    Next_state = `RX_E;
        end
        `RX_T: begin
            if (TYPE == `C)
                Next_state = `RX_C;
            else
                if (TYPE == `S)
                    Next_state = `RX_D;
                else
                    Next_state = `RX_T;
        end
        `RX_E: begin
            if (terminate_in == 1'b1)
                Next_state = `RX_INIT;
            else
                if (TYPE == `D || TYPE == `S )
                    Next_state = `RX_D;
                else
                    if (TYPE == `C)
                        Next_state = `RX_C;
                    else
                        if (TYPE == `T)
                            Next_state = `RX_T;
                        else
                            Next_state = `RX_E;
        end
        default: Next_state = `RX_INIT;
    endcase

endmodule // RX_FSM
