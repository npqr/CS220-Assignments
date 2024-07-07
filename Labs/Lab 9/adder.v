`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:47 03/20/2024 
// Design Name: 
// Module Name:    adder 
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
module adder(a,b,c);

input wire [7:0] a;
input wire [7:0] b;
output wire [7:0] c;

wire [7:0] carry;

full_adder fa0(a[0],b[0],1'b0,c[0],carry[0]);
full_adder fa1(a[1],b[1],carry[0],c[1],carry[1]);
full_adder fa2(a[2],b[2],carry[1],c[2],carry[2]);
full_adder fa3(a[3],b[3],carry[2],c[3],carry[3]);
full_adder fa4(a[4],b[4],carry[3],c[4],carry[4]);
full_adder fa5(a[5],b[5],carry[4],c[5],carry[5]);
full_adder fa6(a[6],b[6],carry[5],c[6],carry[6]);
full_adder fa7(a[7],b[7],carry[6],c[7],carry[7]);

endmodule
