module imem(input [5:0] a,
			output [31:0] rd);

//a : Number of Instruction
//rd: Fetched Instruction			
// Fetches the instruction at position 'a' & assigns it to rd;

// Inistialize space for 2^64 instructions each 32-bits wide
reg [31:0] RAM[63:0];

initial
begin

$readmemh("test.tv", RAM);

end
assign rd = RAM[a]; 
// word aligned

endmodule
