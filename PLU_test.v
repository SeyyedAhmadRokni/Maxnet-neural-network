module PLU_test();
    reg clk = 1'b0;
    reg rst, start, done;
    reg [31:0] w1, w2, w3, w4, a1, a2, a3, a4, out;
    

    always begin
        #10;
        clk = ~clk;
    end

    initial begin
        #5;

        rst = 1'b1;
        #5;
        rst = 1'b0;
        #10;
        start = 1'b1;
        #10;
        start = 1'b0;
        
    end

endmodule