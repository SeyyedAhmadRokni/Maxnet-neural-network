`include "PLU_datapath.v"
`include "PLU_cnt.v"
module PLU(clk, rst, start, done, 
           w1, w2, w3, w4, a1, a2, a3, a4, out 
           );

    input clk, rst, start;
    input [31:0] w1, w2, w3, w4;
    input [31:0] a1, a2, a3, a4;

    output [31:0] out;
    output done;

    wire a_we, w_we, r1_we, r2_we, r3_we;
    PLU_datapath pd(.clk(clk), .w1(w1), .w2(w2), .w3(w3), .w4(w4), .a1(a1), .a2(a2), .a3(a3), .a4(a4), .start(start), .out(out), .w_we(w_we), .a_we(a_we), .r1_we(r1_we), .r2_we(r2_we), .r3_we(r3_we));
    PLU_cnt pc(.clk(clk), .rst(rst), .start(start), .done(done), .a_we(a_we), .w_we(w_we), .r1_we(r1_we), .r2_we(r2_we), .r3_we(r3_we));

endmodule