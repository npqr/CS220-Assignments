`timescale 1ns / 1ps
`define OFF_TIME 25000000
`define ON_TIME (`OFF_TIME*2)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: us
// 
// Create Date:    14:11:44 01/31/2024 
// Design Name: 
// Module Name:    blinking_led 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module blinking_led(clk,led0
    );
input clk;
output led0;
reg [31:0] cnt;
reg led0;

initial begin
cnt<=32'b0;
led0<=0;
end

always @(posedge clk) begin
  cnt <= cnt+1;
  #1
  if(cnt==`OFF_TIME) begin
	led0 <= 0;
	end
  if(cnt==`ON_TIME) begin
	led0 <= 1;
	cnt<=32'b0;
	end
end

	


endmodule
