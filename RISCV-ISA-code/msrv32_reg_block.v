module msrv32_reg_block(input ms_riscv32_mp_rst_in,
input ms_riscv32_mp_clk_in,
input [31:0] pc_mux_in,
output reg[31:0] pc_out);


always @(posedge ms_riscv32_mp_clk_in) begin
if(ms_riscv32_mp_rst_in)
pc_out <= 32'd0;
else
pc_out <= pc_mux_in;
end
endmodule
