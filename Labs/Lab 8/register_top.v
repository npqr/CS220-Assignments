`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:03 03/20/2024 
// Design Name: 
// Module Name:    register_top 
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
module register_top(clk, inp, PB1, PB2, ROT_A, ROT_B, LCD_E,LCD_RS, LCD_W, val);

input clk, ROT_A, ROT_B, PB1, PB2;
input [3:0] inp;

output wire LCD_E, LCD_RS, LCD_W;
output [3:0] val; //data for the lcd display

reg [2:0] cmd;
reg [3:0] count;
reg prev_rot_event;
wire rot_event;

reg [4:0] read_addr1;
reg [4:0] read_addr2;
reg [4:0] write_addr;

reg [15:0] write_data;
wire [15:0] write_data_bus;
wire [15:0] bus1;
wire [15:0] bus2;

reg [15:0] reg_file [0:31];
reg [7:0] ascii[0:9];
reg [0:127] first_line;
reg [0:127] second_line;
reg display_start;
wire display_end;
reg input_done;

// wire [15:0] add;
// wire [15:0] sub;
// wire [15:0] shift;

wire [15:0] compare_val;
wire [15:0] xor_val;
wire [15:0] shift_val;

reg [3:0] bit_shift;
reg flag=1;

initial begin
	prev_rot_event = 0;
	count=0;
	display_start=0;
	//input_done=0;
	//display_end=0;
	ascii[0] = 8'd48; //ascii values for the numbers
	ascii[1] = 8'd49;
	ascii[2] = 8'd50;
	ascii[3] = 8'd51;
	ascii[4] = 8'd52;
	ascii[5] = 8'd53;
	ascii[6] = 8'd54;
	ascii[7] = 8'd55;
	ascii[8] = 8'd56;
	ascii[9] = 8'd57;
end

initial begin
	reg_file[0] = 16'd0;
	reg_file[1] = 16'd0;
	reg_file[2] = 16'd0;
	reg_file[3] = 16'd0;
	reg_file[4] = 16'd0;
	reg_file[5] = 16'd0;
	reg_file[6] = 16'd0;
	reg_file[7] = 16'd0;
	reg_file[8] = 16'd0;
	reg_file[9] = 16'd0;
	reg_file[10] = 16'd0;
	reg_file[11] = 16'd0;
	reg_file[12] = 16'd0;
	reg_file[13] = 16'd0;
	reg_file[14] = 16'd0;
	reg_file[15] = 16'd0;
	reg_file[16] = 16'd0;
	reg_file[17] = 16'd0;
	reg_file[18] = 16'd0;
	reg_file[19] = 16'd0;
	reg_file[20] = 16'd0;
	reg_file[21] = 16'd0;
	reg_file[22] = 16'd0;
	reg_file[23] = 16'd0;
	reg_file[24] = 16'd0;
	reg_file[25] = 16'd0;
	reg_file[26] = 16'd0;
	reg_file[27] = 16'd0;
	reg_file[28] = 16'd0;
	reg_file[29] = 16'd0;
	reg_file[30] = 16'd0;
	reg_file[31] = 16'd0;
end

assign bus1[15:0] = reg_file[read_addr1];
assign bus2[15:0] = reg_file[read_addr2];
assign write_data_bus = write_data;

// assign add = reg_file[read_addr2] + reg_file[read_addr1];
// assign sub = reg_file[read_addr2] - reg_file[read_addr1];
// assign shift = reg_file[read_addr1] >> bit_shift; // shift right arithmetic

assign compare_val = ($signed(reg_file[read_addr2]) > $signed(reg_file[read_addr1])) ? 1 : 0;
assign xor_val = reg_file[read_addr2] ^ reg_file[read_addr1];
assign shift_val = $signed(reg_file[read_addr1]) >> bit_shift;


rotatory_shaft rot(clk, ROT_A, ROT_B, rot_event);
lcd display(first_line , second_line , display_start, clk , LCD_RS , LCD_W , LCD_E , val[0], val[1], val[2], val[3], display_end);

always @(posedge PB1) begin
	cmd[2:0]=inp[2:0];
end

always@(posedge PB2) begin
	//input_done = 0;
	flag = ~flag;
	//count = 0;
end

always @(posedge clk) begin
	prev_rot_event <= rot_event;
	if (display_end == 1) begin
			count = 0;
			// input_done = 0;
			display_start = 0;
	end
	if(flag==0) begin
		count=0;
	end
	if(prev_rot_event == 0 && rot_event == 1 && flag==1) begin
		if(cmd==0) begin
			if(count==0) begin
				//write_addr[4:1]<=inp[3:0];
				count=1;
			end
			else if(count==1) begin
				write_addr[4:1]<=inp[3:0];
				count=2;
			end

			else if(count==2) begin
				write_addr[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin
				write_data[15:12]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				write_data[11:8]<=inp[3:0];
				count=5;
			end
			else if(count==5) begin
				write_data[7:4]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin
				write_data[3:0]<=inp[3:0];
				input_done = 1;
				count=7;
			end
			else if(count==7) begin
				reg_file[write_addr]<=write_data;
				count=8;
			end
			else if (count==8) begin
				first_line <= {ascii[write_addr[4]], ascii[write_addr[3]], ascii[write_addr[2]], ascii[write_addr[1]], ascii[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ascii[write_data[15]], ascii[write_data[14]], ascii[write_data[13]],ascii[write_data[12]], ascii[write_data[11]], ascii[write_data[10]], ascii[write_data[9]], ascii[write_data[8]],ascii[write_data[7]], ascii[write_data[6]], ascii[write_data[5]], ascii[write_data[4]], ascii[write_data[3]], ascii[write_data[2]], ascii[write_data[1]], ascii[write_data[0]]};
				//input_done = 0;
				display_start=1;
				//count=0;
			end
			// count<=count+1;
		end
		
		else if(cmd==1) begin
			if(count==0) begin        
				//read_addr1[4:1]<=inp[3:0];
				count=1;
			end
			else if(count==1) begin
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end

			else if(count==2) begin
				read_addr1[0]<=inp[0];
				input_done = 1;
				count=3;
			end
			else if(count==3 && input_done==1) begin
				first_line <= {ascii[read_addr1[4]], ascii[read_addr1[3]], ascii[read_addr1[2]], ascii[read_addr1[1]], ascii[read_addr1[0]],  8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				/*second_line <= {ascii[reg_file[read_addr1][15]], ascii[reg_file[read_addr1][14]], ascii[reg_file[read_addr1][13]],ascii[reg_file[read_addr1][12]], ascii[reg_file[read_addr1][11]], ascii[reg_file[read_addr1][10]], ascii[reg_file[read_addr1][9]], ascii[reg_file[read_addr1][8]], 
									ascii[reg_file[read_addr1][7]], ascii[reg_file[read_addr1][6]], ascii[reg_file[read_addr1][5]], ascii[reg_file[read_addr1][4]], ascii[reg_file[read_addr1][3]], ascii[reg_file[read_addr1][2]], ascii[reg_file[read_addr1][1]], ascii[reg_file[read_addr1][0]]};*/
				second_line <= {ascii[bus1[15]], ascii[bus1[14]], ascii[bus1[13]],ascii[bus1[12]], ascii[bus1[11]], ascii[bus1[10]], ascii[bus1[9]], ascii[bus1[8]], 
									ascii[bus1[7]], ascii[bus1[6]], ascii[bus1[5]], ascii[bus1[4]], ascii[bus1[3]], ascii[bus1[2]], ascii[bus1[1]], ascii[bus1[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
		end
		
		else if(cmd==2) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin
				read_addr2[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				read_addr2[0]<=inp[0];
				input_done = 1;
				count=5;
			end
			else if(count==5 && input_done==1) begin
				first_line <= {ascii[bus1[15]], ascii[bus1[14]], ascii[bus1[13]],ascii[bus1[12]], ascii[bus1[11]], ascii[bus1[10]], ascii[bus1[9]], ascii[bus1[8]], 
									ascii[bus1[7]], ascii[bus1[6]], ascii[bus1[5]], ascii[bus1[4]], ascii[bus1[3]], ascii[bus1[2]], ascii[bus1[1]], ascii[bus1[0]]};
				second_line <= {ascii[bus2[15]], ascii[bus2[14]], ascii[bus2[13]],ascii[bus2[12]], ascii[bus2[11]], ascii[bus2[10]], ascii[bus2[9]], ascii[bus2[8]], 
									ascii[bus2[7]], ascii[bus2[6]], ascii[bus2[5]], ascii[bus2[4]], ascii[bus2[3]], ascii[bus2[2]], ascii[bus2[1]], ascii[bus2[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
		end
		
		else if(cmd==3) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end

			else if(count==2) begin
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin
				write_addr[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				write_addr[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin
				write_data[15:12]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin
				write_data[11:8]<=inp[3:0];
				count=7;
			end
			else if(count==7) begin
				write_data[7:4]<=inp[3:0];
				count=8;
			end
			else if(count==8) begin
				write_data[3:0]<=inp[3:0];
				input_done = 1;
				count=9;
			end
			else if(count==9 && input_done==1) begin
				reg_file[write_addr]<=write_data_bus;
				
				count=10;
			end
			else if (count==10 && input_done==1) begin
				first_line <= {ascii[read_addr1[4]], ascii[read_addr1[3]], ascii[read_addr1[2]], ascii[read_addr1[1]], ascii[read_addr1[0]],  8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ascii[bus1[15]], ascii[bus1[14]], ascii[bus1[13]],ascii[bus1[12]], ascii[bus1[11]], ascii[bus1[10]], ascii[bus1[9]], ascii[bus1[8]], 
									ascii[bus1[7]], ascii[bus1[6]], ascii[bus1[5]], ascii[bus1[4]], ascii[bus1[3]], ascii[bus1[2]], ascii[bus1[1]], ascii[bus1[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			
			end
			//count<=count+1;
		end
		else if(cmd==4) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin
				read_addr2[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				read_addr2[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin
				write_addr[4:1]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=inp[0];
				count=7;
			end
			else if(count==7) begin
				write_data[15:12]<=inp[3:0];
				count=8;
			end
			else if(count==8) begin
				write_data[11:8]<=inp[3:0];
				count=9;
			end
			else if(count==9) begin
				write_data[7:4]<=inp[3:0];
				count=10;
			end
			else if(count==10) begin
				write_data[3:0]<=inp[3:0];
				input_done = 1;
				count=11;
			end

			else if(count==11 && input_done==1) begin
				reg_file[write_addr]<=write_data_bus;
				count=12;
			end
			else if (count==12 && input_done==1) begin
				first_line <= {ascii[bus1[15]], ascii[bus1[14]], ascii[bus1[13]],ascii[bus1[12]], ascii[bus1[11]], ascii[bus1[10]], ascii[bus1[9]], ascii[bus1[8]], 
									ascii[bus1[7]], ascii[bus1[6]], ascii[bus1[5]], ascii[bus1[4]], ascii[bus1[3]], ascii[bus1[2]], ascii[bus1[1]], ascii[bus1[0]]};
				second_line <= {ascii[bus2[15]], ascii[bus2[14]], ascii[bus2[13]],ascii[bus2[12]], ascii[bus2[11]], ascii[bus2[10]], ascii[bus2[9]], ascii[bus2[8]], 
									ascii[bus2[7]], ascii[bus2[6]], ascii[bus2[5]], ascii[bus2[4]], ascii[bus2[3]], ascii[bus2[2]], ascii[bus2[1]], ascii[bus2[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			
			end
			//count<=count+1;
		end
		else if(cmd==5) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin
				read_addr2[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				read_addr2[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin
				write_addr[4:1]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=inp[0];
				input_done = 1;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				reg_file[write_addr]<=compare_val;
				count=8;
			end
			else if(count==8 && input_done==1) begin
				first_line <= {ascii[write_addr[4]], ascii[write_addr[3]], ascii[write_addr[2]], ascii[write_addr[1]], ascii[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ascii[compare_val[15]], ascii[compare_val[14]], ascii[compare_val[13]],ascii[compare_val[12]], ascii[compare_val[11]], ascii[compare_val[10]], ascii[compare_val[9]], ascii[compare_val[8]],ascii[compare_val[7]], ascii[compare_val[6]], ascii[compare_val[5]], ascii[compare_val[4]], ascii[compare_val[3]], ascii[compare_val[2]], ascii[compare_val[1]], ascii[compare_val[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
			//count<=count+1;
		end
		else if(cmd==6) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin
				read_addr2[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				read_addr2[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin
				write_addr[4:1]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=inp[0];
				input_done = 1;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				reg_file[write_addr] <= xor_val;
				count=8;
			end
			else if(count==8 && input_done==1) begin
				first_line <= {ascii[write_addr[4]], ascii[write_addr[3]], ascii[write_addr[2]], ascii[write_addr[1]], ascii[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ascii[xor_val[15]], ascii[xor_val[14]], ascii[xor_val[13]],ascii[xor_val[12]], ascii[xor_val[11]], ascii[xor_val[10]], ascii[xor_val[9]], ascii[xor_val[8]],ascii[xor_val[7]], ascii[xor_val[6]], ascii[xor_val[5]], ascii[xor_val[4]], ascii[xor_val[3]], ascii[xor_val[2]], ascii[xor_val[1]], ascii[xor_val[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
			//count<=count+1;
		
		end
		else if(cmd==7) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin
				write_addr[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				write_addr[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin
				bit_shift[3:0]<=inp[3:0];
				input_done = 1;
				count=6;
			end
			else if(count==6 && input_done==1) begin
				reg_file[write_addr]<=shift_val;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				first_line <= {ascii[write_addr[4]], ascii[write_addr[3]], ascii[write_addr[2]], ascii[write_addr[1]], ascii[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ascii[shift_val[15]], ascii[shift_val[14]], ascii[shift_val[13]],ascii[shift_val[12]], ascii[shift_val[11]], ascii[shift_val[10]], ascii[shift_val[9]], ascii[shift_val[8]],ascii[shift_val[7]], ascii[shift_val[6]], ascii[shift_val[5]], ascii[shift_val[4]], ascii[shift_val[3]], ascii[shift_val[2]], ascii[shift_val[1]], ascii[shift_val[0]]};
				input_done = 0;
				display_start=1;				
				//count=0;
			end
			// count<=count+1;
		end
	end
	
end
endmodule