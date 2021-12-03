module ALU 
#(
	parameter WIDTH = 8
)(
	//Inputs
	input			[WIDTH-1: 0]	A_in, B_in,
	input			[3:0]			select,
	//Outputs
	output							Z,
	output reg		[WIDTH-1: 0]	ALUres	
);		 // ARITHMETIC UNIT

assign Z = (ALUres == 'h0)? 1'b1: 1'b0;

always @(*) begin
	case (select)
		4'h0:	ALUres = A_in;
		4'h1:	ALUres = B_in;
		4'h2:	ALUres = A_in + B_in;
		4'h3:	ALUres = A_in - B_in;
		4'h4:	ALUres = A_in & B_in;
		4'h5:	ALUres = A_in | B_in;
		4'h6:	ALUres = ~(A_in | B_in);
		4'h7:	ALUres = (A_in < B_in) ? 'h1: 'h0;
		4'h8:	ALUres = A_in << B_in[10:6];
		4'h9:	ALUres = A_in >> B_in[10:6];
		default ALUres = A_in;
		// 4'hA:	ALUres = 
		// 4'hB:	ALUres =
		// 4'hC:	ALUres =
		// 4'hD:	ALUres =
		// 4'hE:	ALUres =
		// 4'hF:	ALUres =
	endcase
end


/* always @ (*) begin
	case ({select, c_in})
		5'b0000_0:		ALUres = A_in;
		5'b0000_1:		ALUres = A_in + 1'b1;
		5'b0001_0:		ALUres = A_in + B_in;
		5'b0001_1:		ALUres = A_in + B_in + 1'b1;
		5'b0010_0:		ALUres = A_in + ~B_in;
		5'b0010_1:		ALUres = A_in + (~B_in) + 1'b1;
		5'b0011_0:		ALUres = A_in - 1'b1;
		5'b0011_1:		ALUres = B_in;
		5'b0100_0:		ALUres = A_in & B_in;
		5'b0101_0:		ALUres = A_in | B_in;
		5'b0110_0:		ALUres = A_in ^ B_in;
		5'b0111_0:		ALUres = A_in;
		5'b1000_0:		ALUres = A_in << 1;
		5'b1001_0:		ALUres = A_in >> 1;
		default:		ALUres = 0;
	endcase
end */

endmodule
