// `include "PLU.v"
module PLU_tb();
    reg clk = 1'b0;
    reg rst, start;
    wire done;
    wire [31:0] out;
    reg [31:0] w1, w2, w3, w4, a1, a2, a3, a4;
    PLU plu(clk, rst, start, done, 
            w1, w2, w3, w4, a1, a2, a3, a4, out);
    

    always
        #10 clk = ~clk;

    initial begin
        // $dumpfile("PLU_tb.vcd");
        // $dumpvars(0, PLU_tb);
        w1 = 32'b00111111100000000000000000000000;
        w2 = 32'b00111111100000000000000000000000;
        w3 = 32'b00111111100000000000000000000000;
        w4 = 32'b00111111100000000000000000000000;

        a1 = 32'b01000000101001100110011001100110; //5.2 
        a2 = 32'b01000000110110011001100110011010; //6.8
        a3 = 32'b00111111100000000000000000000000;//1
        a4 = 32'b01000000100010011001100110011010; //4.3 

        #5;

        rst = 1'b1;
        #5;
        rst = 1'b0;
        #10;
        start = 1'b1;
        #10;
        start = 1'b0;
        #100;
        $stop;
        
    end

endmodule