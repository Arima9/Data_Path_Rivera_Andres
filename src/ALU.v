module ALU 
#(
	parameter WIDTH = 8
)(
	//Inputs
	input			[WIDTH-1: 0]	A_in, B_in,
	input							c_in,
	input			[3:0]			select,
	//Outputs
	output							Z,
	output reg		[WIDTH-1: 0]	ALUres	
);		 // ARITHMETIC UNIT

always @ (*) begin
	case ({select, c_in})
		5'b0000_0:		ALUres = A_in;
		5'b0000_1:		ALUres = A_in + 1'b1;
		5'b0001_0:		ALUres = A_in + B_in;
		5'b0001_1:		ALUres = A_in + B_in + 1'b1;
		5'b0010_0:		ALUres = A_in +  B_in;
		5'b0010_1:		ALUres = A_in + ( B_in) + 1'b1;
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
end

assign Z = (ALUres == 'h0)? 1'b1: 1'b0;
endmodule
