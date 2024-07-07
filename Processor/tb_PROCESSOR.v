`timescale 1ns/1ps

module tb_PROCESSOR;

    reg clk;
    reg WRITE_MF;
    wire [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9;
    wire [31:0] reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19;
    wire [31:0] reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29;
    wire [31:0] reg30, reg31;
    wire instruction_executed;

    PROCESSOR uut (
        .clk(clk),
        .WRITE_MF(WRITE_MF),
        .reg0(reg0),
        .reg1(reg1),
        .reg2(reg2),
        .reg3(reg3),
        .reg4(reg4),
        .reg5(reg5),
        .reg6(reg6),
        .reg7(reg7),
        .reg8(reg8),
        .reg9(reg9),
        .reg10(reg10),
        .reg11(reg11),
        .reg12(reg12),
        .reg13(reg13),
        .reg14(reg14),
        .reg15(reg15),
        .reg16(reg16),
        .reg17(reg17),
        .reg18(reg18),
        .reg19(reg19),
        .reg20(reg20),
        .reg21(reg21),
        .reg22(reg22),
        .reg23(reg23),
        .reg24(reg24),
        .reg25(reg25),
        .reg26(reg26),
        .reg27(reg27),
        .reg28(reg28),
        .reg29(reg29),
        .reg30(reg30),
        .reg31(reg31),
        .instruction_executed(instruction_executed)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        WRITE_MF = 0;

        #10;

        #1000;
        $stop; 
    end

    always @(posedge clk) begin
        if (instruction_executed) begin
            display_registers();
        end
    end

    task display_registers;
        begin
            $display("----- Register Values at Time %t -----", $time);
            $display("reg0  = %d", reg0);
            $display("reg1  = %d", reg1);
            $display("reg2  = %d", reg2);
            $display("reg3  = %d", reg3);
            $display("reg4  = %d", reg4);
            $display("reg5  = %d", reg5);
            $display("reg6  = %d", reg6);
            $display("reg7  = %d", reg7);
            $display("reg8  = %d", reg8);
            $display("reg9  = %d", reg9);
            $display("reg10 = %d", reg10);
            $display("reg11 = %d", reg11);
            $display("reg12 = %d", reg12);
            $display("reg13 = %d", reg13);
            $display("reg14 = %d", reg14);
            $display("reg15 = %d", reg15);
            $display("reg16 = %d", reg16);
            $display("reg17 = %d", reg17);
            $display("reg18 = %d", reg18);
            $display("reg19 = %d", reg19);
            $display("reg20 = %d", reg20);
            $display("reg21 = %d", reg21);
            $display("reg22 = %d", reg22);
            $display("reg23 = %d", reg23);
            $display("reg24 = %d", reg24);
            $display("reg25 = %d", reg25);
            $display("reg26 = %d", reg26);
            $display("reg27 = %d", reg27);
            $display("reg28 = %d", reg28);
            $display("reg29 = %d", reg29);
            $display("reg30 = %d", reg30);
            $display("reg31 = %d", reg31);
        end
    endtask

endmodule
