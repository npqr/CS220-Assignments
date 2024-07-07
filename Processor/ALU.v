module ALU (
    input [31:0] A,
    input [31:0] B,
    input [5:0] ALU_CTRL,
    output reg [31:0] ALU_OUT,
    output reg Z
);

always @(*) begin
    case (ALU_CTRL)
        6'b100000: ALU_OUT = A + B;      // ADD
        6'b100001: ALU_OUT = A + B;      // ADDU
        6'b100010: ALU_OUT = A - B;      // SUB
        6'b100011: ALU_OUT = A - B;      // SUBU
        6'b100100: ALU_OUT = A & B;      // AND
        6'b100101: ALU_OUT = A | B;      // OR
        6'b100110: ALU_OUT = A ^ B;      // XOR
        6'b100111: ALU_OUT = ~(A | B);   // NOR
        6'b101010: ALU_OUT = (A < B) ? 1 : 0;  // SLT
        6'b101011: ALU_OUT = (A < B) ? 1 : 0;  // SLTU
        6'b000000: ALU_OUT = B << A;     // SLL
        6'b000010: ALU_OUT = B >> A;     // SRL
        6'b000011: ALU_OUT = $signed(B) >>> A; // SRA
        6'b011000: ALU_OUT = A * B;      // MUL
        6'b011010: ALU_OUT = A / B;      // DIV
        6'b101100: ALU_OUT = (A < $signed(B)) ? 1 : 0;  // SLTI
        6'b101101: ALU_OUT = (A < $unsigned(B)) ? 1 : 0; // SLTIU
        default: ALU_OUT = 32'b0;
    endcase
    
    Z = (ALU_OUT == 32'b0) ? 1 : 0;
end

endmodule
