module DATA_MEM (
    input clk,
    input [31:0] MEM_ADDR,
    input [31:0] MEM_WDATA,
    input MEM_WEN,
    input MEM_REN,
    input WRITE_MF,
    output reg [31:0] MEM_RDATA
);

reg [31:0] DATA_MEM [0:31]; 

always @(posedge clk) begin
    if (MEM_WEN && WRITE_MF) begin
        DATA_MEM[MEM_ADDR] <= MEM_WDATA;
    end
    if (MEM_REN) begin
        MEM_RDATA <= DATA_MEM[MEM_ADDR];
    end
end

initial begin
    DATA_MEM[0] <= 32'b00000001;
    DATA_MEM[1] <= 32'b00000001;
    DATA_MEM[2] <= 32'b00000001;
    DATA_MEM[3] <= 32'b00000001;
    DATA_MEM[4] <= 32'b00000001;
    DATA_MEM[5] <= 32'b00000001;
    DATA_MEM[6] <= 32'b00000001;
    DATA_MEM[7] <= 32'b00000001;
    DATA_MEM[8] <= 32'b11111111;
    DATA_MEM[9] <= 32'b11111111;
    DATA_MEM[10] <= 32'b00001010;
    DATA_MEM[11] <= 32'd0;
    DATA_MEM[12] <= 32'd0;
    DATA_MEM[13] <= 32'd0;
    DATA_MEM[14] <= 32'd0;
    DATA_MEM[15] <= 32'd0;
    DATA_MEM[16] <= 32'd0;
    DATA_MEM[17] <= 32'd0;
    DATA_MEM[18] <= 32'd0;
    DATA_MEM[19] <= 32'd0;
    DATA_MEM[20] <= 32'd0;
    DATA_MEM[21] <= 32'd0;
    DATA_MEM[22] <= 32'd0;
    DATA_MEM[23] <= 32'd0;
    DATA_MEM[24] <= 32'd0;
    DATA_MEM[25] <= 32'd0;
    DATA_MEM[26] <= 32'd0;
    DATA_MEM[27] <= 32'd0;
    DATA_MEM[28] <= 32'd0;
    DATA_MEM[29] <= 32'd0;
    DATA_MEM[30] <= 32'd0;
    DATA_MEM[31] <= 32'd0;
end

endmodule
