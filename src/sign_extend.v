`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: sign_extend 
//
// Description: 
// This module get a 16-bit number and extend the MSB to 32-bit number.
//
// Dependencies: 
// - None -
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////

module sign_extend(src, src_extended);

input signed [15:0] src;

output [31:0] src_extended;

reg signed [31:0] extended;

always@(src) begin
    
    extended <= {{16{src[15]}} ,src};
end

assign src_extended = extended;
endmodule