module MUX2(input sel , input[31:0] a , b , output reg[31:0] out);
    
    always @(sel , a , b) begin
        if(sel) begin
            out <= b;
        end
        else out <= a;
        
    end
endmodule