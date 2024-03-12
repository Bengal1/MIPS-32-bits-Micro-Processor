`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: ALU_tb
//  
// Description: 
// This module is a testbench for ALU module. 
//
// Dependencies: 
// ALU.v 
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////
`include "src/ALU.v"

module ALU_tb;

reg [5:0] op;
reg [31:0] A, B;

wire c_o, zero, sign;
wire signed [31:0] res;

ALU DUT (.operation(op), .operandA(A), .operandB(B), .result_out(res), .carry(c_o), 
.zero(zero), .sign(sign));

initial begin
    $monitor({"--------------------------------------------------",
    "\ntime : %t\nOperation : %b\nA : %b ; B : %b\n",
    "Result: %b ; Carry: %b ; Zero: %b ; Sign: %b\n",
    "Decimal: A = %d , B = %d , signed result: %d , unsigned result: %d"}, 
    $time, DUT.operation, DUT.operandA, DUT.operandB, DUT.result, DUT.carry, 
    DUT.zero, DUT.sign, DUT.signed_operandA, DUT.signed_operandB, res, DUT.result);
    
    $display("----------------\nOperation: add\n----------------");
    op = 6'b100000; A = -1; B = -1;
    #10
    op = 6'b100000; 
    A = 32'b01111111110111111101111111111111; B = 32'b01111111101111111110111011101111;
    #10
    op = 6'b100000; A = -10000; B = 63629;
    #10
    $display("----------------\nOperation: addu\n----------------");
    op = 6'b100001; A = 32'b0; B = 32'b0;
    #10
    op = 6'b100001; A = -1; B = -9;
    #10
    op = 6'b100001; A = 10000; B = 63629;
    #10
    $display("----------------\nOperation: sub\n----------------");
    op = 6'b100010; A = 32'b0; B = 32'b0;
    #10
    op = 6'b100010; A = 161718; B = 333;
    #10
    op = 6'b100010; A = 100000; B = 63629;
    #10
    op = 6'b100010; A = 1000; B = 63629;
    #10
    $display("----------------\nOperation: subu\n----------------");
    op = 6'b100011; A = 32'b0; B = 32'b0;
    #10
    op = 6'b100011; A = 161718; B = 333;
    #10
    op = 6'b100011; A = 100000; B = 63629;
    #10
    op = 6'b100011; A = 1000; B = 63629;
    #10
    $display("----------------\nOperation: and\n----------------");
    op = 6'b100100; 
    A = 32'b11111111111111111111111111111111; B = 32'b00000000000000000000000000000000;
    #10
    op = 6'b100100; 
    A = 32'b11110000111100001111000011110000; B = 32'b11111111111111111111111111111111;
    #10
    op = 6'b100100; 
    A = 32'b00000000000000001111111111111111; B = 32'b11111111111111111111111111111111;
    #10
    $display("----------------\nOperation: or\n----------------");
    op = 6'b100101; 
    A = 32'b11111111111111111111111111111111; B = 32'b11111111111111111111111111111111;
    #10
    op = 6'b100101; 
    A = 32'b11111111111111111111111111111111; B = 32'b00000000000000000000000000000000;
    #10
    op = 6'b100101; 
    A = 32'b11111111111111111111111111111111; B = 32'b11111111111111111111111111111111;
    #10
    $display("----------------\nOperation: xor\n----------------");
    op = 6'b100110; 
    A = 32'b11111111111111111111111111111111; B = 32'b11111111111111111111111111111111;
    #10
    op = 6'b100110; 
    A = 32'b11111111111111111111111111111111; B = 32'b00000000000000000000000000000000;
    #10
    op = 6'b100110; 
    A = 32'b00000000000000001111111111111111; B = 32'b11111111111111111111111111111111;
    #10
    $display("----------------\nOperation: nor\n----------------");
    op = 6'b100111; 
    A = 32'b11111111111111111111111111111111; B = 32'b11111111111111111111111111111111;
    #10
    op = 6'b100111; 
    A = 32'b11111111111111111111111111111111; B = 32'b00000000000000000000000000000000;
    #10
    op = 6'b100111; 
    A = 32'b00000000000000001111111111111111; B = 32'b00000000000000000000000000000000;
    #10
    $display("----------------\nOperation: slt\n----------------");
    op = 6'b101010; A = 0; B = 1;
    #10
    op = 6'b101010; A = 1; B = 1;
    #10
    op = 6'b101010; A = -1; B = 1;
    #10
    $display("----------------\nOperation: sltu\n----------------");
    op = 6'b101011; A = 0; B = 1;
    #10
    op = 6'b101011; A = 1; B = -1;
    #10
    op = 6'b101011; A = -100; B = 1;
    #10
    $display("----------------\nOperation: sll\n----------------");
    op = 6'b000000; A = 1; B = 1;
    #10
    op = 6'b000000; A = 1; B = 24;
    #10
    op = 6'b000000; A = -1; B = 3;
    #10
    $display("----------------\nOperation: srl\n----------------");
    op = 6'b000010; A = -1; B = 3;
    #10
    op = 6'b000010; A = 16; B = 3;
    #10
    op = 6'b000010; A = 2147483648; B = 20;
    #10
    $display("----------------\nOperation: sra\n----------------");
    op = 6'b000011; A = -1; B = 6;
    #10
    op = 6'b000011; A = 16; B = 3;
    #10
    op = 6'b000011; A = 2147483648; B = 20;
    #10
    $display("----------------\nUnvalid opcodes\n----------------");
    op = 6'b011011; 
    A = 32'b11110000111100001111000011110000; B = 32'b11111111111111111111111111111111;
    #10
    op = 6'b001010;
    #10
    op = 6'b111111;
    #20

    $finish;
end


endmodule