`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2016 01:37:28 PM
// Design Name: 
// Module Name: blink_driver
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blink_driver #(

    parameter REG_SIZE = 25
    
    //200 MHz / 2^25 = 5,96 Hz > Blink frequency

 )(
    input clk,
    output blink,
    input reset
);
    
reg[REG_SIZE-1:0] c = 0;

always @(posedge clk) c <= reset?0:c+1;

assign blink = c[REG_SIZE-1];



    
endmodule