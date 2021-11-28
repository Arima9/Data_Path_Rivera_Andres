module MIPS_Multi_Cycle
(
    //Inputs
    input clk,
    input reset,
    //Outputs
    output [7:0] GPIO_o,

    /******** Señales de Control ***********/
    input IorD, MemWrite, IRWrite, PCWrite,
    input Branch, PCSrc, ALUSrcA, RegWrite,
    input MemtoReg, RegDst,
    input [1:0] ALUSrcB,
    input [3:0] ALUControl
    /***************************************/
);
localparam BUS = 32;

/***********        Wires declaration for interconect the modules     ***********/
wire    [BUS-1:0]  MS_Rdat;    //Wires for Memory System module
wire    [BUS-1:0]  RF_RD1, RF_RD2; //Wires for Register File
wire               ALU_z, PCen;
wire    [BUS-1:0]  ALUresult; //Wires for Alu module
wire    [BUS-1:0]  SignImm; //SignExtender wire


/***********        Wires for Registers and Multiplexers              ***********/
wire [BUS-1:0]  PC_reg, Instr_reg, Data_reg, A_reg, B_reg, ALU_reg; //REGISTERS
wire [BUS-1:0]  AdrSM_mux, WDRF_mux, SrcA_mux, SrcB_mux, PCin_mux;   //MULTIPLEXERS
wire [4:0] A3RF_mux;

assign PCen = PCWrite || (Branch && ALU_z);
assign GPIO_o = ALUresult[7:0];



/***********        Modules Instanciation         ***********/
Memory_System #(.MEMORY_DEPTH(64), .DATA_WIDTH(BUS)) 
IDM_U0(
    .Write_Enable_i(MemWrite),
    .CLK(clk),
    .Write_Data(B_reg),
    .Address_i(AdrSM_mux),
    .Read_Data(MS_Rdat)
);

Register_File #(.N(BUS), .ADDR(5))
RF_U1(
    .clk(clk),
    .reset(reset),
    .Reg_Write_i(RegWrite),
    .Write_Register_i(A3RF_mux),
    .Read_Register_1_i(Instr_reg[25:21]),
    .Read_Register_2_i(Instr_reg[20:16]),
    .Write_Data_i(WDRF_mux),
    .Read_Data_1_o(RF_RD1),
    .Read_Data_2_o(RF_RD2)
);

ALU #(.WIDTH(BUS))
ALU_U2(
    .A_in(SrcA_mux),
    .B_in(SrcB_mux),
	.c_in(1'b0),
	.select(ALUControl),
    .Z(ALU_z),
    .ALUres(ALUresult)	
);

SignExtend SigExt_U14(
    .Oppcode(Instr_reg[31:26]),
    .Imm(Instr_reg[15:0]),
    .ExtImm(SignImm)
);

/***********        Registers Instanciation       ***********/
RegisterUnit#(.W(BUS))
PC_U3(
    .clk(clk),
    .rst(reset),
    .en(PCen),
    .D(PCin_mux),
    .Q(PC_reg)
);

RegisterUnit#(.W(BUS))
IR_U4(
    .clk(clk),
    .rst(reset),
    .en(IRWrite),
    .D(MS_Rdat),
    .Q(Instr_reg)
);

RegisterUnit#(.W(BUS))
DT_U5(
    .clk(clk),
    .rst(reset),
    .en(1'b1),
    .D(MS_Rdat),
    .Q(Data_reg)
);

RegisterUnit#(.W(2*BUS))
RFreg_U6(
    .clk(clk),
    .rst(reset),
    .en(1'b1),
    .D({RF_RD2, RF_RD1}),
    .Q({B_reg, A_reg})
);

RegisterUnit#(.W(BUS))
ALUreg_U7(
    .clk(clk),
    .rst(reset),
    .en(1'b1),
    .D(ALUresult),
    .Q(ALU_reg)
);

/***********        Multiplexers Instanciation    ***********/
MultiplexerUnit#(.SEL(1), .WORD(BUS))
DIRmux_U8(
    .DATAin({ALU_reg, PC_reg}),
    .Select(IorD),
    .DATAout(AdrSM_mux)
);

MultiplexerUnit#(.SEL(1), .WORD(5))
WRRFmux_U9(
    .DATAin({Instr_reg[15:11], Instr_reg[20:16]}),
    .Select(RegDst),
    .DATAout(A3RF_mux)
);

MultiplexerUnit#(.SEL(1), .WORD(BUS))
WDRFmux_U10(
    .DATAin({Data_reg, ALU_reg}),
    .Select(MemtoReg),
    .DATAout(WDRF_mux)
);

MultiplexerUnit#(.SEL(1), .WORD(BUS))
Aselmux_U11(
    .DATAin({A_reg, PC_reg}),
    .Select(ALUSrcA),
    .DATAout(SrcA_mux)
);

MultiplexerUnit#(.SEL(2), .WORD(BUS))
Bselmux_U12(
    .DATAin({SignImm << 16, SignImm, 32'h4, B_reg}),
    .Select(ALUSrcB),
    .DATAout(SrcB_mux)
);

MultiplexerUnit#(.SEL(1), .WORD(BUS))
PCselmux_U13(
    .DATAin({ALU_reg, ALUresult}),
    .Select(PCSrc),
    .DATAout(PCin_mux)
);

endmodule
