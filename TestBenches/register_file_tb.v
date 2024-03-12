`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: register_file
//
// Description: 
// This module is a testbench for register file module
// 
// Dependencies: 
// register_file.v
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////
`include "src/register_file.v"

module register_file_tb;

reg clk = 0, reset = 0,  w_en = 0;
reg [4:0] reg1, reg2, w_reg;
reg [31:0] w_data;

wire [31:0] data1;
wire [31:0] data2;

register_file DUT(.clk(clk), .reset(reset), .read_reg1(reg1), .read_reg2(reg2), .write_reg(w_reg), 
.write_data(w_data), .write_enable(w_en), .read_data1(data1), .read_data2(data2));

always #5 clk = ~clk;

integer r;

initial begin
    $monitor({"--------------------------------------------------",
    "\ntime : %t\nreset : %b\nReg 1 : %b ; Reg 2 : %b Write Reg : %b\n",
    "Write Data : %b ; write enable : %b\nRead Data 1: %b ; Read Data 2 : %b"},
    $time, DUT.reset, DUT.read_reg1, DUT.read_reg2, DUT.write_reg, 
    DUT.write_data, DUT.write_enable, DUT.read_data1, DUT.read_data2);

    reset = 1'b1;
    #20;
    reset = 1'b0;
    #10;
    
    reg1 = 0; reg2 = 1; w_reg = 0; w_en = 1'b0;
    repeat(15) begin
        #10;
        reg1 = reg1 + 2;
        reg2 = reg2 + 2;
    end

    #10;
    reg1 = 0; reg2 = 5; w_reg = 5; w_en = 1'b1;
    w_data = 32'b10101010101010101010101010101010;
    #10;

    w_reg = 1;
    w_data = 32'b00000000000000000000000000000001;
    repeat(31) begin
        #10;
        reg1 = w_reg;
        w_reg = w_reg + 1;
        w_data = w_data * 2;
    end
    #10;
    
    reg1 = w_reg;
    w_reg = 0; w_en = 1'b0;
    #10;

    reg2 = 0;
    #10;

    $finish;
end

endmodule