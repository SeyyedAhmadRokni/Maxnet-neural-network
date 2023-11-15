module ReLU(inp, out);
    input [31:0] inp;
    output [31:0] out;
    assign out = inp[31] ? 32'b0 : inp;

endmodule
