module Shift_exp_mant(exp, mant, exp_out, mant_out);

    input [7:0] exp;
    input [22:0] mant;
    output reg [7:0] exp_out;
    output reg [22:0] mant_out;
    integer i;

    always @(*) begin
        for (i = 22; i>=0; i = i+1) begin
            if (mant[i])begin
                mant_out = {mant[i-:0], 32'b0};
                exp_out = exp + (8'd23 - i);
            end
        end
    end

endmodule

module Shift_exp_mant(exp, mant, exp_out, mant_out);

    input [7:0] exp;
    input [22:0] mant;
    output reg [7:0] exp_out;
    output reg [22:0] mant_out;
    integer i;

    always @(*) begin
        if (man)
        for (i = 22; i>=0; i = i+1) begin
            if (mant[i])begin
                mant_out = {mant[i-:0], 32'b0};
                exp_out = exp + (8'd23 - i);
            end
        end
    end

endmodule