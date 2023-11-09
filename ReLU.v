module ReLU(inp, out);
    input [31:0] inp;
    output [31:0] out;
    assign out = inp[31] ? 32b'0 : inp;

endmodule
