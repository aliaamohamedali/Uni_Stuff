module eqcmp(
    input [31:0] a,
    input [31:0] b,
    output y
    );


assign y = a==b ? 1 : 0;



endmodule
