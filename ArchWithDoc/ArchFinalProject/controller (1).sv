module controller(input clk, reset,
				  input [5:0] opD, functD,
				  input flushE, equalD,										
				  output memtoregE, memtoregM, memtoregW, 
				  output memwriteM,
				  output pcsrcD, branchD, bneD,
				  output  alusrcE, regdstE, regwriteE,
				  output regwriteM, regwriteW,
                  output jumpD, jalD, jrD, lbW, sbM, muldivE, mfloM, mfhiM,
				  output [3:0] alucontrolE);

// Intermediary Signals
reg [2:0] aluopD;
reg memtoregD, memwriteD, alusrcD, regdstD, regwriteD, lbD, sbD;
reg lbE, sbE, lbM, muldivD, mfloD, mfhiD, mfloE, mfhiE;
reg [3:0] alucontrolD;
reg memwriteE;

// To get control Signals of Decoding Phase
maindec md(opD,functD,
		   // Out
		   memtoregD, memwriteD,
		   branchD, bneD, alusrcD,
           regdstD, regwriteD,
           jumpD, jalD, jrD, lbD, sbD, muldivD, mfloD, mfhiD,
		   aluopD);

// Get aluControl of Decoding Phase
aludec ad(functD, aluopD, alucontrolD);

assign pcsrcD = (branchD & equalD) | (bneD & ~equalD);

// pipeline registers

// To Get Control Signals of Execution Phase
// A clearing flipflop in case a Branch is required and the instruction requires to be skipped "Flushed"
floprc #(14) regE(clk, reset, flushE,
{memtoregD, memwriteD, alusrcD,
regdstD, regwriteD, alucontrolD, muldivD, mfloD, mfhiD, sbD, lbD},
{memtoregE, memwriteE, alusrcE,
regdstE, regwriteE, alucontrolE, muldivE, mfloE, mfhiE, sbE, lbE});

// To Get Control Signals of Memory Phase
flopr #(7) regM(clk, reset,
{memtoregE, memwriteE, regwriteE, mfloE, mfhiE, sbE, lbE},
{memtoregM, memwriteM, regwriteM, mfloM, mfhiM, sbM, lbM});

// To Get Control Signals of Write Back Phase
flopr #(3) regW(clk, reset,
{memtoregM, regwriteM, lbM},
{memtoregW, regwriteW, lbW});



endmodule
