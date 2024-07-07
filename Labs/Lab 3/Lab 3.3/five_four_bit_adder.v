`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:47 01/31/2024 
// Design Name: 
// Module Name:    five_four_bit_adder 
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
module five_four_bit_adder(pb1,pb2,pb3,pb4,pb5,y,sum,carry
    );
	 input pb1,pb2,pb3,pb4,pb5;
	 input [3:0] y;
	 output [5:0] sum;
	 output carry;
	 wire [5:0] sum;
	 wire carry;
	 
	 reg [3:0] a,b,c,d;
	 reg[5:0] e;
	 
	 always @(posedge pb1) begin
	 a <= y;
	 end
	 always @(posedge pb2) begin
	 b <= y;
	 end
	 always @(posedge pb3) begin
	 c <= y;
	 end
	 always @(posedge pb4) begin
	 d <= y;
	 end
	 always @(posedge pb5) begin
	 e[3:0] <= y;
	 e[4] <=0 ;
	 e[5] <=0;
	 end
	 wire [4:0] sum1;
	 wire [4:0] sum2;
	 four_bit_adder FA0(a,b, sum1[3:0], sum1[4]);
	 four_bit_adder FA1(c,d, sum2[3:0], sum2[4]);
	 
	 wire [5:0] sum3;
	 five_bit_adder FA2(sum1,sum2, sum3[4:0], sum3[5]);
    
    six_bit_adder FA3(sum3,e,sum,carry);	 


	 


endmodule
