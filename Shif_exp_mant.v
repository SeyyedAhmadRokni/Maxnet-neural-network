module Shift_exp_mant(exp, mant, exp_out, mant_out);

    input [7:0] exp;
    input [22:0] mant;
    output [7:0] exp_out;
    output [22:0] mant_out;
    integer i;

    always @(*) begin
        for (i = 22; i>=0; i = i+1) begin
            if (|mant[22:i])begin
                mant_out = {mant[i-1:0], 32'b0};
                exp_out = exp + (8'd23 - i);
            end
        end
    end

endmodule