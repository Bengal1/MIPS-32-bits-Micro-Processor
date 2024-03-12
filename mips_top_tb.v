`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: mips_top_tb
// 
// Description: 
// 
// Dependencies: 
// mips_top.v
// (memory.v, program_counter.v, register_file.v, ALU.v, sign_extend.v, control.v)
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////
`include "mips_top.v"

module mips_top_tb;

reg clk = 0, reset = 0;

mips_top DUT(.clk(clk), .reset(reset));

always #5 clk = ~clk;

integer f,i;

initial begin
    $monitor({"--------------------------------------------------",
    "\ntime : %0t, reset: %b\nPC : %32b\nIR : %32b\n", 
    "Control - ALUOp: %b, DstReg: %b, RegWrite: %b, ALUSrcB: %b, ",
    "BranchTaken: %b, Jump: %b, MemtoReg: %b, MemWrite: %b, JumpReg: %b\n",
    "Reg A = %b , Reg B = %b\nALU result: %b, immediate: %b\n",
    "write data = %32b, PCSrc: %b, setAddress: %b, MemReadData: %b"}, 
    $time, DUT.reset, DUT.current_pc, DUT.instruction_register,  
    DUT.ALUOp, DUT.DstReg, DUT.RegWrite, DUT.ALUSrcB, 
    DUT.BranchCondition, DUT.Jump, DUT.MemtoReg, DUT.MemWrite, DUT.JumpReg, 
    DUT.regA_data_ex, DUT.regB_data_ex,
    DUT.alu_result, DUT.imm_extended,
    DUT.write_data, DUT.PCSrc, DUT.setAddress, DUT.MemReadData);
    
    reset = 1'b1;
    #20;
    reset = 1'b0;

    /*countdown10 test - loop (addi, sub, sw, lw, beq, bne)*/
    $readmemb("Programs/countdown10.mem", DUT.instruction_memory0.mem_array, 0, 9);
    #500;
    f = $fopen("countdown10-memory_image.txt","w");
    for(i = 0; i < 11; i = i + 1)begin 
        $fwrite(f,"%b\n",DUT.data_memory0.mem_array[i]);
    end
    $fclose(f);

    reset = 1'b1;
    #20;
    reset = 1'b0;

    /*alu_op test - alu operations & sw operation*/
    $readmemb("Programs/alu_operations.mem", DUT.instruction_memory0.mem_array, 0, 64);
    #650;
    f = $fopen("alu_operations-memory_image.txt","w");
    for(i = 0; i < 22; i = i + 1)begin 
        $fwrite(f,"%b\n",DUT.data_memory0.mem_array[i]);
    end
    $fclose(f);

    reset = 1'b1;
    #20;
    reset = 1'b0;

    /*jumping_jacks test - jump operations (j, jal, jr, jalr)*/
    $readmemb("Programs/jumping_jacks.mem", DUT.instruction_memory0.mem_array, 0, 30);
    #600;
    f = $fopen("jumping_jacks-memory_image.txt","w");
    $fwrite(f,"%b\n",DUT.data_memory0.mem_array[0]);
    $fclose(f);

    $finish;
end
endmodule