module  TestBench();
    reg clk=0 ,start=0 ,rst=0;

    reg [31:0] mem [0:3] ;	
	
	initial begin
		$readmemh ("instr.txt" , mem);
	end
    
    reg [31:0] eps=32'b10111110010011001100110011001101 ,
    a1 = 32'b01000110000111000011111110100111,
    a2 = 32'b11000110000111000011111110100111,
    a3 = 32'b00111111101001100110011001100110,
    a4 = 32'b11000110000111000011111110100111;
    always #5 clk = ~clk;
    wire finish, overflow;
    wire [31 : 0] out;
    
    Maxnet_model mxn( start , clk ,eps , a1 , a2 , a3 , a4 ,  finish, overflow , out);
    initial begin
        #32 start=1;
        #10 start=0;

        #2000;
        $stop;
    end

endmodule