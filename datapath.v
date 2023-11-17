module  DataPath(input clk , start ,  , input [31:0] a1_init,a2_init,a3_init,a4_init   , 
    output plu1_done ,plu2_done,plu3_done,plu4_done , finish , output [31:0] out);
    
    wire [31:0] a1_wire_out , a2_wire_out , a3_wire_out , a4_wire_out , plu1 , plu2 , plu3 , plu4
        epsilon_wire_out ,mux1_out,mux3_out,mux2_out,mux4_out;

    MUX2 mux1(mux_sel1 , a1_init , plu1 , mux1_out);
    MUX2 mux2(mux_sel2 , a2_init , plu2 , mux2_out);
    MUX2 mux3(mux_sel3 , a3_init , plu3 , mux3_out);
    MUX2 mux4(mux_sel4 , a4_init , plu4 , mux4_out);


    Register a1_reg(clk ,max1_out ,a1_wire_out , we_a_reg);
    Register a2_reg(clk ,max2_out ,a2_wire_out , we_a_reg);
    Register a3_reg(clk ,max3_out ,a3_wire_out , we_a_reg); 
    Register a4_reg(clk ,max4_out ,a4_wire_out , we_a_reg);
    Register a1_reg(clk ,a1_init , a1_prim , we_prim);
    Register a2_reg(clk ,a2_init , a2_prim , we_prim);
    Register a3_reg(clk ,a3_init , a3_prim , we_prim); 
    Register a4_reg(clk ,a4_init , a4_prim , we_prim);


    PLU  p1(.clk(clk) , .start(start) , .done(plu1_done) ,  );
    PLU  p2(.clk(clk) , .start(start) , .done(plu2_done) ,  );
    PLU  p3(.clk(clk) , .start(start) , .done(plu3_done) ,  );
    PLU  p4(.clk(clk) , .start(start) , .done(plu4_done) ,  );

    OutputCheck outch(.clk(clk) , .x1(plu1),.x2(plu2),.x3(plu3),.x4(plu4), .a1(a1_prim),.a2(a2_prim),.a3(a3_prim)
                ,.a4(a4_prim) , .out(out) , .valid(finish));



endmodule