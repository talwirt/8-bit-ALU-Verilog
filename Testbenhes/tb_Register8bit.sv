module tb_Register8bit;

    // Inputs to the Register (reg because we control them)
    reg tb_clk;
    reg tb_reset;
    reg [7:0] tb_d;
    
    // Output from the Register (wire because we just read it)
    wire [7:0] tb_q;

    // Create an instance of the Register
    Register8bit uut (
        .clk(tb_clk),
        .reset(tb_reset),
        .d(tb_d),
        .q(tb_q)
    );

    // Generate the Clock: Flips the clock value every 5 time units forever
    always begin
        #5 tb_clk = ~tb_clk; 
    end

    // The main test scenario
    initial begin
        // Print to screen every time a value changes
        $monitor("Time = %0t | clk = %b, reset = %b, d = %b ---> q = %b", $time, tb_clk, tb_reset, tb_d, tb_q);

        // Start condition: Set clock to 0, press reset
        tb_clk = 0;
        tb_reset = 1; 
        tb_d = 8'b10101010; // Put some data on the input
        #10; // Wait 10 time units

        // Release reset (normal operation begins)
        tb_reset = 0;
        #10; // Wait for a clock tick. We expect output 'q' to become 10101010

        // Change the input data
        tb_d = 8'b11110000;
        #10; // Wait for the next clock tick. We expect 'q' to update to 11110000

        // End simulation
        $finish;
    end

endmodule