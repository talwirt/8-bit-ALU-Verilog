module tb_ALU_System;

    // Inputs
    reg tb_clk;
    reg tb_reset;
    reg [7:0] tb_in_a;
    reg [7:0] tb_in_b;
    reg [1:0] tb_op_sel;

    // Outputs
    wire [7:0] tb_out_result;
    wire tb_out_carry;
    wire tb_out_zero;

    // Instantiate the Top Level Module
    ALU_System uut (
        .clk(tb_clk),
        .reset(tb_reset),
        .in_a(tb_in_a),
        .in_b(tb_in_b),
        .op_sel(tb_op_sel),
        .out_result(tb_out_result),
        .out_carry(tb_out_carry),
        .out_zero(tb_out_zero)
    );

    // Clock Generator: Flips every 5 time units (10 time units = 1 full cycle)
    always begin
        #5 tb_clk = ~tb_clk;
    end

    // Main Test Sequence
    initial begin
        // Monitor
        $monitor("Time = %0t | clk = %b | sel = %b | in_a = %d, in_b = %d ---> out = %d (carry=%b, zero=%b)", 
                 $time, tb_clk, tb_op_sel, tb_in_a, tb_in_b, tb_out_result, tb_out_carry, tb_out_zero);

        // --- Step 1: System Reset ---
        tb_clk = 0;
        tb_reset = 1;
        tb_in_a = 0; tb_in_b = 0; tb_op_sel = 2'b00;
        #10; // Wait 1 cycle for reset to take effect

        // --- Step 2: Addition (10 + 20) ---
        tb_reset = 0;
        tb_in_a = 10; 
        tb_in_b = 20; 
        tb_op_sel = 2'b00; // Addition
        // We MUST wait 2 clock cycles (#20) because data passes through 2 registers!
        #20; 

        // --- Step 3: Subtraction that yields zero (50 - 50) ---
        tb_in_a = 50; 
        tb_in_b = 50; 
        tb_op_sel = 2'b01; // Subtraction
        #20; // Expected: out = 0, zero = 1

        // --- Step 4: Addition with Overflow (200 + 100) ---
        tb_in_a = 200; 
        tb_in_b = 100; 
        tb_op_sel = 2'b00; // Addition
        #20; // Expected: out = 44 (overflow), carry = 1

        $finish;
    end

endmodule