module output_check(x1, x2, x3, x4, a1, a2, a3, a4, valid, out);
    input [31:0] x1, x2, x3, x4, a1, a2, a3, a4;
    assign x1_is_zero = ~|x1[30:0];
    assign x2_is_zero = ~|x2[30:0];
    assign x3_is_zero = ~|x3[30:0];
    assign x1_is_zero = ~|x1[30:0];

endmodule