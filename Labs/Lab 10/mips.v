`define MAX_PC 11
`define OUTPUT_REG 4

module mips(clk, outp

);

    input clk;
    output [7:0]outp;
    reg [7:0] outp;
    reg [31:0]instructions[0:10];
    reg [7:0]data_memory[0:2];
    reg [7:0]register[0:31];
    reg [7:0]cnt;
    reg [2:0]state;
    reg [31:0]instr;
    reg [5:0]opcode;
    reg [4:0]rs;
    reg [4:0]rt;
    reg [4:0]rd;
    reg [4:0]sh_amt;
    reg [5:0]func;
    reg [15:0]immediate;
    reg [7:0]op1;
    reg [7:0]op2;
    reg [7:0]res;
    reg [7:0]address;


    initial begin
        instructions[0][31:26] = 6'b100011;
        instructions[0][25:21] = 0;
        instructions[0][20:16] = 5'b00001;
        instructions[0][15:0] = 0;
        
        instructions[1][31:26] = 6'b100011;
        instructions[1][25:21] = 0;
        instructions[1][20:16] = 5'b00010;
        instructions[1][15:0] = 16'b0000000000000001;

        instructions[2][31:26] = 6'b100011;
        instructions[2][25:21] = 0;
        instructions[2][20:16] = 5'b00011;
        instructions[2][15:0] = 16'b0000000000000010;

        instructions[3][31:26] = 6'b001001;
        instructions[3][25:21] = 0;
        instructions[3][20:16] = 5'b00100;
        instructions[3][15:0] = 0;

        instructions[4][31:26] = 6'b001001;
        instructions[4][25:21] = 5'b00001;
        instructions[4][20:16] = 5'b00101;
        instructions[4][15:0] = 0;

        instructions[5][31:26] = 0;
        instructions[5][25:21] = 5'b00101;
        instructions[5][20:16] = 5'b00010;
        instructions[5][15:11] = 5'b00110;
        instructions[5][10:6] = 0;
        instructions[5][5:0] = 6'b101010;

        instructions[6][31:26] = 6'b000100;
        instructions[6][25:21] = 0;
        instructions[6][20:16] = 5'b00110;
        instructions[6][15:0] = 16'b0000000000000101;

        instructions[7][31:26] = 0;
        instructions[7][25:21] = 5'b00100;
        instructions[7][20:16] = 5'b00101;
        instructions[7][15:11] = 5'b00100;
        instructions[7][10:6] = 0;
        instructions[7][5:0] = 6'b100001;

        instructions[8][31:26] = 0;
        instructions[8][25:21] = 5'b00101;
        instructions[8][20:16] = 5'b00011;
        instructions[8][15:11] = 5'b00101;
        instructions[8][10:6] = 0;
        instructions[8][5:0] = 6'b100001;

        instructions[9][31:26] = 0;
        instructions[9][25:21] = 5'b00101;
        instructions[9][20:16] = 5'b00010;
        instructions[9][15:11] = 5'b00110;
        instructions[9][10:6] = 0;
        instructions[9][5:0] = 6'b101010;

        instructions[10][31:26] = 6'b000101;
        instructions[10][25:21] = 0;
        instructions[10][20:16] = 5'b00110;
        instructions[10][15:0] = 16'b1111111111111101;

        data_memory[0] = 8'b11101100;
        data_memory[1] = 8'b00001010;
        data_memory[2] = 8'b00000010;

        register[0]=0;
        register[1]=0;
        register[2]=0;
        register[3]=0;
        register[4]=0;
        register[5]=0;
        register[6]=0;
        register[7]=0;
        register[8]=0;
        register[9]=0;
        register[10]=0;
        register[11]=0;
        register[12]=0;
        register[13]=0;
        register[14]=0;
        register[15]=0;
        register[16]=0;
        register[17]=0;
        register[18]=0;
        register[19]=0;
        register[20]=0;
        register[21]=0;
        register[22]=0;
        register[23]=0;
        register[24]=0;
        register[25]=0;
        register[26]=0;
        register[27]=0;
        register[28]=0;
        register[29]=0;
        register[30]=0;
        register[31]=0;

        cnt=0;
        state=0;
        instr=0;
        opcode=0;
        rs=0;
        rt=0;
        rd=0;
        sh_amt=0;
        func=0;
        immediate=0;
        op1=0;
        op2=0;
        res=0;
        address=0;
    end

    always @(posedge clk) begin
        if(state == 0) begin
            instr <= instructions[cnt];
            state <= 1;
        end

        else if(state == 1) begin
            opcode <= instr[31:26];
            rs <= instr[25:21];
            rt <= instr[20:16];
            if(instr[31:26] == 0) begin       
                rd <= instr[15:11];
                sh_amt <= instr[10:6];
                func <= instr[5:0];
            end
            else begin
                immediate <= instr[15:0];
            end
            state <= 2;
        end

        else if(state == 2) begin
            op1 <= register[rs];
            op2 <= register[rt];
            state <= 3;
        end

        else if(state == 3) begin
            if(opcode == 6'b100011) begin
                address <= immediate[7:0] + op1;
                cnt<=cnt+1;
            end
            else if(opcode == 6'b001001) begin
                res <= immediate[7:0] + op1;
                cnt<=cnt+1;
            end
            else if(opcode == 6'b000100) begin
                if(op1 == op2) begin
                    cnt <= cnt + immediate[7:0];
                end
                else begin
                    cnt <= cnt + 1;
                end
            end
            else if(opcode == 6'b000101) begin
                if(op1 != op2) begin
                    cnt <= cnt + immediate[7:0];
                end
                else begin
                    cnt <= cnt + 1;
                end
            end
            else if(opcode == 0) begin
                if(func == 6'b101010) begin
                    if($signed(op1) < $signed(op2)) begin
                        res <= 8'b00000001;
                    end
                    else begin
                        res <= 0;
                    end
                    cnt <= cnt + 1;
                end
                else if(func == 6'b100001) begin
                    res <= op1 + op2;
                    cnt <= cnt + 1;
                end
            end
            state <= 4;
        end

        else if(state == 4) begin
            if(opcode == 6'b100011) begin
                res <= data_memory[address];
            end
            state <= 5;
        end

        else if(state == 5) begin
            if(opcode == 0) begin
                if(rd != 0) begin
                    register[rd] <= res;
                end
            end
            else if(opcode == 6'b100011 || opcode == 6'b001001) begin
                if(rt != 0) begin
                    register[rt] <= res;
                end
            end
            if(cnt < `MAX_PC) begin
                state <= 0;
            end
            else begin 
                state <= 6;
            end
        end

        else if (state == 6) begin
            outp <= register[`OUTPUT_REG];
        end
    end

endmodule
