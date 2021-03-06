//---------------- Xilinx, CTD Systems & Apps  ------------------------
//
//
// FileName: TX_FSM.v
//
//
// Start of Coding Date: SAT April 21 2001 ( 2:00 pm)
//
// File Name : TX_FSM.v
//
// Description: This file has the code for the Transmit State Machine it is
//              part of the encoding function
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
// $Log: TX_FSM.v,v $
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

module  TX_FSM (clk156 , rstb, T_TYPE, coded_vec, txdata, bypass_66encoder, TXD_encoded, txlf);
    
    input [63:0] txdata;
    input        bypass_66encoder;
    input        clk156; wire clk156;
    input        rstb; wire rstb; 
    input [65:0] coded_vec; wire [65:0] coded_vec;
    input [2:0]  T_TYPE ; wire [2:0] T_TYPE ;
    output [65:0] TXD_encoded; reg [65:0] TXD_encoded;
    output        txlf;reg txlf;
    reg [2:0]     Current_state, Next_state;
    reg [65:0]    Code;
    reg [2:0]     TYPE;



    // Detect Local Fault
    always @(posedge clk156 or negedge rstb)
        if (!rstb)
            txlf <= 1'b0;
        else if (Current_state == `TX_INIT) 
            txlf <= 1'b1;
        else
            txlf <= 1'b0;

    always @(posedge clk156 or negedge rstb)
        if (!rstb) begin
	        Current_state <= `TX_INIT;
	        TYPE <= `C;
	        Code <= {`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`PCS_idle,`Type_1,`Sync_cont};
	        TXD_encoded <= `LBLOCK_T;
        end
        else begin
	        if (!bypass_66encoder) begin
                TYPE <= T_TYPE;
                Code <= coded_vec;
                if (Next_state == `TX_E) 
	                TXD_encoded <= `EBLOCK_T;
                else 
	                TXD_encoded <= Code;
                Current_state <= Next_state;
            end
	        else
                TXD_encoded <= {txdata,`Sync_data};
        end


    always @(Current_state or TYPE or Code) begin
        case (Current_state)
	        `TX_INIT: if ((TYPE == `E) || (TYPE == `D) || (TYPE == `T))
                Next_state = `TX_E;
            else if (TYPE == `S)
	            Next_state = `TX_D;
	        else
	            Next_state = `TX_C;
	        
	        `TX_C:   if (TYPE == `C)
                Next_state = `TX_C;
            else if (TYPE == `S)
	            Next_state = `TX_D;
	        else
	            Next_state = `TX_E;
	        
	        `TX_D:   if (TYPE == `D)
                Next_state = `TX_D;
            else if (TYPE == `T)
	            Next_state = `TX_T;
	        else
	            Next_state = `TX_E;
	        `TX_T:   if (TYPE == `C)
                Next_state = `TX_C;
            else if (TYPE == `S)
	            Next_state = `TX_D;
            else
	            Next_state = `TX_E;
	        `TX_E:   if (TYPE == `D)
                Next_state = `TX_D;
            else if (TYPE == `C)
	            Next_state = `TX_C;
            else if (TYPE == `T)
	            Next_state = `TX_T;
            else
	            Next_state = `TX_E;
	        default:   
	            Next_state = `TX_INIT;   
        endcase
    end

endmodule

