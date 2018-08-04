module datapath(input clk, reset,
				input memtoregE, memtoregM, memtoregW,					// 'E' used in Hazard
				input pcsrcD, branchD, bneD,							// In Hazards & Early Branch Resolution
				input alusrcE, regdstE, regwriteE, 
				input regwriteM, regwriteW,								// Also used in Hazard
				input jumpD, jalD, jrD, lbW, muldivE, mfloM, mfhiM,
				input [3:0] alucontrolE,
				input [31:0] instrF,
				input [31:0] readdataM,
				output equalD,
				output [31:0] pcF,
				output [31:0] aluoutM, writedataM,
				output [5:0] opD, functD,
				output flushE,
				inout [31:0] srcaD, srca2E, srcbD, srcb3E);

// Hazard Signals

reg forwardaD, forwardbD;
reg [1:0] forwardaE, forwardbE;
reg stallF;
reg [4:0] rsD, rtD, rt2D, rdD, rsE, rtE, rdE;
reg [4:0] writeregE, writeregM, writeregW;

reg flushD;
reg [31:0] pcnextFD, pcnextbrFD, pcnextbrjrFD, pcplus4F, pcbranchD;
reg [31:0] signimmD, signimmE, signimmshD;
reg [31:0] srca2D, srcaE;
reg [31:0] srca3D, srcb2D, srcbE, srcb2E;

reg [31:0] pcplus4D, instrD;

reg [31:0] aluoutE, aluoutW, loE, hiE, loM, hiM;

reg [31:0] readdataW, resultW, resultW1, resultlbW, aluoutM1, aluoutM2;

reg [7:0] resultlb8W;

reg [4:0] shamtD,shamtE;

// hazard detection
hazard h(rsD, rtD, rsE, rtE,
		writeregE, writeregM, writeregW,
		regwriteE, regwriteM, regwriteW,
		memtoregE, memtoregM, branchD, bneD, jrD,
		// Out
		forwardaD, forwardbD,
		forwardaE, forwardbE,
		stallF, stallD, flushE);

// next PC logic (operates in fetch and decode)
mux2 #(32) pcbrmux(pcplus4F, pcbranchD, pcsrcD, pcnextbrFD);

 // pcnextbrFD = ( pcplus4F or BTA "pcbranchD " )
mux2 #(32) pcJrmux(pcnextbrFD,srca2D,jrD,pcnextbrjrFD);

// pcnextbrjrFD = (pcnextbrFD or jr register"srca2D" )
mux2 #(32) pcmux(pcnextbrjrFD, {pcplus4D[31:28], instrD[25:0], 2'b00},
jumpD, pcnextFD);

// pcnextFD = (JTA or pcnextbrjrFD)  

// register file (operates in decode and writeback)
regfile rf(clk,
			regwriteW,
			rsD, rtD, writeregW,
			resultW, 
			// Out
			srcaD, srcbD);


// Fetch stage logic
flopenr #(32) pcreg(clk, reset, ~stallF,
pcnextFD, pcF);

adder pcadd1(pcF, 32'b100, pcplus4F);

// Decode stage
assign flushD = pcsrcD | jumpD | jalD | jrD;

flopenrc #(32) r2D(clk, reset, ~stallD, flushD, instrF, instrD);

flopenr #(32) r1D(clk, reset, ~stallD, pcplus4F,
pcplus4D);

signext se(instrD[15:0], signimmD);

sl2 immsh(signimmD, signimmshD);

adder pcadd2(pcplus4D, signimmshD, pcbranchD);

mux2 #(32) forwardadmux(srcaD, aluoutM, forwardaD,
srca2D);

mux2 #(32) forwardbdmux(srcbD, aluoutM, forwardbD,
srcb2D);

eqcmp comp(srca2D, srcb2D, equalD);

assign opD = instrD[31:26];

assign functD = instrD[5:0];

assign rsD = instrD[25:21];

assign rtD = instrD[20:16];

assign rdD = instrD[15:11];

assign shamtD= instrD[10:6];




// jal muxes
mux2 #(32)   jaldatamux(srcaD, pcplus4D, jalD, srca3D);

mux2 #(5) 	 jaladrmux(rtD, 5'b11111, jalD, rt2D);



// Execute stage
floprc #(32) r1E(clk, reset, flushE, srca3D, srcaE);

floprc #(32) r2E(clk, reset, flushE, srcbD, srcbE);

floprc #(32) r3E(clk, reset, flushE, signimmD, signimmE);

floprc #(5) r4E(clk, reset, flushE, rsD, rsE);

floprc #(5) r5E(clk, reset, flushE, rt2D, rtE);

floprc #(5) r6E(clk, reset, flushE, rdD, rdE);

floprc #(5) r7E(clk, reset, flushE, shamtD, shamtE);


mux3 #(32) forwardaemux(srcaE, resultW, aluoutM,forwardaE, srca2E);

mux3 #(32) forwardbemux(srcbE, resultW, aluoutM,forwardbE, srcb2E);

mux2 #(32) srcbmux(srcb2E, signimmE, alusrcE,srcb3E);

alu alu(srca2E, srcb3E, alucontrolE,shamtE, aluoutE,loE,hiE);

mux2 #(5) wrmux(rtE, rdE, regdstE, writeregE);

// Memory stage
flopr #(32) r1M(clk, reset, srcb2E, writedataM);

flopr #(32) r2M(clk, reset, aluoutE, aluoutM);
flopr #(5) r3M(clk, reset, writeregE, writeregM);

flopenr #(32) low(clk, reset,muldivE, loE, loM); 
flopenr #(32) high(clk, reset,muldivE, hiE, hiM); 
 

mux2 #(32)  mfloMux(aluoutM, loM, mfloM, aluoutM1);
mux2 #(32)  mfhiMux(aluoutM1, hiM, mfhiM, aluoutM2);


// Writeback stage
flopr #(32) r1W(clk, reset, aluoutM2, aluoutW);
flopr #(32) r2W(clk, reset, readdataM, readdataW);

flopr #(5) r3W(clk, reset, writeregM, writeregW);
mux2 #(32) resmux(aluoutW, readdataW, memtoregW,
resultW1);


mux4 #(8) lbdmux(resultW1[7: 0],resultW1[15: 8],resultW1[23: 16],resultW1[31: 24],aluoutW[1:0], resultlb8W);

 
signext8 se8(resultlb8W, resultlbW);
	

mux2 #(32)lbmux(resultW1, resultlbW, lbW,
 resultW);



endmodule

