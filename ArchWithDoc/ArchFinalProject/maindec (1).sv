module maindec(input [5:0] op,funct,
			   output memtoreg, memwrite,
			   output branch, bne, alusrc,
			   output regdst, regwrite,
			   output jump, jal, jr, lb, sb, muldiv, mflo, mfhi,
			   output [2:0] aluop);


reg [17:0] controls;


assign {mfhi, mflo, muldiv, sb, lb, bne, jr, jal, regwrite, regdst, alusrc,
branch, memwrite, memtoreg, jump, aluop} = controls;


always @(*)

case(op)

6'b000000: controls <= 18'b000000001100000010; //Rtyp

6'b100011: controls <= 18'b000000001010010000; //LW

6'b101011: controls <= 18'b000000000010100000; //SW

6'b000100: controls <= 18'b000000000001000001; //BEQ

6'b001000: controls <= 18'b000000001010000000; //ADDI

6'b000010: controls <= 18'b000000000000001000; //J

6'b000011: controls <= 18'b000000011000001011; //Jal

6'b001010: controls <= 18'b000000001010000100; //SLTI

6'b000101: controls <= 18'b000001000000000001; //bne

6'b100000: controls <= 18'b000010001010010000; //lb

6'b101000: controls <= 18'b000100000010100000; //sb

6'b000000:
case(funct)
6'b001000 : controls <=  18'b000000100000000010; // jr

6'b011000 : controls <=  18'b001000000000000010; // mul

6'b011010 : controls <=  18'b001000000000000010; // div

6'b010010 : controls <=  18'b010000001100000010; // mflo

6'b010000 : controls <=  18'b100000001100000010; // mfhi

default: controls <= 18'bxxxxxxxxxxxxxxx; //???

endcase

default: controls <= 18'bxxxxxxxxxxxxxxx; //???

endcase


endmodule
