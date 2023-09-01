//immediate adder

module  msrv32_immediate_adder (pc_in, rs_1_in, iadder_src_in, imm_in, iadder_out);
input [31:0] pc_in;   //Pc from the REG block 1
input [31:0] rs_1_in;   //from source register 1
input [31:0] imm_in;  //from immediate adder output
input iadder_src_in;  //To know which type of instructions it is

output wire [31:0] iadder_out;

wire [31:0] temp;
assign temp = (iadder_src_in) ? rs_1_in : pc_in;
assign iadder_out = temp + imm_in;

endmodule
