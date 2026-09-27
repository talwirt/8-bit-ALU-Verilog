module tb_Adder8bit;

    // Inputs to the Adder (reg because we assign values to them)
    reg [7:0] tb_a;
    reg [7:0] tb_b;

    // Outputs from the Adder (wire because we just read the result)
    wire [7:0] tb_sum;
    wire tb_carry_out;

    // Create an instance of the Adder
    Adder8bit uut (
        .a(tb_a),
        .b(tb_b),
        .sum(tb_sum),
        .carry_out(tb_carry_out)
    );

    // The main test scenario
    initial begin
        // Print to screen every time a value changes. Notice the %d for decimal numbers!
        $monitor("Time = %0t | a = %d, b = %d ---> sum = %d, carry_out = %b", $time, tb_a, tb_b, tb_sum, tb_carry_out);

        // Test 1: Simple addition (No carry)
        tb_a = 10;
        tb_b = 20;
        #10; // Wait 10 time units (Expected: sum = 30, carry = 0)

        // Test 2: Another simple addition
        tb_a = 100;
        tb_b = 50;
        #10; // (Expected: sum = 150, carry = 0)

        // Test 3: The Overflow edge case (255 + 1)
        // 255 is the maximum value for 8 bits. Adding 1 should cause an overflow.
        tb_a = 255;
        tb_b = 1;
        #10; // (Expected: sum = 0, carry = 1)
        
        // Test 4: Maximum possible inputs (255 + 255)
        tb_a = 255;
        tb_b = 255;
        #10; // (Expected: sum = 254, carry = 1)

        // End simulation
        $finish;
    end

endmodule