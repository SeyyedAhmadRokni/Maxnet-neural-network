module Adder_normalizer(exp_little, exp_big, mant_little, mant_big, exp_little_out, exp_big_out, mant_little_out, mant_big_out);
    input [7:0] exp_little, exp_big;
    input [22:0] mant_little, mant_big;
    output [7:0] exp_little_out, exp_big_out;
    output [22:0] mant_little_out, mant_big_out;

    reg [22:0] little_diff_big;
    always @(*) begin
        little_diff_big = exp_big - exp_little;
        exp_little_out = exp_little;
        exp_big_out = exp_little;
        mant_little_out = mant_little;
        mant_big_out = mant_big >> little_diff_big;
    end

endmodule