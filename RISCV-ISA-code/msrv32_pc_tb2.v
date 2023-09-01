module msrv32_pc_tb;

  reg rst_in;
  reg [1:0] pc_src_in;
  reg [31:0] epc_in;
  reg [31:0] trap_address_in;
  reg branch_taken_in;
  reg [31:0] i_addr_in;
  reg ahb_ready_in;
  reg [31:0] pc_in;
  wire [31:0] i_addr_out;
  wire [31:0] pc_plus_4_out;
  wire misaligned_instr_logic_out;
  reg [31:0] pc_mux_out;

  msrv32_pc dut (
    .rst_in(rst_in),
    .pc_src_in(pc_src_in),
    .epc_in(epc_in),
    .trap_address_in(trap_address_in),
    .branch_taken_in(branch_taken_in),
    .i_addr_in(i_addr_in),
    .ahb_ready_in(ahb_ready_in),
    .pc_in(pc_in),
    .i_addr_out(i_addr_out),
    .pc_plus_4_out(pc_plus_4_out),
    .misaligned_instr_logic_out(misaligned_instr_logic_out),
    .pc_mux_out(pc_mux_out)
  );

  initial begin
    rst_in = 1; // Apply reset
    pc_src_in = 2'b00; // Set pc_src_in to 00 for testing
    epc_in = 32'h12345678;
    trap_address_in = 32'h87654321;
    branch_taken_in = 1; // Simulate branch taken
    i_addr_in = 32'd3;
    ahb_ready_in = 1; // Set ahb_ready_in to 1 for testing
    pc_in = 32'hFEDCBA98;

    #10;
    rst_in = 0; // Release reset

    #20;
    // Wait for some cycles

    // Print the outputs for verification
    $display("i_addr_out = %h", i_addr_out);
    $display("pc_plus_4_out = %h", pc_plus_4_out);
    $display("misaligned_instr_logic_out = %b", misaligned_instr_logic_out);
    $display("pc_mux_out = %h", pc_mux_out);

    $finish;
  end

endmodule

