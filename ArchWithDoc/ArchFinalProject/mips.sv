module mips(input clk, reset,										// Clk & Reset
			input [31:0] instrF,									// Fetched Instruction

			output [31:0] pcF,										// pc value after Fetch
			output memwriteM, sbM,									// Control Signal to determine if/how
																	// to write to memory in Memory Stage 
			output [31:0] aluoutM, writedataM,						// ALU o/p & data to write to memory
																	// in Memory stage

			input [31:0] readdataM,									// Data to read from Memory
			input [31:0] srcaD, srca2E, srcbD, srcb3E);				// Values in ALU sources in Decoding
																	// & Executing Satges

// Intermediate Signals for Decoding Stage
reg [5:0] opD, functD;
reg jalD, jrD, pcsrcD;

// Intermediate Signals for Executing Stage
reg regdstE, alusrcE, muldivE;

// Intermediate Signals for Memory Stage
reg mfloM, mfhiM;

// Intermediate Signals for Write back stage
reg lbW; 

// Signals at each stage
memtoregE, memtoregM, memtoregW,
regwriteE, regwriteM, regwriteW;
reg [3:0] alucontrolE;

reg flushE, equalD;


// Instantiate Controller

controller c(clk, reset,
			opD, functD,
			flushE, equalD,
			// out
			memtoregE, memtoregM, memtoregW,
			memwriteM,
			pcsrcD, branchD, bneD,
			alusrcE, regdstE, regwriteE,
			regwriteM, regwriteW,
			jumpD, jalD, jrD, lbW, sbM, muldivE, mfloM, mfhiM,
			alucontrolE);


			
datapath dp(clk, reset,
			memtoregE, memtoregM, memtoregW,
			pcsrcD, branchD, bneD,
			alusrcE, regdstE, regwriteE,
			regwriteM, regwriteW,
			jumpD, jalD, jrD, lbW, muldivE, mfloM, mfhiM,
			alucontrolE,
			instrF,
			readdataM,
			// Out
			equalD,
			pcF,
			aluoutM, writedataM,
			opD, functD,
			flushE,
			// InOut
			srcaD, srca2E, srcbD, srcb3E);

endmodule

