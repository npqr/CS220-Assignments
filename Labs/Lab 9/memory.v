`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:28 03/20/2024 
// Design Name: 
// Module Name:    memory 
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
module memory(clk, led, pb);

input wire clk;
input wire pb;
output wire [7:0] led;

reg [15:0] mem [0:7];
reg [3:0] ctr;
reg [7:0] sum;

reg flag = 0;
reg [7:0] led_val = 0;

assign led = led_val;

reg [15:0] to_enc;
wire [7:0] dec;
reg [6:0] delay = 7'b0000000;

reg prev_state = 1'b0;
reg curr_state;

initial begin
	mem[0] <= 16'b0000_0000_0000_0000;
	mem[1] <= 16'b1000_1000_0000_0001;
	mem[2] <= 16'b0000_0001_0000_0000;
	
	//mem[3] <= 16'b0000_0000_0000_0001;
	mem[3] <= 16'b1000_0000_0000_0000;
	
	//mem[4] <= 16'b0000_0000_0000_0001;
	mem[4] <= 16'b0000_0000_0000_0001;
	
	mem[5] <= 16'b0000_1000_0000_0000;
	
	mem[6] <= 16'b1000_0001_0001_0000;
	
	mem[7] <= 16'b0000_0000_1000_0000;
	
	ctr <= 4'b0000;
	sum <= 8'b00000000;
	to_enc <= 16'b0000_0000_0000_0000;
end

encoder enc(clk, to_enc, dec);

reg [7:0] counter = 8'b00000000;


always @(posedge pb) begin
	if (flag==0) begin
		led_val<=sum;
		flag <= 1;
	end
	else if (flag==1) begin
		led_val[0] <= sum[0] ^sum[1] ^ sum[2] ^sum[3] ^ sum[4] ^ sum[5]^ sum[6] ^ sum[7];
		led_val[1] <= 1'b0;
		led_val[2] <= 1'b0;
		led_val[3] <= 1'b0;
		led_val[4] <= 1'b0;
		led_val[5] <= 1'b0;
		led_val[6] <= 1'b0;
		led_val[7] <= 1'b0;
		flag <= 0;
	end
end

always @(posedge clk) begin
	if (ctr != 4'b1000 & delay == 7'b1000000) begin
		to_enc <= mem[ctr+1];
		sum <= sum + dec;
		ctr <= ctr+1;
		delay <= 0;
	end
	else begin
		delay <= delay+1;
	end
end

endmodule
