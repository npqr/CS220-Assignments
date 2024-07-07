`timescale 1ns / 1ps
`define SHIFT_TIME 50000000
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: us
// 
// Create Date:    14:11:44 01/31/2024 
// Design Name: 
// Module Name:    rippling_led 
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
module rippling_led(clk,led0,led1,led2,led3,led4,led5,led6,led7
    );
input clk;
output led0,led1,led2,led3,led4,led5,led6,led7;
reg [31:0] cnt;
reg led0;
reg led1;
reg led2;
reg led3;
reg led4;
reg led5;
reg led6;
reg led7;


initial begin
cnt<=32'b0;
led0<=1;
led1<=0;
led2<=0;
led3<=0;
led4<=0;
led5<=0;
led6<=0;
led7<=0;
end

always @(posedge clk) begin
  cnt <= cnt+1;
  #1
  if(cnt==`SHIFT_TIME) begin
	
	led1 <= led0;
	led2 <= led1;
	led3 <= led2;
	led4 <= led3; 
	led5 <= led4;
	led6 <= led5;
	led7 <= led6;
	led0 <= led7;
	cnt<=0;
	
	end
  
end

	


endmodule