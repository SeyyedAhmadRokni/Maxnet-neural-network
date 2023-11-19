module  DataPath(input clk ,rst_plu ,eps_reg_we ,we_a_reg , we_prim , mux_sel , start  , input [31:0] a1_init,a2_init,a3_init,a4_init,epsilon   , 
    output plu_done , finish , output [31:0] out);
    
    wire [31:0] a1_wire_out , a2_wire_out , a3_wire_out , a4_wire_out , plu1 , plu2 , plu3 , plu4,
        epsilon_wire_out ,mux1_out,mux3_out,mux2_out,mux4_out;
    wire plu1_done,plu2_done,plu3_done,plu4_done;
    MUX2 mux1(mux_sel1 , a1_init , plu1 , mux1_out);
    MUX2 mux2(mux_sel2 , a2_init , plu2 , mux2_out);
    MUX2 mux3(mux_sel3 , a3_init , plu3 , mux3_out);
    MUX2 mux4(mux_sel4 , a4_init , plu4 , mux4_out);

    assign plu_done = plu1_done & plu2_done & plu3_done & plu4_done;
    Register epsReg(clk , epsilon , epsilon_wire_out , eps_reg_we);

    Register a1_reg(clk ,max1_out ,a1_wire_out , we_a_reg);
    Register a2_reg(clk ,max2_out ,a2_wire_out , we_a_reg);
    Register a3_reg(clk ,max3_out ,a3_wire_out , we_a_reg); 
    Register a4_reg(clk ,max4_out ,a4_wire_out , we_a_reg);
    Register a1_reg_prim(clk ,a1_init , a1_prim , we_prim);
    Register a2_reg_prim(clk ,a2_init , a2_prim , we_prim);
    Register a3_reg_prim(clk ,a3_init , a3_prim , we_prim); 
    Register a4_reg_prim(clk ,a4_init , a4_prim , we_prim);


    PLU  p1(.clk(clk), .start(start), .done(plu1_done), .w1(epsilon_wire_out), .w2(epsilon_wire_out)
        ,.w3(epsilon_wire_out), .w4(epsilon_wire_out), .a1(a1_wire_out), .a2(a2_wire_out), .a3(a3_wire_out), .a4(a4_wire_out), .out(plu1), .rst(rst_plu));
    PLU  p2(.clk(clk), .start(start), .done(plu2_done), .w1(epsilon_wire_out), .w2(epsilon_wire_out)
        ,.w3(epsilon_wire_out), .w4(epsilon_wire_out), .a1(a1_wire_out), .a2(a2_wire_out), .a3(a3_wire_out), .a4(a4_wire_out), .out(plu1), .rst(rst_plu));
    PLU  p3(.clk(clk), .start(start), .done(plu3_done), .w1(epsilon_wire_out), .w2(epsilon_wire_out)
        ,.w3(epsilon_wire_out), .w4(epsilon_wire_out), .a1(a1_wire_out), .a2(a2_wire_out), .a3(a3_wire_out), .a4(a4_wire_out), .out(plu1), .rst(rst_plu));
    PLU  p4(.clk(clk), .start(start), .done(plu4_done), .w1(epsilon_wire_out), .w2(epsilon_wire_out)
        ,.w3(epsilon_wire_out), .w4(epsilon_wire_out), .a1(a1_wire_out), .a2(a2_wire_out), .a3(a3_wire_out), .a4(a4_wire_out), .out(plu1), .rst(rst_plu));

    OutputCheck outch(.clk(clk) , .x1(plu1),.x2(plu2),.x3(plu3),.x4(plu4), .a1(a1_prim),.a2(a2_prim),.a3(a3_prim)
                ,.a4(a4_prim) , .out(out) , .valid(finish));



endmodule