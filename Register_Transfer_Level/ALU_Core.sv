module ALU_Core (
    input wire [7:0] a,          // First 8-bit operand
    input wire [7:0] b,          // Second 8-bit operand
    input wire [1:0] alu_sel,    // Operation selector (2-bit control signal)
    
    // Outputs are declared as 'reg' because they are assigned inside an always block
    output reg [7:0] result,     // 8-bit ALU computation result
    output reg carry_out,        // Carry flag for addition overflow
    output reg zero_flag         // Zero flag (1 if result is 0, otherwise 0)
);

    // Internal 9-bit register to hold addition results and catch the carry bit
    reg [8:0] temp_result;

    // Combinational logic block: triggers whenever any input signal changes
    always @(*) begin
        
        // Default assignments to prevent the synthesis of unintended latches
        carry_out = 0;
        temp_result = 0;
        zero_flag = 0; 

        // Operation decoder based on the selector input
        case (alu_sel)
            2'b00: begin // Operation 0: Addition (a + b)
                temp_result = a + b;
                result = temp_result[7:0];   // Extract the 8-bit sum
                carry_out = temp_result[8];  // Extract the 9th bit as carry out
            end
            
            2'b01: begin // Operation 1: Subtraction (a - b)
                result = a - b;
            end
            
            2'b10: begin // Operation 2: Bitwise AND (a & b)
                result = a & b;
            end
            
            2'b11: begin // Operation 3: Bitwise OR (a | b)
                result = a | b;
            end
            
            default: begin // Fallback case for safety
                result = 8'b00000000;
            end
        endcase

        // Update the Zero flag based on the final result
        if (result == 8'b00000000) begin
            zero_flag = 1;
        end else begin
            zero_flag = 0;
        end

    end

endmodule