module msrv32_reg_block_tb;

  reg ms_riscv32_mp_rst_in;
  reg ms_riscv32_mp_clk_in;
  reg [31:0] pc_mux_in;
  wire [31:0] pc_out;

  msrv32_reg_block dut (
    .ms_riscv32_mp_rst_in(rst),
    .ms_riscv32_mp_clk_in(clk),
    .pc_mux_in(in),
    .pc_out(out)
  );//instantiate

  initial begin
    ms_riscv32_mp_rst_in = 1; // Apply reset
    ms_riscv32_mp_clk_in = 0;
    /*forever
    #5 clk=~clk;
    end
task rst;
begin
@(negedge clk)
rst=1'b1;
a(negedge clk)
rst=1'b0;
end
endtask 

initial begin
rst;
@(nededge clk)
in=32'd10;
end*/

    pc_mux_in = 32'h12345678;

    #10;
    ms_riscv32_mp_rst_in = 0; // Release reset

    repeat (5) begin
      #10;
      ms_riscv32_mp_clk_in = ~ms_riscv32_mp_clk_in; // Toggle clock
    end

    $finish;
  end 


endmodule

