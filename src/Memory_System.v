module Memory_System
#(
    parameter MEMORY_DEPTH = 64,
    DATA_WIDTH = 32
)(
    input Write_Enable_i, CLK,
    input [DATA_WIDTH-1:0] Write_Data,
    input [31:0] Address_i,

    output [DATA_WIDTH-1:0] Read_Data
);

//Wires declarations for data
wire [DATA_WIDTH-1:0] ram_out, rom_out;
//Mux select for the data
wire MUXsel;
//Adress for the memories
wire [$clog2(MEMORY_DEPTH)-1:0] Addr_mems;

//Modules instanciation
ROM_mem
#(
    .WORD(DATA_WIDTH), .DEPTH(MEMORY_DEPTH)
) ROM_U0(
    .ADDR(Addr_mems),
    .DATA_out(rom_out)
);

RAM_mem
#(
    .WORD(DATA_WIDTH), .DEPTH(MEMORY_DEPTH)
) RAM_U0(
    .ADDR(Addr_mems),
    .DATA_in(Write_Data),
    .clk(CLK),
    .we(Write_Enable_i & MUXsel),
    .DATA_out(ram_out)
);

MultiplexerUnit
#(    
    .SEL(1), .WORD(DATA_WIDTH)
) MUX_U0(
    .DATAin({ram_out, rom_out}),
    .Select(MUXsel),
    .DATAout(Read_Data)
);

//Selector for the mux of the memories
//If Address_i is higher than or equal to h1001 0000 is pointing to the RAM
assign MUXsel = (Address_i >= 32'h1001_0000) ? 1'b1 : 1'b0;
//Glue logic of directions decoders
assign Addr_mems = Address_i[$clog2(MEMORY_DEPTH)+1:2];


endmodule
