module aludec(input [5:0] funct,
			  input [2:0] aluop,
			  output reg [3:0] alucontrol);



always @(*)
case(aluop)
3'b000: alucontrol <= 4'b0010; 
// add
3'b001: alucontrol <= 4'b0110; 
// sub
3'b011: alucontrol <= 4'b0011; 
// Resule = A(used for Jal)
3'b100: alucontrol <= 4'b0111; 
// slti
default: case(funct) 
// RTYPE
6'b100000: alucontrol <= 4'b0010; 
// ADD
6'b100010: alucontrol <= 4'b0110; 
// SUB
6'b100100: alucontrol <= 4'b0000; 
// AND
6'b100101: alucontrol <= 4'b0001; 
// OR
6'b101010: alucontrol <= 4'b0111; 
// SLT
6'b000000: alucontrol <= 4'b1000; 
// sll
6'b000010: alucontrol <= 4'b1001; 
// srl
6'b011000: alucontrol <= 4'b1010; 
// mult
6'b011010: alucontrol <= 4'b1011; 
// div
default: alucontrol <= 4'bxxxx; //
 ???
endcase
endcase

endmodule

