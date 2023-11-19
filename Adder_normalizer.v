module Adder_normalizer(exp_a, exp_b, mant_a, mant_b, exp_a_out, exp_b_out, mant_a_out, mant_b_out);
    input [7:0] exp_a, exp_b;
    input [22:0] mant_a, mant_b;
    output [7:0] exp_a_out, exp_b_out;
    output [22:0] mant_a_out, mant_b_out;

    reg [22:0] a_diff_b;
    always @(*) begin
        a_diff_b = exp_a - exp_b;
        if (a_diff_b<23'b0)begin
            a_diff_b = ~ a_diff_b;
            exp_a_out = exp_b;
            exp_b_out = exp_b;
            mant_b_out = mant_b;
            mant_a_out = mant_a >> a_diff_b;
        end else begin
            exp_a_out = exp_a;
            exp_b_out = exp_a;
            mant_a_out = mant_a;
            mant_b_out = mant_b >> a_diff_b;
        end
    end

endmodule