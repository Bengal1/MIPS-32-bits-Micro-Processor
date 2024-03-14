# Simple-MIPS-32-bits-Micro-Processor
In this repository I have implement in *Verilog* a reduced version of MIPS 32-bit processor, and my references to MIPS will be for 32-bit technology. This implementation is of a *Single Cycle MIPS Processor* which means that pipelining is not implemented here, although I have noted the stages in the code. 
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

## Design's Modules

### Register File
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


### Arithmetic Logic Unit (ALU)
An arithmetic logic unit (ALU) is a digital circuit used to perform arithmetic and logic operations. It represents the fundamental building block of the central processing unit (CPU) of a computer.<br/>
In this design the ALU gets as inputs `operand A, operand B, operation` and outputs `result, zero, carry, sign`. The zero bit is up when the result is zero (32'b0), the carry bit is arithmetic carry fot arithmrtic operations, and sign bit indicates the sign of the result (given the result is signed). 

**The ALU Operations:**
* ****Arithmetic Operation:**** <br/>
  Addition (add), Unsigned Addition (addu), Subtraction (sub), Unsigned Subtraction (subu).<br/>
  Our Arithmetic oprators are Addition and Subtraction performed on a signed or an unsigned number.<br/>
  ***Operation on Signed Value*** - usually in [two's complement format](https://en.wikipedia.org/wiki/Two%27s_complement), has a sign bit (MSB - 1 negative and 0 positive) and the opration on it should make arithmetic sense, meaning when the number of bits are extended with the sign bit to preserve the value.For that reason when the result overflows th number will not make arithmetic sense anymore. The range of values in signed 32-bit representation is: -2,147,483,648 to 2,147,483,647.<br/>
  ***Operation on Unsigned Value*** - Unlike in the case of a signed number, Unsigned number assumed to be positive, and therefore will make arithmetic sense in addition and subtraction, but can never be negative (in subtraction), meaning when overflow occurs the result is practically cropped. The range of values in unsigned 32-bit representation is: 0 to 4,294,967,296.
* ****Logic Operations:**** <br/>
  AND, OR, XOR, NOR.<br/>
  Logic operator in a simple manner is a function that operate on a binary variable, variable with 2 possible values. in verilog logic operation are perform bitwise, reductive (logic tree that reduced to 1 bit) or on a number value (zero and non-zero).
  In this design the logic operations are bitwise, meaning operates on a bit string (or vector) at the level of its individual bits.<br/>
  For more information: [Boolean Algebra](https://en.wikipedia.org/wiki/Boolean_algebra) or [Logical Connective](https://en.wikipedia.org/wiki/Logical_connective).
* ****Shift Operations:**** <br/>
  Logical Left Shift (sll), Logical Right Shift (srl), Arithmetic Right Shift (sra).<br/>
  Shift is a bitwise operation that shifts all the bits of its operand in the wanted direction (left/right) a given amount.<br/>
  ***Logical Shift*** - every bit in the operand is simply moved a given number of bit positions, and the vacant bit-positions are filled with zeros.<br/>
  ***Arithmetic Shift*** - every bit in the operand is moved a given number of bit positions, when shifting to the right, the leftmost bit (sign bit) is replicated to fill in all the vacant positions, and when shifting to the left vacant positions filled with zeros.
* ****Comparison Operations:**** <br/>
  Set Less Than (slt), Set Less Than Unsigned (sltu).<br/>
  In both operation operand A and operand B are compared and if operand A is samller than operand B the ALU set the result to be *True* (32'b1) else, the ALU set the result to be *False* (32'b0).
  

### Memory
The memory in this design is *RAM* type, a memory characterized by the ability of the processor to directly access, write, and read from each cell in memory according to its address, and specifically *Cache Memory*, component that stores data so that future requests for that data can be served faster.<br />
As it can be seen, I have split the memory to two sections: *Instruction Memory* and *Data Memory*. The seperation is for convenience, and can be manged otherwise, for example using one memory module that manged by the processor's pointers.<br />
In this design the memory depth is 65,536 words ($`2^{16}`$), 32 bit each word, meaning the volume of the memory is 64Kb  or 8KB.<br/>
This memory can mange in single access one read, one write or read & write, nevertheless the instruction would not support the last option in high clock frequency.


### Control
The Control module is the component that decode the instruction and direct the other components in accordance with it. The control uses the control signal in order to direct the other modules in what manner to operate.<br/>

****The Control Signals:****
* `DstReg` - Select destination register `rt`/`rd` (WB).
* `ALUSrcB` - Select ALU source for operand B.
* `RegWrite` - Enable write back to register file. 
* `MemtoReg` - Selects source of write back to register file, ALU/Memory, and enable memory read.
* `MemWrite` - Enable memory write.
* `Jump` - Indicate jump operation - `j`, `jal`
* `Branch` - Indicate branch operation - `beq`, `bne`.
* `shamtFlag` - Indicate the use of shamt field in the instruction - `sll`, `srl`, `sra`.
* `JumpReg` - Indicate jump register operation - `jr`, `jalr`.
* `ALUOp` - Directs the ALU with operation to perform. See 'ALU'.



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
