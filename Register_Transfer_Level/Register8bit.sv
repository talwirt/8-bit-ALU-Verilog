module Register8bit (
    input wire clk,           // The clock signal that triggers the memory
    input wire reset,         // The reset signal to clear the memory to 0
    input wire [7:0] d,       // The 8-bit input data (D stands for Data)
    output reg [7:0] q        // The 8-bit output data. It is a 'reg' because it stores a value
);

    // This block wakes up ONLY when the clock goes from 0 to 1 (posedge clk)
    // or when the reset signal goes from 0 to 1 (posedge reset)
    always @(posedge clk or posedge reset) begin
        
        // First, check if someone pressed the reset button
        if (reset == 1)
            q <= 8'b00000000; // If reset is 1, clear all 8 bits to 0
        
        // If reset is 0, it means this is a normal clock tick
        else
            q <= d;           // Copy the input (d) to the output (q) and save it
            
    end

endmodule