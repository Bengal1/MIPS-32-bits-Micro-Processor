`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: control_tb
// 
// Description: 
// This module is a testbench for the control module. 
//
// Dependencies: 
// control.v 
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////
`include "src/control.v"

module control_tb;

reg clk = 0;
reg [5:0] opcode;
reg [5:0] funct;

wire dst_reg, alu_src_b, reg_write, mem_reg, mem_write, jump, branch, shamt, jr;
wire [5:0] aluop;

control DUT (.clk(clk), .Opcode(opcode), .funct(funct),.DstReg(dst_reg), .ALUSrcB(alu_src_b), 
.RegWrite(reg_write), .MemtoReg(mem_reg), .MemWrite(mem_write), .Jump(jump), .Branch(branch), 
.shamtFlag(shamt), .JumpReg(jr), .ALUOp(aluop));

always #5 clk = ~clk;

initial begin
    $monitor({"--------------------------------------------------",
    "\ntime: %t\nOpcode: %b, funct: %b\n",
    "DstReg: %b, ALUSrcB: %b, RegWrite: %b, MemtoReg: %b, MemWrite: %b, ",
    "Jump: %b, Branch: %b, shamtFlag: %b, JumpReg: %b\n",
    "ALUOp: %b"}, 
    $time, DUT.Opcode, DUT.funct, 
    DUT.DstReg, DUT.ALUSrcB, DUT.RegWrite, DUT.MemtoReg, DUT.MemWrite, 
    DUT.Jump, DUT.Branch, DUT.shamtFlag, DUT. JumpReg, 
    DUT.ALUOp);
    
    //R-type
    opcode = 6'b000000;
    funct = 6'b100000; //add
    #10;
    funct = 6'b100010; //sub
    #10;
    funct = 6'b100110; //xor
    #10;
    funct = 6'b000000; //sll
    #10;
    funct = 6'b000110; //srlv
    #10;
    funct = 6'b001000; //jr
    #10;
    //I-type
    opcode = 6'b001000; //addi
    funct = 6'b000000;
    #10;
    opcode = 6'b001001; //addiu
    #10;
    opcode = 6'b100000; //fake opcode
    #10;
    opcode = 6'b001100; //andi
    #10;
    opcode = 6'b001101; //ori
    #10;
    opcode = 6'b111111; //fake opcode
    #10;
    opcode = 6'b001110; //xori
    #10;
    opcode = 6'b001111; //lui
    #10;
    opcode = 6'b100011; //lw
    #10;
    opcode = 6'b110000; //fake opcode
    #10;
    opcode = 6'b101011; //sw
    #10;
    opcode = 6'b000100; //beq
    #10;
    opcode = 6'b000101; //bne
    #10;
    opcode = 6'b001010; //slti
    #10;
    opcode = 6'b000001; //fake opcode
    #10;
    opcode = 6'b001011; //sltiu
    #10;
    //J-type
    opcode = 6'b000010; //j
    #10;
    opcode = 6'b000011; //jal
    #10;
    opcode = 6'b101010; //fake opcode
    #10;

    $finish;
end

endmodule