`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2016 01:37:28 PM
// Design Name: 
// Module Name: led_driver
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


module led_driver(
    input has_link,
    input on_frame_sent,
    input on_frame_received,
    output [1:0] led,
    input blink,
    input clk
    );

reg frame_sent = 1'b0;
reg frame_received = 1'b0;
reg lastblink = 1'b0;

reg blinkoff_tx = 1'b0;
reg blinkoff_rx = 1'b0;

always @(posedge clk)
begin
  if (on_frame_sent) frame_sent <= 1'b1;
  if (on_frame_received) frame_received <= 1'b1;
  lastblink <= blink;
  
  if (blink & !lastblink)
  begin
    if (frame_sent) blinkoff_tx <= 1'b1;
    if (frame_received) blinkoff_rx <= 1'b1;
    frame_sent <= 1'b0;
    frame_received <= 1'b0;
  end
  if (!blink & lastblink)
  begin
    blinkoff_tx <= 1'b0;
    blinkoff_rx <= 1'b0;
  end
  

end

assign led[0] = has_link & !blinkoff_tx;
assign led[1] = has_link;


    
endmodule
