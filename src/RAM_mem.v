module RAM_mem
#(
    parameter WORD = 32, DEPTH = 64
)(
    input [$clog2(DEPTH)-1:0] ADDR,
    input [WORD-1:0] DATA_in,
    input clk, we,
    output [WORD-1:0] DATA_out
);

reg [WORD-1:0] ram [DEPTH-1:0];

always @(posedge clk) begin
    if (we) ram[ADDR] <= DATA_in;
end

assign DATA_out = ram[ADDR];

endmodule
