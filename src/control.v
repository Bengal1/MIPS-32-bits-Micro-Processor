`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: control
// 
// Description: 
// This module is th control unit of the micro-processor.
// 
// Dependencies: 
// - None -
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////

/*Control Output Signals | Description 
* DstReg                 | select destination register (WB)
* ALUSrcB                | select ALU source
* RegWrite               | enable write back to register file 
* MemtoReg               | select source of write back ALU/memory & enable memory read
* MemWrite               | enable memory write
* Jump                   | indicate jump operation - j, jal
* Branch                 | indicate branch operation - beq, bne
* shamtFlag              | indicate the use of shamt section - sll, srl, sra
* JumpReg                | indicate jump register operation - jr, jalr
* ALUOp                  | control signals for ALU_control
*/

module control (clk, Opcode, funct, DstReg, ALUSrcB, RegWrite, MemtoReg, MemWrite, Jump, Branch, shamtFlag, JumpReg, ALUOp);

input clk;
input [5:0] Opcode;
input [5:0] funct;

output DstReg, ALUSrcB, RegWrite, MemtoReg, MemWrite, Jump, Branch, shamtFlag, JumpReg;
output [5:0] ALUOp;

reg [5:0] ALUOp_t;

assign DstReg = !(Opcode == 6'b0); //R-type
assign ALUSrcB = (Opcode != 6'b0) && (Opcode[5:1] != 5'b00010) && ((Opcode[5:4] != 2'b10) && (Opcode[2:0] != 3'b011));
assign RegWrite = !(((Opcode == 6'b0)&&(funct == 6'b001000))||(Opcode == 6'b101011)||(Opcode == 6'b000010));
assign MemtoReg = (Opcode == 6'b100011);
assign MemWrite = (Opcode == 6'b101011);
assign Jump = (Opcode[5:1] == 5'b00001);
assign Branch = (Opcode[5:1] == 5'b00010);
assign shamtFlag = (Opcode == 6'b0) && (funct[5:2] == 4'b0);
assign JumpReg = (Opcode == 6'b0) && (funct[5:1] == 5'b00100);

always@(*) begin 
    casex ({Opcode, funct})
        {6'b0     , 6'b0001xx}: ALUOp_t = funct & 6'b111011; //sllv, srlv, srav
        {6'b0     , 6'b00100x}: ALUOp_t = 6'b100000; //jr, jalr
        {6'b0     , 6'bx     }: ALUOp_t = funct; //R-type
        {6'b00101x, 6'bx     }: ALUOp_t = Opcode + 6'b100000; //slti, sltiu
        {6'b001xxx, 6'bx     }: ALUOp_t = (Opcode & 6'b110111) + 6'b100000; //I-type
        {6'b00010x, 6'bx     }: ALUOp_t = 6'b100010; //branch
        
        default: ALUOp_t = 6'b111111;
    endcase
end

assign ALUOp = ALUOp_t;

endmodule
