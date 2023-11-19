module Adder();
    input [31:0] a, b;
    output [31:0] out;

    wire [7:0] nr_exp_little, nr_exp_big;
    wire [22:0] nr_mant_little, nr_mant_big;
    reg [22:0] mant_diff;
    wire [31:0] little, big;
    Little_big lb(a, b, little, big);

    Adder_normalizer adn(.exp_little(little[30:23]), .exp_big(big[30:23]), .mant_little(little[22:0]), .mant_b(big[22:0]), .exp_little_out(nr_exp_little), .exp_b_out(nr_exp_b), .mant_little_out(nr_mant_little), .mant_b_out(nr_mant_b));
    always @(a, b) begin
        case ({a[31], b[31]})
            2'b00: mant_diff = mant_a_out + mant_b_out;
            2'b01: mant_diff = mant_a_out - mant_b_out;
            2'b10: mant_diff = mant_b_out - mant_a_out;
            2'b11: mant_diff = mant_a_out + mant_b_out;
        endcase
    end 
    Shift_exp_mant sem()

endmodule