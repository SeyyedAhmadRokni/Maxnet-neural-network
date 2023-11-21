module  Controler(input start ,clk , valid , plu_done , loop,
     output reg start_plu ,we_a_reg ,eps_reg_we ,we_prim , rst , mux_sel , finish);
   
   parameter [3:0] S=0, A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8;
   reg [3:0] ps=S , ns;


    always @(posedge clk) begin
        ps <= ns;
    end

   always @(ps , valid ,start, plu_done) begin
    {start_plu , we_a_reg , we_prim , rst , mux_sel ,eps_reg_we , finish} = 7'b0000000;
        case (ps)
            S:begin ns = (start==1) ? A :S; end
            A:begin ns = B ; we_a_reg=1;we_prim=1;mux_sel=1 ; eps_reg_we=1;rst=1; end 
            B:begin ns = C ; start_plu =1; end 
            C:begin ns = (plu_done==1) ? D : C;end 
            D:begin ns = (loop) ? F : E ; end 
            E:begin ns = (valid == 1) ? F : B ; we_a_reg=1; end 
            F:begin ns = S ;finish=1; end 
           

            default:begin
        {start_plu , we_a_reg , we_prim , rst , mux_sel ,eps_reg_we , finish} = 7'b0000000;
            end

        endcase
   end

endmodule