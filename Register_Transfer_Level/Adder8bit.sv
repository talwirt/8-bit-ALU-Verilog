module Adder8bit (
    input wire [7:0] a,       // First 8-bit input number
    input wire [7:0] b,       // Second 8-bit input number
    output wire [7:0] sum,    // 8-bit result of the addition
    output wire carry_out     // Carry bit if the result is larger than 255 (overflow)
);

    // We use concatenation {...} to combine the 1-bit carry and 8-bit sum into a 9-bit space.
    // This automatically catches the 9th bit of the addition!
    assign {carry_out, sum} = a + b;

endmodule