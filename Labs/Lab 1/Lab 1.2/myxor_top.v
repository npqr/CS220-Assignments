// Verilog test fixture created from schematic /users/btech/anaswarkb/Desktop/full_adder_schematic/fuller_adder_sch.sch - Wed Jan 17 16:23:09 2024

`timescale 1ns / 1ps

module fuller_adder_sch_fuller_adder_sch_sch_tb();

// Inputs
   reg a;
   reg cin;
   reg b;

// Output
   wire sum;
   wire cout;

// Bidirs

// Instantiate the UUT
   fuller_adder_sch UUT (
		.a(a), 
		.cin(cin), 
		.b(b), 
		.sum(sum), 
		.cout(cout)
   );
// Initialize Inputs
   always @(sum or cout) begin
	 $display("time=%d: %b + %b + %b = %b, cout = %b\n", $time, a, b, cin, sum, cout);
	end 
	
	initial begin 
	 a=0; b=0; cin=0;
	 #5
	 a=0; b=1; cin=0;
	 #5
	 a=1; b=0; cin=1;
	 #5
	 a=1; b=1; cin=1;
	 #5
	 $finish;
	 end
endmodule
