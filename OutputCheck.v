module OutputCheck(input clk , input [31 :0] x1 ,x2,x3,x4,a1,a2,a3,a4 , output valid , output [ 31:0] out);
    wire [31:0] wire_mux1,wire_mux2,wire_mux3;
    wire ch1 , ch2 , ch3 , ch4;
    assign ch1 = ~ (| x1[30:0]);
    assign ch2 = ~ (| x2[30:0]);
    assign ch3 = ~ (| x3[30:0]);
    assign ch4 = ~ (| x4[30:0]);
    wire xor_check , three_zero;
    assign xor_check = ch1 ^ ch2 ^ ch3 ^ ch4;
    assign three_zero = xor_check & ((ch1 & ch2) | (ch3 & ch4));


    MUX2 mx1(.sel(ch2) , .a(a2) , .b(a1) , .out(wire_mux1));
    MUX2 mx2(.sel(ch3) , .a(a3) , .b(wire_mux1) , .out(wire_mux2));
    MUX2 mx3(.sel(ch4) , .a(a4) , .b(wire_mux2) , .out(wire_mux3));
    assign valid = (ch1 & ch2 & ch3 & ch4) | three_zero;
    Register reg3(.clk(clk) , .inp(wire_mux3) , .out(out) , .we(~valid));
endmodule