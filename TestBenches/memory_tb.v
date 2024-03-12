`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: memory
//
// Description: 
// This module is a testbench for the memory module.
// 
// Dependencies: 
// memory.v 
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////
`include "src/memory.v"

module memory_tb;

reg clk = 0, reset, r_en, w_en;
reg [31:0] address;
reg [31:0] w_data;

wire [31:0] r_data;

memory DUT (.clk(clk), .reset(reset), .access_address(address), .read_enable(r_en), 
.write_enable(w_en), .write_data(w_data), .read_data(r_data));

always #5 clk = ~clk;

initial begin
    $monitor({"--------------------------------------------------",
    "\ntime : %t\nreset : %b\n",
    "Address : %b ; read enable : %b ; write enable : %b\n",
    "write data : %b\nread data : %b"}, 
    $time, DUT.reset, 
    DUT.access_address, DUT.read_enable, DUT.write_enable, 
    DUT.write_data, DUT.read_data);

    reset = 1'b1;
    #20;
    reset = 1'b0;
    #10;

    address = 32'b00000000000000000000000000000001;
    w_data  = 32'b10000000000000000000000000000000;
    w_en = 1'b1; r_en = 1'b0;

    repeat(16) begin
        #10;
        address = address * 2;
        w_data  = w_data / 2;
    end
    #10;

    address = 32'b00000000000000000000000000000001;
    w_en = 1'b0; r_en = 1'b1;

    repeat(16) begin
        #10;
        address = address * 2;
    end
    #10;

    w_en = 1'b0; r_en = 1'b0;
    #10

    $finish;
end

endmodule