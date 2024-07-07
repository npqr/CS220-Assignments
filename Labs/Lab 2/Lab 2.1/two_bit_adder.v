`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:10 01/24/2024 
// Design Name: 
// Module Name:    two_bit_adder 
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
module two_bit_adder(x,y,z,carry
    );
input [1:0] x;
input [1:0] y;
output [1:0] z;
wire [1:0] z;
output carry;
wire carry;
wire carry0;
full_adder_1 FA0 (x[0], y[0], 1'b0, z[0], carry0);
full_adder_1 FA1 (x[1], y[1], carry0, z[1], carry);


endmodule
