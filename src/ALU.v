`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: ALU
//  
// Description: 
// This module is the arithmetic logic unit (ALU) of the micro-processor.
// 
// Dependencies: 
// - None -
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////

// Operations - add, addu, sub, subu, and, or, xor, nor, slt, sltu, sll, srl, sra
// Control signals - carry, zero, sign

module ALU (operation, operandA, operandB, result, carry, zero, sign);

input clk;
input [5:0] operation;
input [31:0] operandA;
input [31:0] operandB;

output [31:0] result;
output carry, zero, sign;

reg [31:0] res;
reg c_o, ze, s;

reg signed [31:0] signed_operandA, signed_operandB;

parameter add = 6'b100000, addu = 6'b100001, sub = 6'b100010, subu = 6'b100011, 
and_op = 6'b100100, or_op = 6'b100101, xor_op = 6'b100110, nor_op = 6'b100111, 
slt = 6'b101010, sltu = 6'b101011, sll = 6'b000000, srl = 6'b000010, sra = 6'b000011;

always @ (*) begin
    
    signed_operandA <= operandA;
    signed_operandB <= operandB;

    case(operation)
    add: {c_o, res} = signed_operandA + signed_operandB;
    addu: {c_o, res} = operandA + operandB;
    sub: {c_o, res} = signed_operandA - signed_operandB;
    subu: {c_o, res} = operandA - operandB;

    and_op: res = operandA & operandB;
    or_op: res = operandA | operandB;
    xor_op: res = operandA ^ operandB;
    nor_op: res = operandA ~| operandB;
    
    slt: res = (signed_operandA < signed_operandB)? 32'b1 : 32'b0;
    sltu: res = (operandA < operandB)? 32'b1 : 32'b0;
    
    sll: res = operandA << operandB;
    srl: res = operandA >> operandB;
    sra: res = signed_operandA >>> operandB;
    
    default: {c_o, res} = 33'b0;
    endcase
end

assign result = res;
assign carry = c_o; 
assign zero = ~(|result); 
assign sign = result[31];

endmodule
