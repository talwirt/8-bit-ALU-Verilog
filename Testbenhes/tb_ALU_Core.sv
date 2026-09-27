
module tb_ALU_Core;

    // Testbench inputs are 'reg' because we drive them with specific values
    reg [7:0] tb_a;
    reg [7:0] tb_b;
    reg [1:0] tb_alu_sel;

    // Testbench outputs are 'wire' because we only observe them from the module
    wire [7:0] tb_result;
    wire tb_carry_out;
    wire tb_zero_flag;

    // Instantiate the Unit Under Test (UUT)
    ALU_Core uut (
        .a(tb_a),
        .b(tb_b),
        .alu_sel(tb_alu_sel),
        .result(tb_result),
        .carry_out(tb_carry_out),
        .zero_flag(tb_zero_flag)
    );

    // Main test sequence
    initial begin
        // Monitor tracks changes and prints them to the console.
        // %b is used for binary (flags, selector) and %d for decimal (operands, result).
        $monitor("Time = %0t | sel = %b | a = %d, b = %d ---> result = %d | carry = %b, zero = %b", 
                 $time, tb_alu_sel, tb_a, tb_b, tb_result, tb_carry_out, tb_zero_flag);

        // --- Test Case 1: Normal Addition ---
        tb_alu_sel = 2'b00;
        tb_a = 50; tb_b = 60;
        #10; // Expected: result = 110, flags = 0

        // --- Test Case 2: Addition with Overflow ---
        tb_a = 200; tb_b = 100;
        #10; // Expected: result = 44 (300 % 256), carry_out = 1

        // --- Test Case 3: Normal Subtraction ---
        tb_alu_sel = 2'b01;
        tb_a = 100; tb_b = 40;
        #10; // Expected: result = 60, flags = 0

        // --- Test Case 4: Subtraction resulting in Zero (Zero Flag test) ---
        tb_a = 75; tb_b = 75;
        #10; // Expected: result = 0, zero_flag = 1

        // --- Test Case 5: Bitwise AND ---
        tb_alu_sel = 2'b10;
        tb_a = 8'b10101010; tb_b = 8'b11110000;
        #10; // Expected: result = 160 (10100000 in binary)

        // --- Test Case 6: Bitwise OR ---
        tb_alu_sel = 2'b11;
        tb_a = 8'b00001111; tb_b = 8'b11110000;
        #10; // Expected: result = 255 (11111111 in binary)

        // Terminate the simulation
        $finish;
    end

endmodule