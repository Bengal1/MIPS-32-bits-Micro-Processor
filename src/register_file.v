`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: MIPS 32-bits
// Module Name: register_file
//
// Description: 
// This module is the registers enviroenvironment of the micro-processor.
// 
// Dependencies: 
// - None -
//
// Author: Or Ben-Gal
// 
//////////////////////////////////////////////////////////////////////////////////

/* register file - 32 registers of 32-bit each
    GPR[0]     | $0      | zero (==0), 
    GPR[1]     | $at     | Assembler temporary, 
    GPR[2:3]   | $v0-$v1 | Function return value, 
    GPR[4:7]   | $a0-$a3 | Function parameters,
    GPR[8:15]  | $t0-$t7 | Function temporary values,
    GPR[16:23] | $s0-$s7 | Saved registers across function calls,
    GPR[24:25] | $t8-$t9 | Function temporary values,
    GPR[26:27] | $k0-$k1 | Reserved for interrupt handler,
    GPR[28]    | $gp     | Global pointer,
    GPR[29]    | $sp     | Stack Pointer,
    GPR[30]    | $s8     | Saved register across function calls,
    GPR[31]    | $ra     | Return address from function call. 
*/

module register_file(clk, reset, read_reg1, read_reg2, write_reg, write_data, write_enable, read_data1, read_data2);

    input clk;
    input reset;
    //read registers (sources)
    input [4:0] read_reg1;
    input [4:0] read_reg2;
    //write signals: data & control
    input [4:0] write_reg;
    input [31:0] write_data;
    input write_enable;
    //read registers content
    output [31:0] read_data1; 
    output [31:0] read_data2; 

    //registers array
    reg [31:0] registers [31:0];

    /* read source registers content*/
    assign read_data1 = (read_reg1 == 5'b0) ? 32'b0 : registers[read_reg1];
    assign read_data2 = (read_reg2 == 5'b0) ? 32'b0 : registers[read_reg2];

    integer r;

    always @ (posedge clk /*or posedge reset*/) begin
        if(reset) begin
            for(r = 0; r<32; r=r+1) begin 
                registers[r]<=32'b0;
            end
        end
        else begin
            if (write_enable) begin    //write to register operation
                    registers[write_reg] <= (write_reg == 5'b0)? 32'b0 : write_data;
            end
            else begin                 //when possible make sure R0 == 0;
                    registers[0] <= 32'b0;
            end
        end
    end

endmodule