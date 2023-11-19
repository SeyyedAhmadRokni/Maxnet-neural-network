module Mul(a, b, out);
    parameter bias = 8'd127;
    input [31:0] a, b;
    output [31:0] out;
    wire sign = a[31] ^ b[31];
    reg [7:0] exponent;
    reg [47:0] mantices;
    wire [7:0] exp_out;
    wire [22:0] mantices_out;
    Normalizer nr(exponent, mantices, exp_out, mantices_out);
    assign out = {sign, exp_out, mantices_out};
    always @(a, b) begin
        mantices = {1'b1, a[22:0]} * {1'b1,b[22:0]};
        exponent = a[30:23] - bias + b[30:23];
    end
endmodule