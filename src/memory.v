`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: memory
// 
// Description: 
// This module is a random access memory (RAM) 64Kb module.
//
// Dependencies: 
// - None -
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////

module memory(clk, reset, access_address, read_enable, write_enable, write_data, read_data);
    
    input clk, reset;
    input [31:0] access_address; 
    input read_enable, write_enable; 
    input [31:0] write_data;

    output [31:0] read_data;

    /* Data memory - word size : 32 bit (4 byte), memory depth : 65,536 words (2^16), memory volume : 64Kb (8KB) */
    reg [31:0] mem_array [65535:0];

    reg [15:0] addr;
    reg [31:0] read_reg;

    integer m;

    always @ (posedge clk or posedge reset) begin
        addr = access_address[15:0];

        if (reset) begin
             for (m = 0; m < 65535; m = m + 1) begin 
                mem_array[m] <= 32'b0;
            end
        end
        else begin
            if (write_enable) begin 
                mem_array[addr] <= write_data;
            end 
        end
    end
    assign read_data = (read_enable)? mem_array[addr] : 32'b0;
endmodule