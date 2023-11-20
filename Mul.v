module Mul(a, b, out, overflow);
    parameter bias = 8'd127;
    input [31:0] a, b;
    output [31:0] out;
    output overflow;
    wire sign = ~(| a[30:0]) | ~(| b[30:0]) ? 1'b0 : a[31] ^ b[31];
    reg [7:0] exponent;
    reg [47:0] mantices;
    wire [7:0] exp_out;
    wire [22:0] mantices_out;
    reg overflow_inf;
    reg carry;
    Normalizer nr(exponent, mantices, exp_out, mantices_out);
    assign out = {sign, exp_out, mantices_out};
    assign overflow = overflow_inf | carry;
    always @(a, b) begin
        carry = 1'b0;
        overflow_inf <= 1'b0;
        if (~(| a[30:0]) | ~(| b[30:0]))begin
            mantices = 23'b0;
            exponent = 7'b0;
        end else begin
            mantices = {1'b1, a[22:0]} * {1'b1,b[22:0]};
            {carry, exponent} = a[30:23] - bias + b[30:23];
        end
        if (a[30:23] == 7'b1111111 | b[30:23] == 7'b1111111 )
            overflow_inf <= 1'b1;
    end
endmodule