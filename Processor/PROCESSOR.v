`include "ALU.v"
`include "DATA_MEM.v"
`include "INSTR_MEM.v"

module PROCESSOR(
    input clk,
    input WRITE_MF,
    output reg [31:0] reg0,
    output reg [31:0] reg1,
    output reg [31:0] reg2,
    output reg [31:0] reg3,
    output reg [31:0] reg4,
    output reg [31:0] reg5,
    output reg [31:0] reg6,
    output reg [31:0] reg7,
    output reg [31:0] reg8,
    output reg [31:0] reg9,
    output reg [31:0] reg10,
    output reg [31:0] reg11,
    output reg [31:0] reg12,
    output reg [31:0] reg13,
    output reg [31:0] reg14,
    output reg [31:0] reg15,
    output reg [31:0] reg16,
    output reg [31:0] reg17,
    output reg [31:0] reg18,
    output reg [31:0] reg19,
    output reg [31:0] reg20,
    output reg [31:0] reg21,
    output reg [31:0] reg22,
    output reg [31:0] reg23,
    output reg [31:0] reg24,
    output reg [31:0] reg25,
    output reg [31:0] reg26,
    output reg [31:0] reg27,
    output reg [31:0] reg28,
    output reg [31:0] reg29,
    output reg [31:0] reg30,
    output reg [31:0] reg31,
    output reg instruction_executed 
);
    reg [31:0] GPR [31:0] ;
    reg [4:0] PC ;
    wire [31:0] IR ;

    reg [31:0] ALU_IN ;
    reg [31:0] ALU_IN2 ;
    wire [31:0] ALU_OUT ;
    reg [5:0] ALU_CTRL ;

    reg [31:0] MEM_ADDR ;
    reg [31:0] MEM_WDATA ;
    reg MEM_WEN ;
    reg MEM_REN ;
    wire [31:0] MEM_RDATA ;
    reg [3:0] state ;

    ALU ALU1(
        .A(ALU_IN),
        .B(ALU_IN2),
        .ALU_CTRL(ALU_CTRL),
        .ALU_OUT(ALU_OUT)
    );
    
    DATA_MEM DATA_MEM1(
        .clk(clk),
        .MEM_ADDR(MEM_ADDR),
        .MEM_WDATA(MEM_WDATA),
        .MEM_WEN(MEM_WEN),
        .MEM_REN(MEM_REN),
        .WRITE_MF(WRITE_MF),
        .MEM_RDATA(MEM_RDATA)
    );

    INSTR_MEM INSTR_MEM1(
        .PC(PC),
        .IR(IR)
    );

    initial begin
        ALU_IN = 32'b0 ;
        ALU_IN2 = 32'b0 ;
        ALU_CTRL = 6'b0 ;
        MEM_ADDR = 32'b0 ;
        MEM_WDATA = 32'b0 ;
        MEM_WEN = 1'b0 ;
        MEM_REN = 1'b0 ;
        PC = 5'b0 ;
        GPR[0] = 32'b0 ; 
        GPR[1] = 32'b0 ;
        GPR[2] = 32'b0 ;
        GPR[3] = 32'b0 ;
        GPR[4] = 32'b0 ;
        GPR[5] = 32'b0 ;
        GPR[6] = 32'b0 ;
        GPR[7] = 32'b0 ;
        GPR[8] = 32'b0 ;
        GPR[9] = 32'b0 ;
        GPR[10] = 32'b0 ;
        GPR[11] = 32'b0 ;
        GPR[12] = 32'b0 ;
        GPR[13] = 32'b0 ;
        GPR[14] = 32'b0 ;
        GPR[15] = 32'b0 ;
        GPR[16] = 32'b0 ;
        GPR[17] = 32'b0 ;
        GPR[18] = 32'b0 ;
        GPR[19] = 32'b0 ;
        GPR[20] = 32'b0 ;
        GPR[21] = 32'b0 ;
        GPR[22] = 32'b0 ;
        GPR[23] = 32'b0 ;
        GPR[24] = 32'b0 ;
        GPR[25] = 32'b0 ;
        GPR[26] = 32'b0 ;
        GPR[27] = 32'b0 ;
        GPR[28] = 32'b0 ;
        GPR[29] = 32'b0 ;
        GPR[30] = 32'b0 ;
        GPR[31] = 32'b0 ;  
        state = 0 ;  
    end

    always @(posedge clk) begin

        case( IR[31:26] )

            6'b000000: begin // R-Type
                if( IR[5:0] == 6'b001000 ) begin // JR
                    PC = GPR[IR[25:21]] ;
                    state = 0 ;
                end 
                
                else if( IR[5:0] == 6'b001001 ) begin // JALR
                    if( state == 0 ) begin
                        GPR[IR[15:11]] = PC ;
                        state = 1 ;
                    end else begin
                        PC = GPR[IR[25:21]] ;
                        state = 0 ;
                    end                    
                end 
                
                else begin
                    if( state == 0 ) begin
                        ALU_IN = GPR[IR[25:21]] ;
                        ALU_IN2 = GPR[IR[20:16]] ;
                        ALU_CTRL = IR[5:0] ;
                        state = 1 ;
                    end
                    else if( state == 1 ) begin
                        GPR[IR[15:11]] = ALU_OUT ;
                        state = 0 ;
                        PC = PC + 1 ;
                    end
                end
            end

            6'b001000: begin // ADDI
                if( state == 0 ) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b100000 ;
                    state = 1 ;
                end
                else if( state == 1 ) begin
                    GPR[IR[20:16]] = ALU_OUT ;
                    state = 0 ;
                    PC = PC + 1 ;
                end
            end

            6'b001001: begin // ADDIU
                if( state == 0 ) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b100001 ;
                    state = 1 ;
                end
                else if( state == 1 ) begin
                    GPR[IR[20:16]] = ALU_OUT ;
                    state = 0 ;
                    PC = PC + 1 ;
                end
            end

            6'b001100: begin // ANDI
                if( state == 0 ) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b100100 ;
                    state = 1 ;
                end
                else if( state == 1 ) begin
                    GPR[IR[20:16]] = ALU_OUT ;
                    state = 0 ;
                    PC = PC + 1 ;
                end
            end

            6'b001101: begin // ORI
                if( state == 0 ) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b100101 ;
                    state = 1 ;
                end
                else if( state == 1 ) begin
                    GPR[IR[20:16]] = ALU_OUT ;
                    state = 0 ;
                    PC = PC + 1 ;
                end
            end

            6'b001010: begin // SLTI
                if( state == 0 ) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b101010 ;
                    state = 1 ;
                end
                else if( state == 1 ) begin
                    GPR[IR[20:16]] = ALU_OUT ;
                    state = 0 ;
                    PC = PC + 1 ;
                end
            end

            6'b001011: begin // SLTIU
                if( state == 0 ) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b101011 ;
                    state = 1 ;
                end
                else if( state == 1 ) begin
                    GPR[IR[20:16]] = ALU_OUT ;
                    state = 0 ;
                    PC = PC + 1 ;
                end
            end

            6'b001110: begin // XORI
                if( state == 0 ) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b100110 ;
                    state = 1 ;
                end
                else if( state == 1 ) begin
                    GPR[IR[20:16]] = ALU_OUT ;
                    state = 0 ;
                    PC = PC + 1 ;
                end
            end

            6'b000100: begin // BEQ
                if( GPR[IR[25:21]] == GPR[IR[20:16]] ) begin
                    PC = PC + IR[15:0] ;
                end
                else begin
                    PC = PC + 1 ;
                end
            end

            6'b000001: begin // BGEZ or BLTZ
                if( IR[20] == 1 ) begin
                    if( GPR[IR[25:21]] >= 0 ) begin
                        PC = PC + IR[15:0] ;
                    end
                    else begin
                        PC = PC + 1 ;
                    end
                end
                else begin
                    if( GPR[IR[25:21]] < 0 ) begin
                        PC = PC + IR[15:0] ;
                    end
                    else begin
                        PC = PC + 1 ;
                    end
                end
            end

            6'b000111: begin // BGTZ
                if( GPR[IR[25:21]] > 0 ) begin
                    PC = PC + IR[15:0] ;
                end
                else begin
                    PC = PC + 1 ;
                end
            end

            6'b000110: begin // BLEZ
                if( GPR[IR[25:21]] <= 0 ) begin
                    PC = PC + IR[15:0] ;
                end
                else begin
                    PC = PC + 1 ;
                end
            end

            6'b000101: begin // BNE
                if( GPR[IR[25:21]] != GPR[IR[20:16]] ) begin
                    PC = PC + IR[15:0] ;
                end
                else begin
                    PC = PC + 1 ;
                end
            end

            6'b000010: begin // J
                PC = PC + IR[25:0] ;
            end

            6'b000011: begin // JAL
                if( state == 0 ) begin
                    GPR[31] = PC ;
                    state = 1 ;
                end else begin
                    PC = PC + IR[25:0] ;
                    state = 0 ;
                end
            end       

            6'b100011: begin // LW
                if (state == 0) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b100000 ;
                    state = 1 ;
                end
                else if (state == 1) begin
                    MEM_ADDR = ALU_OUT ;
                    MEM_REN = 1'b1 ;
                    state = 2 ;
                end
                else if (state == 2) begin
                    state = 3 ;
                end
                else if (state == 3) begin
                    GPR[IR[20:16]] = MEM_RDATA ;
                    MEM_REN = 1'b0 ;
                    state = 0 ;
                    PC = PC + 1 ;
                end
            end

            6'b101011: begin // SW
                if (state == 0) begin
                    ALU_IN = GPR[IR[25:21]] ;
                    ALU_IN2 = IR[15:0] ;
                    ALU_CTRL = 6'b100000 ;
                    state = 1 ;
                end
                else if (state == 1) begin
                    MEM_ADDR = ALU_OUT ;
                    MEM_WDATA = GPR[IR[20:16]] ;
                    MEM_WEN = 1'b1 ;
                    state = 2 ;
                end
                else if (state == 2) begin
                    state = 3 ;
                end
                else if (state == 3) begin
                    MEM_WEN = 1'b0 ;
                    PC = PC + 1 ;
                    state = 0 ;
                end
            end
        endcase

        instruction_executed <= 1;
        reg0 <= GPR[0];
        reg1 <= GPR[1];
        reg2 <= GPR[2];
        reg3 <= GPR[3];
        reg4 <= GPR[4];
        reg5 <= GPR[5];
        reg6 <= GPR[6];
        reg7 <= GPR[7];
        reg8 <= GPR[8];
        reg9 <= GPR[9];
        reg10 <= GPR[10];
        reg11 <= GPR[11];
        reg12 <= GPR[12];
        reg13 <= GPR[13];
        reg14 <= GPR[14];
        reg15 <= GPR[15];
        reg16 <= GPR[16];
        reg17 <= GPR[17];
        reg18 <= GPR[18];
        reg19 <= GPR[19];
        reg20 <= GPR[20];
        reg21 <= GPR[21];
        reg22 <= GPR[22];
        reg23 <= GPR[23];
        reg24 <= GPR[24];
        reg25 <= GPR[25];
        reg26 <= GPR[26];
        reg27 <= GPR[27];
        reg28 <= GPR[28];
        reg29 <= GPR[29];
        reg30 <= GPR[30];
        reg31 <= GPR[31];

        #10;

        instruction_executed <= 0;
    end

endmodule