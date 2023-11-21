module Shift_exp_mant(exp, mant, exp_out, mant_out);

    input [7:0] exp;
    input [22:0] mant;
    output reg [7:0] exp_out;
    output reg [22:0] mant_out;
    integer i;
    reg [4:0] shift_num;

    always @(mant, exp) begin
        mant_out = mant;
        shift_num = 5'b0;
        for (i = 22; i>=0; i = i-1) begin
            if (~mant_out[22])begin
                mant_out = mant_out << 1'b1;
                shift_num = shift_num + 1'b1;
            end
        end
        mant_out = mant_out << 1'b1;
        // shift_num = shift_num + 1'b1;
        exp_out = exp - shift_num;
    end

endmodule