# 8-Bit Pipelined ALU in Verilog

## Overview
This repository contains the RTL design and verification testbenches for a custom 8-bit Arithmetic Logic Unit (ALU). 
The project demonstrates fundamental digital logic design principles, including combinational logic for arithmetic/logical 
operations and sequential logic for data synchronization using pipeline registers.

## Features
* **Core Operations:** Addition, Subtraction (Two's complement), Bitwise AND, Bitwise OR.
* **Status Flags:** 
  * `Zero Flag`: Indicates if the result of an operation is strictly zero.
  * `Carry Out`: Catches overflow during addition.
* **Pipelined Architecture:** Includes 8-bit D-flip-flop registers at both the inputs and the output to stabilize data and prevent combinational glitches. 
The system operates with a pipeline latency of 2 clock cycles.
* **Hardware-Safe Design:** Combinational blocks (`always @*`) are fully specified with default values to prevent unintended latch inference.

## Module Hierarchy
1. `ALU_System.sv` (Top Level) - Integrates the input/output registers with the central computational core.
2. `ALU_Core.sv` - Purely combinational block handling the mathematical and logical routing.
3. `Register8bit.sv` - Synchronous data storage triggered on `posedge clk`.

## Simulation & Verification
The design was verified using **Icarus Verilog**. The testbenches include comprehensive coverage for:
* Standard mathematical operations and bitwise masking.
* Edge cases such as arithmetic overflow (modulus 256 behavior) and zero-flag triggers.
* Pipeline synchronization and clock cycle delays.

## About the Developer
Created by Tal Wirt, a third-year Electrical Engineering and Computer Science undergraduate student at The Hebrew University of Jerusalem.
This project was developed to strengthen my foundational understanding of hardware description languages and CPU datapath components.
