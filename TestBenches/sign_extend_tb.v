`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: sign_extend_tb
//
// Description: 
// This module is a testbench for sign extend module.
// 
// Dependencies: 
// sign_extend.v
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////
`include "src/sign_extend.v"

module sign_extend_tb;

reg [15:0] src; 

wire [31:0] extended;

sign_extend DUT (.src(src), .src_extended(extended));

initial begin
    $monitor({"--------------------------------------------------",
    "\ntime : %0t\nsrc : %b ; src decimal : %d\n",
    "src_extend : %b ; src_extended decimal : %d"}, 
    $time, DUT.src, DUT.src, DUT.src_extended, DUT.extended);

    src = 16'b1111111111111111;
    #10;
    src = 16'b0111111111111111;
    #10;
    src = 16'b1000000000000000;
    #10;
    src = 16'b0000000000000000;
    #10;
    src = 16'b0000000000000001;
    #10;
    
    repeat(16) begin
        src = src * 2;
        #10; 
    end

    $finish;
end

endmodule