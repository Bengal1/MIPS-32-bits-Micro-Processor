`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: program_counter_tb
//
// Description: 
// This module is a testbench for program counter module.
//
// Dependencies: 
// program_counter.v
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////
`include "src/program_counter.v"

module program_counter_tb;

reg clk = 0, reset, src;
reg [31:0] address_in;

wire [31:0] pc_out;

program_counter DUT (.clk(clk), .reset(reset), .PCSrc(src), .setAddress(address_in), 
.current_pc(pc_out));

always #5 clk = ~clk;

initial begin
    $monitor({"--------------------------------------------------",
    "\ntime : %t\nreset : %b\nPCSrc : %b ; setAddress : %b\nPC : %b"}, 
    $time, DUT.reset, DUT.PCSrc, DUT.setAddress, pc_out);
    
    reset = 1'b1;
    #20;
    reset = 1'b0;
    #20;
    reset = 1'b1;
    #20;
    reset = 1'b0;
    #20;

    src = 1'b1; address_in = 32'b00000000000000000000000001000000;
    #10;
    src = 1'b0;
    #100;

    reset = 1'b1;
    #10;
    reset = 1'b0;
    #100;

    src = 1'b1; address_in = 32'b0010000000000000000000000000000;
    #10;
    src = 1'b0;
    #50;

    address_in = 32'b0010000000000000000000000000000;
    #5;
    src = 1'b1; 
    #10;
    src = 1'b0;
    #1000;

    $finish;
end

endmodule