//pc_mux submodule//
module msrv32_pc (input             branch_taken_in,rst_in,
                  input             ahb_ready_in,
                  input        [1:0]pc_src_in,
                  input       [31:0]epc_in,trap_address_in,pc_in,
                  input       [31:1]iaddr_in,
                  output      [31:0]pc_plus_4_out,iaddr_out,
                  output            misaligned_instr_logic_out,
                  output   reg[31:0]pc_mux_out
                  );
reg [31:0] i_addr;
parameter BOOT_ADDRESS =32'h00000000;

wire [31:0] next_pc;
assign pc_plus_4_out = pc_in + 32'h00000004;
assign next_pc = branch_taken_in ? {iaddr_in,1'b0} : pc_plus_4_out;   // 2:1
assign misaligned_instr_logic_out = (branch_taken_in && next_pc[1]);
assign iaddr_out = i_addr;

always @ (*)  // it will take all the signals included in the design
begin
  case (pc_src_in)
     2'b00   :  pc_mux_out = BOOT_ADDRESS;                            //4:1
     2'b01   :  pc_mux_out = epc_in;
     2'b10   :  pc_mux_out = trap_address_in;
     2'b11   :  pc_mux_out = next_pc;
     default: pc_mux_out = next_pc;
  endcase
end

always @ (*)
begin                                                                   //2:1 
   if(rst_in)
      i_addr = BOOT_ADDRESS;
   else if (ahb_ready_in)                                               //2:1
      i_addr = pc_mux_out;
end

endmodule
