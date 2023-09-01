module msrv32_immediate_adder_tb;

  reg [31:7] pc_in;
  reg [6:4] rs_1_in;
  reg i_adder_src_in;
  reg [31:0] imm_in;

  wire [31:0] i_adder_out;

  msrv32_immediate_adder dut (
    .pc_in(pc_in),
    .rs_1_in(rs_1_in),
    .i_adder_src_in(i_adder_src_in),
    .imm_in(imm_in),
    .i_adder_out(i_adder_out)
  );

initial begin 
i_adder_src_in =1;
pc_in = 32'b00;
rs_1_in=3'b100;
imm_in = 32'b10;

#10
i_adder_src_in = 0;

$finish;
end

endmodule
