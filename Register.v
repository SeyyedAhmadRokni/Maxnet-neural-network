module Reg(clk, inp, out, we);
    input clk, we;
    input [31:0] inp;
    output [3:0] out;
    reg [31:0] value;
    assign out = value;

    always @(posedge clk) begin
        if (we) begin
            value = inp;
        end
        
    end

endmodule