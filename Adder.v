module Adder(a, b, out, overflow);
    input [31:0] a, b;
    output [31:0] out;
    output reg overflow;

    wire [7:0] nr_exp_little, nr_exp_big;
    wire [22:0] nr_mant_little, nr_mant_big;
    reg [22:0] new_mant;
    wire [22:0] sem_mant_in;
    wire [31:0] little, big;

    wire sign;
    reg carry = 1'b0;
    wire [1:0] cnt;
    assign cnt = {little[31], big[31]};

    Little_big lb(a, b, little, big);
    Adder_normalizer adn(.exp_little(little[30:23]), .exp_big(big[30:23]),
    .mant_little(little[22:0]), .mant_big(big[22:0]), 
    .exp_little_out(nr_exp_little), .exp_big_out(nr_exp_big), 
    .mant_little_out(nr_mant_little)
    , .mant_big_out(nr_mant_big));

    wire [22:0] mant;
    wire [7:0] exp;
    assign sign = big[31];
    always @(cnt, nr_mant_big, nr_mant_little) begin
        carry <= 1'b0;
        overflow <= 1'b0;
        case (cnt)
            2'b00:begin
                {carry, new_mant} <= nr_mant_little + nr_mant_big;
            end
            2'b01:begin
                new_mant <= nr_mant_big - nr_mant_little;
            end
            2'b10:begin
                new_mant <= nr_mant_big - nr_mant_little;
            end
            2'b11:begin
                {carry, new_mant} <= nr_mant_little + nr_mant_big;
            end
        endcase
        if ((a[30:23] == 7'b1111111 & a[22:0] == 23'b0) | (b[30:23] == 7'b1111111 & b[22:0] == 23'b0 ))
             overflow <= 1'b1;
    end 
    assign out = a[30:0] == b[30:0] & (a[31] ^ b[31]) ? 32'b0 
                : a[30:23] == 7'b1111111 & a[22:0] == 23'b0 ? a
                : b[30:23] == 7'b1111111 & b[22:0] == 23'b0 ? b
                : {sign, exp + carry, mant};
    assign sem_mant_in = carry ? {1'b1, new_mant[22:1]} : new_mant; 
    
    Shift_exp_mant sem(nr_exp_little, sem_mant_in, exp, mant);

endmodule