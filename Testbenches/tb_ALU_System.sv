
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
  
  	// Expected outputs
    reg [7:0] expected_result;
    reg expected_carry;
    reg expected_zero;

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

  task check_result;
    begin
        if ((tb_out_result == expected_result) &&
            (tb_out_carry == expected_carry) &&
            (tb_out_zero == expected_zero))
            $display("PASS: result=%d, carry=%b, zero=%b",
                     tb_out_result, tb_out_carry, tb_out_zero);
        else
          $display("FAIL: expected result=%d, carry=%b, zero=%b | got    result=%d, carry=%b, zero=%b",
                     expected_result, expected_carry, expected_zero,
                     tb_out_result, tb_out_carry, tb_out_zero);
    end
endtask
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
        tb_op_sel = 2'b00;

       expected_result = 30;
       expected_carry = 0;
       expected_zero = 0;

       #20; // Wait 2 clock cycles for the pipeline

       check_result();
      

        // --- Step 3: Subtraction that yields zero (50 - 50) ---
        tb_in_a = 50; 
        tb_in_b = 50; 
        tb_op_sel = 2'b01;

       expected_result = 0;
       expected_carry = 0;
       expected_zero = 1;

       #20; // Wait 2 clock cycles for the pipeline

       check_result();

        // --- Step 4: Addition with Overflow (200 + 100) ---
        tb_in_a = 200; 
        tb_in_b = 100; 
        tb_op_sel = 2'b00;

        expected_result = 44;
        expected_carry = 1;
        expected_zero = 0;

        #20; // Wait 2 clock cycles for the pipeline

        check_result();
              // --- Step 5: Bitwise AND (15 & 255) ---
        tb_in_a = 15; 
        tb_in_b = 255; 
        tb_op_sel = 2'b10;

        expected_result = 15;
        expected_carry = 0;
        expected_zero = 0;

        #20; // Wait 2 clock cycles for the pipeline

        check_result();
              // --- Step 6: Bitwise OR (15 | 240) ---
        tb_in_a = 15; 
        tb_in_b = 240; 
        tb_op_sel = 2'b11;

        expected_result = 255;
        expected_carry = 0;
        expected_zero = 0;

        #20; // Wait 2 clock cycles for the pipeline

        check_result();
        $finish;
    end

endmodule