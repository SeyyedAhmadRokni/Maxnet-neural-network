module PLU_cnt(clk, rst, start, done, a_we, w_we, r1_we, r2_we, r3_we);

    input start, clk, rst;
    output reg done=0, a_we, w_we, r1_we, r2_we, r3_we;
    
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;


    reg [2:0] ps, ns;
    always @(posedge clk, rst) begin
        if (rst)
            ps <= S0;
        else
            ns <= ps;
    end

    always @(ps, start) begin
        case (ps)
            S0: ns = start ? S1 : S0;
            S1: ns = S2;
            S2: ns = S3;
            S3: ns = S4;
            S4: ns = S0;
            default: 
            ns = S0;
        endcase
    end

    always @(ps) begin
        {a_we, w_we, r1_we, r2_we, r3_we, done} = 6'b0;

        case (ps)
            S1: begin
                a_we = 1'b1;
                w_we = 1'b1;
            end 

            S2: begin
                r1_we = 1'b1;
            end

            S3: begin
                r2_we = 1'b1;
            end

            S4: begin
                r3_we = 1'b1;
                done = 1'b1;
            end
        endcase
    end

endmodule