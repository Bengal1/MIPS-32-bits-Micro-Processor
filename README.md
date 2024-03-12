# Simple-MIPS-32-bits-Micro-Processor
In this repository I have implement in *Verilog* a reduced version of MIPS 32-bit processor, and my references to MIPS will be for 32-bit technology. This implementation is of a *SIngle Cycle MIPS Processor* which means that pipelining is not implemented here, although I have noted the stages in the code. 
<br />MIPS (Microprocessor without Interlocked Pipelined Stages) is a family of reduced instruction set computer (RISC) instruction set architectures (ISA) developed by MIPS Computer Systems, now MIPS Technologies. 
## MIPS Instruction Set Architecture (ISA)
Instruction Set Architecture (ISA) is the set of instructions that a computer processor can understand and execute. These instructions define the operations that the processor can perform, such as arithmetic, logical operations, data movement, etc.

* There are three types (formats) of instruction in MIPS ISAs:


<img src="https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/assets/34989887/d7e85073-e758-4a0a-a3b3-fcaab0bf115e" width="975"/>

* This micro-processor's ISA:

<img src="https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/assets/34989887/46b85ea1-6be3-4ca7-a116-9a9d56dd1506" width="975"/>

## The Processor (Core)

### Processor's ***

### Processor's Diagram

### Processor's Modules

#### Control

#### Register File

#### ALU

#### Memory

## TestBenches
In this repository every module has its testbench to monitor and test the module. The testbenches are present variaty of inputs and states to every module and test them for every state they will face.<br />
The `mips_top_tb` is the testbench of the `mips_top` module, the main module that integrates of the the other sub-modules. In this testbench there are 3 programs that are being written to the instruction memory to test the processor functionality. All the programs are at 'Program' folder and at 'mips_top_tb_references' folder there are the wanted result of each program. 
* CountDown10 ([countdown10.mem](https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/blob/main/Programs/countdown10.mem))<br />
  This program count down from 10 to 0 and store every number in the memory chronologically, meaning 10 will be sored at address 0, 9 will be stored at address 1 and so on. When it's done it start all over again according to the test time and it will keep writing to the same memory addresses. This program test the instructions: addi, sub, sw, lw, beq & bne. 
* ALU_Operations ([alu_operations.mem](https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/blob/main/Programs/alu_operations.mem))<br />
  This program test all ALU instructions and also sw.
* Jumping_Jacks ([jumping_jacks.mem](https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/blob/main/Programs/jumping_jacks.mem))<br />
  This program test all the jump instructions: jr, jalr, j, jal.
## References

