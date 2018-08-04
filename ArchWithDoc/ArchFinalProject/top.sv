module top (input clk, reset,
				
			output [31:0] writedata, dataadr, pc, instr,
				
			output memwrite,
				
			input [31:0] srcaD, srca2E, srcbD, srcb3E);

		
reg [31:0] readdata;
		
reg sbM;

// instantiate processor and memories
		
mips mips (clk, reset,
		   instr,		   
		   // Out
		   pc,
		   memwrite, sbM,
		   dataadr, writedata,
		   // In
           readdata,
		   srcaD, srca2E, srcbD, srcb3E);
		
imem imem (pc[7:2],
		   // Out
		   instr);

		
dmem dmem (clk, memwrite, sbM,
		   dataadr, writedata,
		   // Out
		   readdata);

endmodule
