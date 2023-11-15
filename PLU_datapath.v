`include "Register.v"
`include "ReLU.v"
module PLU_datapath(clk, w1, w2, w3, w4, a1, a2, a3, a4, start, out, w_we, a_we, r1_we, r2_we, r3_we);
    input clk;
    input [31:0] w1;
    input [31:0] w2;
    input [31:0] w3;
    input [31:0] w4;

    input [31:0] a1;
    input [31:0] a2;
    input [31:0] a3;
    input [31:0] a4;
    input start;
    output [31:0] out;
    output w_we, a_we, r1_we, r2_we, r3_we;

    wire [31:0] w1_out, w2_out, w3_out, w4_out;
    Register w1_reg(clk, w1, w1_out, w_we);
    Register w2_reg(clk, w2, w2_out, w_we);
    Register w3_reg(clk, w3, w3_out, w_we);
    Register w4_reg(clk, w4, w4_out, w_we);

    wire [31:0] a1_out, a2_out, a3_out, a4_out;
    Register a1_reg(clk, a1, a1_out, a_ae);
    Register a2_reg(clk, a2, a2_out, a_ae);
    Register a3_reg(clk, a3, a3_out, a_ae);
    Register a4_reg(clk, a4, a4_out, a_ae);

    wire [31:0] mul1_out, mul2_out, mul3_out, mul4_out;
    assign mul1_out = a1_out * w1_out;    
    assign mul2_out = a2_out * w2_out;    
    assign mul3_out = a3_out * w3_out;    
    assign mul4_out = a4_out * w4_out;    

    wire [31:0] r1_1_out, r1_2_out, r1_3_out, r1_4_out;
    Register r1_1(clk, mul1_out, r1_1_out, r1_ae);
    Register r1_2(clk, mul2_out, r1_2_out, r1_ae);
    Register r1_3(clk, mul3_out, r1_3_out, r1_ae);
    Register r1_4(clk, mul4_out, r1_4_out, r1_ae);

    wire [31:0] add1_out, add2_out;
    assign add1_out = r1_1_out + r1_2_out;
    assign add2_out = r1_3_out + r1_4_out;

    wire [31:0] r2_1_out, r2_2_out;
    Register r2_1(clk, add1_out, r2_1_out, r2_ae);
    Register r2_2(clk, add2_out, r2_2_out, r2_ae);

    wire [31:0] relu_out, add3_out;
    assign add3_out = r2_1_out + r2_2_out;
    ReLU relu(add3_out, relu_out);

    wire [31:0] r3_1_out;
    Register r3_1(clk, relu_out, r3_1_out, r3_ae);

    assign out = r3_1_out;

endmodule