module  Controler(input start ,clk , valid , plu_done ,
     output start_plu ,we_a_reg ,eps_reg_we ,we_prim , rst , mux_sel , finish);
   
   reg [3:0] ps , ns;
   parameter [3:0] S=0, A=1,B=2,C=3,D=4,E=5,F=5,G=6,H=7;


    always @(posedge clk) begin
        ps <= ns;
    end

   always @(valid ,start, plu_done) begin
        {start_plu , we_a_reg , we_prim , rst , mux_sel ,eps_reg_we , finish} = 7'b00000;
        case (ps)
            S:begin ns = start ? A :S; end
            A:begin ns = B ; we_a_reg=1;we_prim=1;mux_sel=1 , eps_reg_we=1; end 
            B:begin ns = C ; start_plu =1; end 
            C:begin ns = plu_done ? D : C;end 
            D:begin ns = E ; end 
            E:begin ns = valid ? F : B ;end 
            F:begin ns = S ;finish=1; end 
            G:begin end 
            H:begin end 

            default:
            begin {start , we_a_reg , we_prim , rst} = 4'b0000; end

        endcase
   end

endmodule