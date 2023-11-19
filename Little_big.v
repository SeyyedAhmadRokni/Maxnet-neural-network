module Little_big(a, b, little, big);
    input [31:0] a, b;
    output reg [31:0] little, big;

    always @(a, b) begin
        if (a[30:23] < b[30:23])begin
            little = a;
            big = b;
        end
        else if (a[30:23] > b[30:23])begin
            little = b;
            big = a;
        end else begin
            if (a[22:0] < b[22:0])begin
                little = a;
                big = b;
            end else begin
                little = b;
                big = a;
            end
        end
    end
endmodule