`timescale 1ns/100ps
module MIPS_tb();
bit MCLK = 1'b0, MCLR = 1'b1;
logic   IoD_tb, MemWrite_tb, IRWrite_tb, PCWrite_tb,
        BranchEq_tb, BranchNeq_tb, PCSrc_tb, ALUSrcA_tb,
        RegWrite_tb, MemtoReg_tb, RegDst_tb;
logic   [1:0] ALUSrcB_tb;
logic   [3:0] ALUControl_tb;
logic [7:0] GPIO_o_tb;
enum {addi, add} INST;
enum {IF, ID, EX, ME, WB} STATE;


MIPS_Multi_Cycle DUT(
    //Inputs
    .clk(MCLK),
    .reset(MCLR),
    .GPIO_o(GPIO_o_tb),
    /******** Señales de ControL ***********/
    .IorD(IoD_tb), .MemWrite(MemWrite_tb), .IRWrite(IRWrite_tb), .PCWrite(PCWrite_tb),
    .BranchEq(BranchEq_tb), .BranchNeq(BranchNeq_tb), .PCSrc(PCSrc_tb), .ALUSrcA(ALUSrcA_tb), 
    .RegWrite(RegWrite_tb), .MemtoReg(MemtoReg_tb), .RegDst(RegDst_tb),
    .ALUSrcB(ALUSrcB_tb), .ALUControl(ALUControl_tb)
    /***************************************/
);

//Clock signal generator
initial begin
    forever #5 MCLK = ~MCLK;
end

//Test of the MIPS microprocessor.
initial begin
    //First we have to reset the microprocessor
    MCLR = 1'b0;
    #9 MCLR = ~MCLR;

    /*
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;
    */

    INST = addi;
    /*          addi $t1, $zero, 3          */
    //Setting the control signals for each state

    STATE = IF;
    //Fetch Instuction 
    PCWrite_tb      = 1'b1;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b1;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b01;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = ID;
    //Decode Instruction
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = EX;
    //Instruction Execution
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b10;
    ALUSrcA_tb      = 1'b1;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = WB;
    //Write Back    
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b1;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    /*          addi $t1, $zero, 7          */
    //Setting the control signals for each state

    STATE = IF;
    //Fetch Instuction 
    PCWrite_tb      = 1'b1;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b1;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b01;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = ID;
    //Decode Instruction
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = EX;
    //Instruction Execution
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b10;
    ALUSrcA_tb      = 1'b1;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = WB;
    //Write Back    
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b1;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    /*          addi $t1, $zero, 1          */
    //Setting the control signals for each state

    STATE = IF;
    //Fetch Instuction 
    PCWrite_tb      = 1'b1;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b1;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b01;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = ID;
    //Decode Instruction
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = EX;
    //Instruction Execution
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b10;
    ALUSrcA_tb      = 1'b1;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = WB;
    //Write Back    
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b1;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    INST = add;
    /*          add $t1, $t1, $t1          */
    //Setting the control signals for each state

    STATE = IF;
    //Fetch Instuction 
    PCWrite_tb      = 1'b1;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b1;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b01;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = ID;
    //Decode Instruction
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = EX;
    //Instruction Execution
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b1;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = WB;
    //Write Back    
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b1;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b1;
    #10;

    /*          add $t2, $t2, $t1          */
    //Setting the control signals for each state

    STATE = IF;
    //Fetch Instuction 
    PCWrite_tb      = 1'b1;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b1;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b01;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = ID;
    //Decode Instruction
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = EX;
    //Instruction Execution
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b1;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = WB;
    //Write Back    
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b1;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b1;
    #10;

    /*          add $t3, $t2, $t1          */
    //Setting the control signals for each state

    STATE = IF;
    //Fetch Instuction 
    PCWrite_tb      = 1'b1;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b1;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b01;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = ID;
    //Decode Instruction
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = EX;
    //Instruction Execution
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0010;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b1;
    RegWrite_tb     = 1'b0;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b0;
    #10;

    STATE = WB;
    //Write Back    
    PCWrite_tb      = 1'b0;
    BranchEq_tb     = 1'b0;
    BranchNeq_tb    = 1'b0;
    IoD_tb          = 1'b0;
    MemWrite_tb     = 1'b0;
    IRWrite_tb      = 1'b0;
    PCSrc_tb        = 1'b0;
    ALUControl_tb   = 4'b0000;
    ALUSrcB_tb      = 2'b00;
    ALUSrcA_tb      = 1'b0;
    RegWrite_tb     = 1'b1;
    MemtoReg_tb     = 1'b0;
    RegDst_tb       = 1'b1;
    #10;

    $display("La simulacion ha terminado...");
    $stop(1);


end

endmodule
