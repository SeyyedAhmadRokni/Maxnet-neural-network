module  TestBench();
    reg clk=0 ,start=0 ,rst=0;

    reg [31:0] mem [0:3] ;	
	
	initial begin
		$readmemb ("./file/input.txt" , mem);
	end
    
    reg [31:0] eps=32'b10111110010011001100110011001101 ,
    a1,
    a2,
    a3,
    a4;
    always #5 clk = ~clk;
    wire finish, overflow;
    wire [31 : 0] out;
    
    Maxnet_model mxn( start , clk ,rst, eps , a1 , a2 , a3 , a4 ,  finish, overflow , out);
    initial begin
        a1=mem[0] ; a2=mem[1];a3 = mem[2] ; a4=mem[3];
        #32 start=1;
        #10 start=0;

        #2000000;
        $stop;
    end

endmodule