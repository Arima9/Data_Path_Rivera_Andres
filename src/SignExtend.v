module SignExtend(
    input       [5:0]   Oppcode,
    input       [15:0]  Imm,
    output reg  [31:0]  ExtImm
);

/***********        SignExtender description                          ***********/
always @(*)begin
    case (Oppcode)
        6'hc, 6'hd: ExtImm <= {16'h0, Imm}; 
        default: ExtImm <= { {16{Imm[15]}} , Imm};
    endcase
end

endmodule
