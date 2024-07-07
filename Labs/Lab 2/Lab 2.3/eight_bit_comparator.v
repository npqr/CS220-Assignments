`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:10 01/24/2024 
// Design Name: 
// Module Name:    eight_bit_comparator 
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
module eight_bit_comparator(pb1, pb2, pb3, pb4, Y, l, g, e
    );
	 input pb1;
	 input pb2;
	 input pb3;
	 input pb4;
	 input [3:0]Y;
	 output l;
	 output g;
	 output e;
	 wire l0,l1,l2,l3,l4,l5,l6;
	 wire g0,g1,g2,g3,g4,g5,g6;
	 wire e0,e1,e2,e3,e4,e5,e6; 
	 reg [7:0]A;
	 reg [7:0]B;
	 wire l;
	 wire g;
	 wire e;
	 
	always @(posedge pb1) begin
		A[3:0] <= Y;
	end
	always @(posedge pb2) begin
		A[7:4] <= Y;
	end
	
	always @(posedge pb3) begin
		B[3:0] <= Y;
	end
	always @(posedge pb4) begin
		B[7:4] <= Y;
	end
	 
	 comparator C0(A[7], B[7], 1'b0, 1'b0, 1'b1, l0, g0, e0);
	 comparator C1(A[6], B[6], l0, g0, e0, l1, g1, e1);
	 comparator C2(A[5], B[5], l1, g1, e1, l2, g2, e2);
	 comparator C3(A[4], B[4], l2, g2, e2, l3, g3, e3);
	 comparator C4(A[3], B[3], l3, g3, e3, l4, g4, e4);
	 comparator C5(A[2], B[2], l4, g4, e4, l5, g5, e5);
	 comparator C6(A[1], B[1], l5, g5, e5, l6, g6, e6);
	 comparator C7(A[0], B[0], l6, g6, e6, l, g, e);
	 
	

endmodule