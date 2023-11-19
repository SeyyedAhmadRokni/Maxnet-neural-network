module Register(clk, inp, out, we);
    input clk, we;
    input [31:0] inp;
    output reg[31:0] out;
    reg [31:0] value;
    

    always @( posedge clk) begin
        if (we) begin
            out = inp;
        end
        
    end

endmodule