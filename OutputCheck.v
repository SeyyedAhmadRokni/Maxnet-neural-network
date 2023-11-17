module OutputCheck(input clk , input [31 :0] x1 ,x2,x3,x4,a1,a2,a3,a4 , output valid , output [ 31:0] out);
    wire [31:0] wire_mux1,wire_mux2,wire_mux3;
    wire ch1 , ch2 , ch3 , ch4 , valid;

    MUX2 mx1(.sel(ch2) , .a(a2) , .b(a1) , .out(wire_mux1));
    MUX2 mx1(.sel(ch3) , .a(a3) , .b(wire_mux1) , .out(wire_mux2));
    MUX2 mx1(.sel(ch4) , .a(a4) , .b(wire_mux2) , .out(wire_mux3));
    assign valid <= ~(ch1 | ch2 | ch3 | ch4);
    Register reg(.clk(clk) , .inp(wire_mux3) , .out(out))
endmodule