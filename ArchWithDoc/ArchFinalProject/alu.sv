module alu( input logic [31:0] a,b,
             input logic [3:0] f,
             input [4:0] shamt,
             output logic [31:0] c,lo,hi);
             reg [31:0] temp;
always_comb       
       case(f)         
           4'b0000: c = a & b; //and          
           4'b0001: c = a | b; //or         
           4'b0010: c = a + b; //add         
           4'b0011: c = a ^ b; //xor
           4'b0100: c = ~(a | b); //nor
           4'b0011: c = ~a; //not
           4'b0110: c = a - b; //dub
           4'b0111: begin temp = a-b ; c = temp [31];end //slt
           4'b1000: c = a << shamt; //sll      
           4'b1001: c =a >> shamt;//srl
           4'b1010: {hi,lo} = a*b; //mult
           4'b1011: //div      
          begin
          lo = a/b;
          hi = a % b;
          end
default : c =0 ;     
        endcase 
endmodule 

