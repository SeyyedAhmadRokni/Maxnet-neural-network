module Normalizer(exp, mantices, exp_out, mantices_out);
    input [7:0] exp;
    input [47:0] mantices;
    output [7:0] exp_out;
    output [22:0] mantices_out;
    assign mantices_out = mantices[47] ? mantices[46:24] : mantices[45:23];
    assign exp_out = mantices[47] ? exp + 1'b1 : exp;
endmodule