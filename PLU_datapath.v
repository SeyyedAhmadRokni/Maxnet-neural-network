// `include "Register.v"
// `include "ReLU.v"
module PLU_datapath(clk, w1, w2, w3, w4, a1, a2, a3, a4, out, w_we, a_we, r1_we, r2_we, r3_we);
    input clk;
    input [31:0] w1;
    input [31:0] w2;
    input [31:0] w3;
    input [31:0] w4;

    input [31:0] a1;
    input [31:0] a2;
    input [31:0] a3;
    input [31:0] a4;
    output [31:0] out;
    output w_we, a_we, r1_we, r2_we, r3_we;

    wire [31:0] w1_out, w2_out, w3_out, w4_out;
    Register w1_reg(clk, w1, w1_out, w_we);
    Register w2_reg(clk, w2, w2_out, w_we);
    Register w3_reg(clk, w3, w3_out, w_we);
    Register w4_reg(clk, w4, w4_out, w_we);

    wire [31:0] a1_out, a2_out, a3_out, a4_out;
    Register a1_reg(clk, a1, a1_out, a_we);
    Register a2_reg(clk, a2, a2_out, a_we);
    Register a3_reg(clk, a3, a3_out, a_we);
    Register a4_reg(clk, a4, a4_out, a_we);

    wire [31:0] mul1_out, mul2_out, mul3_out, mul4_out;
    Mul mul1 (a1_out, w1_out, mul1_out);
    Mul mul2 (a2_out, w2_out, mul2_out);
    Mul mul3 (a3_out, w3_out, mul3_out);
    Mul mul4 (a4_out, w4_out, mul4_out);

    wire [31:0] r1_1_out, r1_2_out, r1_3_out, r1_4_out;
    Register r1_1(clk, mul1_out, r1_1_out, r1_we);
    Register r1_2(clk, mul2_out, r1_2_out, r1_we);
    Register r1_3(clk, mul3_out, r1_3_out, r1_we);
    Register r1_4(clk, mul4_out, r1_4_out, r1_we);

    wire [31:0] add1_out, add2_out;
    Adder add1(r1_1_out, r1_2_out, add1_out);
    Adder add2(r1_3_out, r1_4_out, add2_out);

    wire [31:0] r2_1_out, r2_2_out;
    Register r2_1(clk, add1_out, r2_1_out, r2_we);
    Register r2_2(clk, add2_out, r2_2_out, r2_we);

    wire [31:0] relu_out, add3_out;
    Adder add3(r2_1_out, r2_2_out, add3_out);
    ReLU relu(add3_out, relu_out);

    wire [31:0] r3_1_out;
    Register r3_1(clk, relu_out, r3_1_out, r3_we);

    assign out = r3_1_out;

endmodule