module Adder_normalizer(exp_little, exp_big, mant_little, mant_big, exp_little_out, exp_big_out, mant_little_out, mant_big_out);
    input [7:0] exp_little, exp_big;
    input [22:0] mant_little, mant_big;
    output [7:0] exp_little_out, exp_big_out;
    output [22:0] mant_little_out, mant_big_out;

    reg [22:0] a_diff_big;
    always @(*) begin
        a_diff_big = exp_little - exp_big;
        if (a_diff_big<23'b0)begin
            a_diff_big = ~ a_diff_big;
            exp_little_out = exp_big;
            exp_big_out = exp_big;
            mant_big_out = mant_big;
            mant_little_out = mant_little >> a_diff_big;
        end else begin
            exp_little_out = exp_little;
            exp_big_out = exp_little;
            mant_little_out = mant_little;
            mant_big_out = mant_big >> a_diff_big;
        end
    end

endmodule