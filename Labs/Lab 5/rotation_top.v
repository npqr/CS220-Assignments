`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:33:45 02/14/2024 
// Design Name: 
// Module Name:    rotaion_top 
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
module rotation_top(clk, ROT_A, ROT_B, led0, led1, led2, led3, led4, led5, led6, led7
    );
	 input clk, ROT_A, ROT_B;
	 output led0, led1, led2, led3, led4, led5, led6, led7;
	 wire led0, led1, led2, led3, led4, led5, led6, led7, rotation_event, rotation_direction;
	 
	 rotary_shaft shaft(clk, ROT_A, ROT_B,rotation_event, rotation_direction);
	 led_shift led(clk, rotation_event, rotation_direction,led0, led1, led2, led3, led4, led5, led6, led7);


endmodule