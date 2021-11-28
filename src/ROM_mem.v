module ROM_mem
#(
    parameter WORD = 32, DEPTH = 64
)(
    input [$clog2(DEPTH)-1:0] ADDR,
    output [WORD-1:0] DATA_out
);

reg [WORD-1:0] rom [DEPTH-1:0];

initial begin
    $readmemh("../assembly_code/Test_Program_code.hex", rom);
end

assign DATA_out = rom[ADDR];

endmodule