module msrv32_branch_unit (rs1_in, rs2_in, opcode_6_to_2_in, funct3_in, branch_taken_out);
input [31:0] rs1_in, rs2_in;
input [4:0] opcode_6_to_2_in;
input [2:0] funct3_in;
output reg branch_taken_out;
reg take;
parameter jal    = 5'b 11011,
          jalr   = 5'b 11001,
          branch = 5'b 11000;

always @ (*)
begin
  case(opcode_6_to_2_in)
  jal       : branch_taken_out = 1'b1; 
  jalr      : branch_taken_out = 1'b1;
  branch    : branch_taken_out = take;
  default   : branch_taken_out = 1'b0;
  endcase
end

always @ (*)
begin
if(opcode_6_to_2_in == branch)
begin
   case(funct3_in)
   3'b 000 : take = (rs1_in == rs2_in) ? 1'b1 : 1'b0;
   3'b 001 : take = (rs1_in != rs2_in) ? 1'b1 : 1'b0;
   3'b 100 : take = (rs1_in[31] ^ rs2_in[31]) ? rs1_in[31] : rs1_in < rs2_in;  //signed less than
   3'b 101 : take = (rs1_in[31] ^ rs2_in[31]) ? !rs1_in[31] : !(rs1_in <= rs2_in); //signed greater than
   3'b 110 : take = (rs1_in < rs2_in) ? 1'b1 : 1'b0;
   3'b 111 : take = !(rs1_in < rs2_in) ? 1'b1 : 1'b0;
   default : take =0;
   endcase
end
end

endmodule
