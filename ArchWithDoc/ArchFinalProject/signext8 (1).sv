module signext8(input [7:0] a,
output [31:0] y
    );
	 
	 assign y = {{24{a[7]}}, a};



endmodule


