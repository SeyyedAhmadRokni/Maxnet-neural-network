module Maxnet_model(input start , clk , input [31:0] epsilon,a1,a2,a3,a4 , output finish , output [31:0] out);
    wire start_plu ,we_a_reg ,eps_reg_we ,we_prim , rst , mux_sel 
    ,valid , plu_done;

    DataPath dp(.clk(clk), .rst_plu(rst), .eps_reg_we(eps_reg_we), .we_a_reg(we_a_reg), 
            .we_prim(we_prim), .mux_sel(mux_sel), .start(start_plu),.a1_init(a1) , .a2_init(a2), .a3_init(a3), .a4_init(a4) , .epsilon(epsilon)
            , .plu_done(plu_done) , .finish(valid) , .out(out));
    

    Controler c(.clk(clk) , .start(start), .valid(valid), .plu_done(plu_done),
             .eps_reg_we(eps_reg_we), .we_a_reg(we_a_reg), 
            .we_prim(we_prim), .mux_sel(mux_sel), .start_plu(start_plu) , .rst(rst) , .finish(finish));

endmodule