module Adder_normalizer(exp_little, exp_big, mant_little, mant_big, exp_little_out, exp_big_out, mant_little_out, mant_big_out);
    input [7:0] exp_little, exp_big;
    input [22:0] mant_little, mant_big;
    output [7:0] exp_little_out, exp_big_out;
    output [22:0] mant_little_out, mant_big_out;

    wire [22:0] little_diff_big = exp_big - exp_little;
    assign exp_little_out = exp_big;
    assign exp_big_out = exp_big;
    assign mant_little_out = {1'b1, mant_little[22:1]} >> little_diff_big;
    assign mant_big_out = {1'b1, mant_big[22:1]};

endmodule