module Mux2to1 (
    input wire in0,
    input wire in1,
    input wire sel,
    output wire out
);

    // If sel is 1, out gets in1. Else, out gets in0
    assign out = sel ? in1 : in0;

endmodule
