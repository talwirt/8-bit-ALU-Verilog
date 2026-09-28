module Register2bit (
    input  wire       clk,
    input  wire       reset,
    input  wire [1:0] d,
    output reg  [1:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 2'b00;
        else
            q <= d;
    end

endmodule