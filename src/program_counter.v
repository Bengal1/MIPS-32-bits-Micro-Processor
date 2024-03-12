`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: program_counter
// 
// Description: 
// This module is the program counter environment of the micro-processor.
//
// Dependencies: 
// - None -
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////

module program_counter (clk, reset, PCSrc, setAddress, current_pc);

input clk;
input reset;
input PCSrc;
input [31:0] setAddress;

output [31:0] current_pc;
    
reg [31:0] PC;

always @ (posedge clk or posedge reset) begin 
    if (reset) begin 
        PC <= 32'b0;
    end
    else if (PCSrc == 1'b1) begin
        PC <= setAddress;
    end
    else begin 
        PC <= PC + 1;
    end
end

assign current_pc = PC;

endmodule