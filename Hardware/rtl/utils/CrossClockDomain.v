`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2016 03:27:29 PM
// Design Name: 
// Module Name: CrossClockDomain
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

module CrossClockDomain(
    input clkA,   // we actually don't need clkA in that example, but it is here for completeness as we'll need it in further examples
    input SignalIn_clkA,
    input clkB,
    output SignalOut_clkB
);

// We use a two-stages shift-register to synchronize SignalIn_clkA to the clkB clock domain
reg [2:0] SyncA_clkB;
always @(posedge clkA) SyncA_clkB[0] <= SignalIn_clkA;   // notice that we use clkB
always @(posedge clkB) SyncA_clkB[1] <= SyncA_clkB[0];   // notice that we use clkB
always @(posedge clkB) SyncA_clkB[2] <= SyncA_clkB[1];   // notice that we use clkB

assign SignalOut_clkB = SyncA_clkB[2];  // new signal synchronized to (=ready to be used in) clkB domain
endmodule