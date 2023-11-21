module  Controler(input start ,clk, rst_cnt, valid , plu_done , loop,
     output reg start_plu ,we_a_reg ,eps_reg_we ,we_prim , rst , mux_sel , finish);
   
   parameter [3:0] S=0, A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8;
   reg [3:0] ps=S , ns;


    always @(posedge clk, rst_cnt) begin
        if (rst_cnt)begin
            ps = S;
        end else begin
            ps = ns;
        end
    end

   always @(ps , valid ,start, plu_done, loop) begin
        {start_plu , we_a_reg , we_prim , rst , mux_sel ,eps_reg_we , finish} = 7'b0000000;
        case (ps)
            S:ns = (start==1) ? A :S;
            A:ns = B;
            B:ns = C;
            C:ns = (plu_done==1) ? D : C;
            D:ns = (loop) ? F : E ; 
            E:ns = (valid == 1) ? F : B ; 
            F:ns = S; 
        endcase
   end

   always @(ps) begin
        case (ps)
            A:begin
                we_a_reg = 1;
                we_prim = 1;
                mux_sel = 1 ;
                eps_reg_we = 1;
                rst = 1; 
            end
            B:begin 
                start_plu =1;
            end
            E:begin
                we_a_reg=1;
            end 
            F:begin
                finish=1;
            end 
        endcase
   end

endmodule