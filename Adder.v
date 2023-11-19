module Adder(a, b, out);
    input [31:0] a, b;
    output [31:0] out;

    wire [7:0] nr_exp_little, nr_exp_big;
    wire [22:0] nr_mant_little, nr_mant_big;
    reg [22:0] new_mant;
    wire [31:0] little, big;
    reg sign;

    Little_big lb(a, b, little, big);
    Adder_normalizer adn(.exp_little(little[30:23]), .exp_big(big[30:23]), .mant_little(little[22:0]), .mant_big(big[22:0]), .exp_little_out(nr_exp_little), .exp_big_out(nr_exp_big), .mant_little_out(nr_mant_little), .mant_big_out(nr_mant_big));

    wire [22:0] mant;
    wire [7:0] exp;

    always @(a, b) begin
        case ({little[31], big[31]})
            2'b00:begin
                new_mant = nr_mant_little + nr_mant_big;
                sign = 1'b0;
            end
            2'b01:begin
                new_mant = nr_mant_big - nr_mant_little;
                sign = 1'b1;
            end
            2'b10:begin
                new_mant = nr_mant_big - nr_mant_little;
                sign = 1'b0;
            end
            2'b11:begin
                new_mant = nr_mant_little + nr_mant_big;
                sign = 1'b1;
            end
        endcase
    end 
    assign out = {sign, exp, mant};
    Shift_exp_mant sem(nr_exp_little, new_mant, exp, mant);

endmodule