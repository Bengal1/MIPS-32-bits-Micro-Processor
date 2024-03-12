# Simple-MIPS-32-bits-Micro-Processor
Simple MIPS 32-bits Micro-Processor



No.	T	Name	Binary command	Action
1	R	add	000000	rs	rt	rd	00000 100000	rd←rs+rt
2		addu	000000	rs	rt	rd	00000 100001	rd←rs+rt
3		sub	000000	rs	rt	rd	00000 100010	rd←rs-rt
4		subu	000000	rs	rt	rd	00000 100011	rd←rs-rt
5		and	000000	rs	rt	rd	00000 100100	rd←rs & rt
6		or	000000	rs	rt	rd	00000 100101	rd←rs | rt
7		xor	000000	rs	rt	rd	00000 100110	rd←rs ^ rt
8		nor	000000	rs	rt	rd	00000 100111	rd←rs ~| rt
9		slt	000000	rs	rt	rd	00000 101010	rd←(rs<rt)?1:0
10		sltu	000000	rs	rt	rd	00000 101011	rd←(rs<rt)?1:0
11		sll	000000	00000	rt	rd	 sa   000000	rd←rt≪sa
12		srl	000000	00000	rt	rd	 sa   000010	rd←rt≫sa
13		sra	000000	00000	rt	rd	 sa   000011	rd←rt>>>sa
14		sllv	000000	rs	rt	rd	00000 000100	rd←rs≪rt
15		srlv	000000	rs	rt	rd	00000 000110	rd←rs≫rt
16		srav	000000	rs	rt	rd	00000 000111	rd←rs>>>rt
17		jr	000000	rs	00000	00000	00000 001000	PC = rs
18		jalr	000000	rs	00000	rd	00000 001001	PC=rs;rd=ra
19	I	addi	001000	rs	rt	immediate	rt←rs+imm
20		addiu	001001	rs	rt	immediate	rt←rs+imm
21		andi	001100	rs	rt	immediate	rt←rs & imm
22		ori	001101	rs	rt	immediate	rt←rs | imm
23		xori	001110	rs	rt	immediate	rt←rs ^ imm
24		lw	100011	rs	rt	immediate	rt←Memory[rs+imm]
25		sw	101011	rs	rt	immediate	Memory[rs+imm]←rt
26		beq	000100	rs	rt	immediate	PC=(rs-rt=0)?imm:PC+1
27		bne	000101	rs	rt	immediate	PC=(rs-rt≠0)?imm:PC+1
28		slti	001010	rs	rt	immediate	rt←(rs<imm)?1:0
29		sltiu	001011	rs	rt	immediate	rt←(rs<imm)?1:0
30	J	j	000010	target address	PC = target address
31		jal	000011	target address	PC = target address; r31=ra
