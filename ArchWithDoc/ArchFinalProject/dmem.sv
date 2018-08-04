module dmem (input clk, we, sbM,
			 input [31:0] a, wd,
			 output [31:0] rd);

//we : memwrite Signal
//sbM: size of memory to write to (1 byte vs 4 bytes)
//a  : Address of Data to write at
//wd : Data to write at said Address
//rd : data Read from memory / data overwritten in memory			 
// First reads data at input address, then overwrites it depending on control signals
	
// Initialize space for 2^64 places each 32-bits wide	
reg [31:0] RAM[63:0];
	
assign rd = RAM[a[31:2]]; 
// word aligned
	
	
always @ (posedge clk)
	
if (we & ~sbM)
	
RAM[a[31:2]] <= wd;
	
else if (we & sbM)
	
RAM[a[31:2]] <= RAM[a[31:2]][31:8] & wd[7:0];
	
	
endmodule
