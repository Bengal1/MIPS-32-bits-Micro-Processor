`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: Simple MIPS 32-bits
// Module Name: mips_top
// 
// Description: 
// This module is the micro-processor's top. 
// 
// Dependencies: 
// memory.v, program_counter.v, register_file.v, ALU.v, sign_extend.v, control.v
// 
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////

`include "src/program_counter.v"
`include "src/memory.v"
`include "src/control.v"
`include "src/register_file.v"
`include "src/sign_extend.v"
`include "src/ALU.v"

 // R-Type
`define opcode      instruction_register[31:26]
`define rs          instruction_register[25:21]
`define rt          instruction_register[20:16]
`define rd          instruction_register[15:11]
`define shamt       instruction_register[10:6]
`define funct       instruction_register[5:0]
// I-Type
`define immediate   instruction_register[15:0]
// J-Type
`define address     instruction_register[25:0]


module mips_top (clk, reset);

input clk, reset;

/*--- IF ---*/
wire [31:0] current_pc;
wire [31:0] instruction_register;

wire PCSrc;
wire [31:0] setAddress;

program_counter pc0 (clk, reset, PCSrc, setAddress, current_pc); 

memory instruction_memory0 (clk, reset, current_pc, 1'b1, 1'b0, 32'b0, instruction_register);

/*--- ID ---*/
wire DstReg, ALUSrcB, RegWrite, MemtoReg, MemWrite, Jump, Branch, shamtFlag, JumpReg;
wire [5:0] ALUOp, op;
wire [4:0] WriteRegister;
wire [31:0] regA_data;
wire [31:0] regB_data;
wire [31:0] write_data;

assign op = (instruction_register)? `opcode : 6'b111111;

control ctrl0 (clk, op, `funct, DstReg, ALUSrcB, RegWrite, MemtoReg, 
MemWrite, Jump, Branch, shamtFlag, JumpReg, ALUOp);

assign WriteRegister = (Jump | Branch)? 5'b11111 : (DstReg)? `rt : `rd; //select WriteReg: r31/rt/rd

register_file gpr0 (clk, reset, `rs, `rt, WriteRegister, write_data, RegWrite, regA_data, regB_data);

/*--- EX ---*/
wire BranchCondition;
wire carry, zero, sign;
wire [31:0] imm_extended;
wire [31:0] regA_data_ex;
wire [31:0] regB_data_ex;
wire [31:0] alu_result;

sign_extend sign_e0 (`immediate, imm_extended);

//set regA & regB
assign regA_data_ex = (shamtFlag)? regB_data : regA_data;
assign regB_data_ex = (shamtFlag)? {27'b0, `shamt} : (ALUSrcB)? imm_extended : regB_data;

ALU alu0 (ALUOp, regA_data_ex, regB_data_ex, alu_result, carry, zero, sign);

assign BranchCondition = Branch & (zero ^ instruction_register[26]);

/*--- MEM ---*/
wire [31:0] MemReadData;

memory data_memory0 (clk, reset, regA_data_ex, MemtoReg, MemWrite, regB_data_ex, MemReadData);

/*--- WB ---*/ 
assign PCSrc = (Jump | BranchCondition | JumpReg)? 1'b1 : 1'b0;
assign write_data = (Jump | BranchCondition | JumpReg)? current_pc + 1 : (MemtoReg)? MemReadData : alu_result;
assign setAddress = (BranchCondition)? imm_extended : (Jump)? {current_pc[31:26], `address} : (JumpReg)? alu_result: current_pc + 1; 

endmodule