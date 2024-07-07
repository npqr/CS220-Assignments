`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:12 01/24/2024 
// Design Name: 
// Module Name:    comparator 
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

module comparator( a,b,lf, gf, ef, l, g, e
);
	input a;
	input b;
	input lf;
	input gf;
	input ef;

	output l;
	wire l;
	output e;
	wire e;
	output g;
	wire g;
	assign l = ((((~a)&b)&(ef))|lf)&(~gf);
	assign e = (a&b | (~a)&(~b))&(~lf)&(~gf);
	assign g = (((a&(~b))&(ef))|gf)&(~lf);

endmodule