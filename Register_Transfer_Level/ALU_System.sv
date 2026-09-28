// ==========================================
// Top Level Module: ALU System
// ==========================================
module ALU_System (
    input wire clk,             // System Clock
    input wire reset,           // System Reset
    input wire [7:0] in_a,      // Input data for A
    input wire [7:0] in_b,      // Input data for B
    input wire [1:0] op_sel,    // Operation selector
    
    output wire [7:0] out_result, // Final registered output
    output wire out_carry,        // Registered carry flag
    output wire out_zero          // Registered zero flag
);

    // --- Internal Wires (The "cables" connecting components) ---
    wire [7:0] wire_a_to_alu;
    wire [7:0] wire_b_to_alu;
    wire [7:0] wire_alu_to_out;
    wire [1:0] wire_op_to_alu;
    wire wire_alu_carry;
    wire wire_alu_zero;

    // --- 1. Input Register A ---
    Register8bit regA (
        .clk(clk),
        .reset(reset),
        .d(in_a),             // Takes external input
        .q(wire_a_to_alu)     // Sends it to the ALU
    );

    // --- 2. Input Register B ---
    Register8bit regB (
        .clk(clk),
        .reset(reset),
        .d(in_b),             // Takes external input
        .q(wire_b_to_alu)     // Sends it to the ALU
    );
    Register2bit regOp (
     .clk(clk),
     .reset(reset),
     .d(op_sel),
     .q(wire_op_to_alu)
);

    // --- 3. The ALU Core ---
    ALU_Core alu_unit (
        .a(wire_a_to_alu),    // Takes data from Register A
        .b(wire_b_to_alu),    // Takes data from Register B
        .alu_sel(wire_op_to_alu),     // Operation selector
        .result(wire_alu_to_out), // Sends result to output register
        .carry_out(wire_alu_carry),    // Sends carry flag to output register
        .zero_flag(wire_alu_zero)      // Sends zero flag to output register
    );

    // --- 4. Output Register ---
    Register8bit regOut (
        .clk(clk),
        .reset(reset),
        .d(wire_alu_to_out),  // Takes result from ALU
        .q(out_result)        // Sends to final system output
    );
   // --- 5. Output Flag Registers ---
   Register1bit regCarry (
       .clk(clk),
       .reset(reset),
       .d(wire_alu_carry),
       .q(out_carry)
);

   Register1bit regZero (
     .clk(clk),
     .reset(reset),
     .d(wire_alu_zero),
     .q(out_zero)
);

endmodule