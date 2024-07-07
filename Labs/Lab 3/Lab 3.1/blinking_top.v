`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:27:30 01/31/2024
// Design Name:   blinking_led
// Module Name:   /users/btech/anaswarkb/Desktop/blinking_led/blinking_top.v
// Project Name:  blinking_led
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: blinking_led
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module blinking_top;

	// Inputs
	reg clk;

	// Outputs
	wire led0;

	// Instantiate the Unit Under Test (UUT)
	blinking_led uut (
		.clk(clk), 
		.led0(led0)
	);
	
	
	
	initial begin
	   forever begin
		 clk=0;
		 #0.1
		 clk=1;
		 #0.1
	    clk=0;
		 end
		end

 always @(led0) begin
  $display("time=%d: led0=%b",$time,led0);
  end

	initial begin
	
     
		
		#2000000000;
       $finish;

	end
      
endmodule

