# Simple-MIPS-32-bits-Micro-Processor
In this repository I have implement in *Verilog* a reduced version of MIPS 32-bit processor, and my references to MIPS will be for 32-bit technology. This implementation is of a *SIngle Cycle MIPS Processor* which means that pipelining is not implemented here, although I have noted the stages in the code. 
<br />MIPS (Microprocessor without Interlocked Pipelined Stages) is a family of reduced instruction set computer (RISC) instruction set architectures (ISA) developed by MIPS Computer Systems, now MIPS Technologies. 
## MIPS Instruction Set Architecture (ISA)
Instruction Set Architecture (ISA) is the set of instructions that a computer processor can understand and execute. These instructions define the operations that the processor can perform, such as arithmetic, logical operations, data movement, etc.

### **There are three types (formats) of instruction in MIPS ISAs:**

<img src="https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/assets/34989887/d7e85073-e758-4a0a-a3b3-fcaab0bf115e" width="975"/>

### **This micro-processor's ISA:**

<img src="https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/assets/34989887/46b85ea1-6be3-4ca7-a116-9a9d56dd1506" width="975"/>

## The Processor (Core's Design)


### Processor's Diagram

![MIPs_diagram](https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/assets/34989887/b1539d99-9b71-4f62-ba90-ce8a702f0fb4)

### Design's Modules

#### Program Counter

#### Control

#### Register File
A register file is an array of processor registers in a central processing unit (CPU). The instruction set architecture of a CPU will almost always define a set of registers which are used to stage data between memory and the functional units on the chip. MIPS processors have 32 registers, each of which holds a 32-bit value. — Register addresses are 5 bits long. — The data inputs and outputs are 32-bits wide.


**These are the registers in MIPS architecture:** <br />
<img src="https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/assets/34989887/62abd3a7-60bf-43a4-9b17-d44c0cfde0b7"  width="500"/>
* $zero ($0) - The *Zero* register always contains a value of 0.
* $at - The *Assembler Temporary* (at) register is used for temporary values within pseudo commands.
* $v - The $v Registers are used for returning values from functions.
* $a - The $a registers are used for passing arguments to functions.
* $t - The temporary registers are used by the assembler to store intermediate values.
* Global Pointer ($gp) - Usually stores a pointer to the global data area.
* Stack Pointer ($sp) - Used to store the value of the stack pointer.
* Frame Pointer ($fp) - Used to store the value of the frame pointer.
* Return Address ($ra) - Stores the return address (the location in the program that a function needs to return to).


#### ALU

**The ALU Operations:**
* Arithmetic Operation:<br/>
  Addition (add), Unsigned Addition (addu), Subtraction (sub), Unsigned Subtraction (subu).
* Logic Operations:<br/>
  AND, OR, XOR, NOR.
* Shift Operations:<br/>
  Logical Left Shift (sll), Logical Right Shift (srl), Arithmetic Right Shift (sra).
* Comparison Operations:<br/>
  Set Less Than (slt), Set Less Than Unsigned (sltu).
  

#### Memory
The memory in this design is *RAM* type, a memory characterized by the ability of the processor to directly access, write, and read from each cell in memory according to its address, and specifically *Cache Memory*, component that stores data so that future requests for that data can be served faster.<br />
As it can be seen, I have split the memory to two sections: *Instruction Memory* and *Data Memory*. The seperation is for convenience, and can be manged otherwise, for example using one memory module that manged by the processor's pointers.<br />
In this design the memory depth is 65,536 words ($`2^{16}`$), 32 bit each word, meaning the volume of the memory is 64Kb  or 8KB.<br/>
This memory can mange in single access one read, one write or read & write, nevertheless the instruction would not support the last option in high clock frequency.

## TestBenches
In this repository every module has its testbench to monitor and test the module. The testbenches are present variaty of inputs and states to every module and test them for every state they will face.<br />
The `mips_top_tb` is the testbench of the `mips_top` module, the main module that integrates of the the other sub-modules. In this testbench there are 3 programs that are being written to the instruction memory to test the processor functionality. All the programs are at *'Program'* folder and at *'mips_top_tb_references'* folder there are the wanted result of each program. 
* CountDown10 ([countdown10.mem](https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/blob/main/Programs/countdown10.mem))<br />
  This program count down from 10 to 0 and store every number in the memory chronologically, meaning 10 will be sored at address 0, 9 will be stored at address 1 and so on. When it's done it start all over again according to the test time and it will keep writing to the same memory addresses.<br />This program test the instructions: `addi`, `sub`, `sw`, `lw`, `beq` & `bne`. 
* ALU_Operations ([alu_operations.mem](https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/blob/main/Programs/alu_operations.mem))<br />
  This program executes all the ALU operations and stores the results in memory.<br />This program test all ALU instructions:`add`, `addu`, `sub`, `subu`, `and`, `or`, `xor`, `nor`, `slt`, `sltu`, `sll`, `srl`, `sra`, `sllv`, `srlv`, `srav`, `addi`, `addiu`, `andi`, `ori`, `xori`, `slti`, `sltiu` and also sw.
* Jumping_Jacks ([jumping_jacks.mem](https://github.com/Bengal1/Simple-MIPS-32-bits-Micro-Processor/blob/main/Programs/jumping_jacks.mem))<br />
  This program jump from address to address circularly, return in the end to the first jump instruction address, and in every cycle write to memory the number of cycles been done, such that in the end of the run time the memory stores the number of cycles.<br />This program test all the jump instructions: `jr`, `jalr`, `j`, `jal`.
## References
[WORLD OF ASIC](https://www.asic-world.com/)

[Organization of Computers,  M.S. Schmalz, University of Florida](https://www.cise.ufl.edu/~mssz/CompOrg/PatHen-Readings.html#ExSec4.0)
