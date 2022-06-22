module DataPath_LW #(parameter M=32, N=5, O=16)(
  input clk,rst,we_fr, we_data_mem,
  input [3:0] ALU_Sel
);
  
  int  PC_B = 3'b100;
  wire [M-1:0]data_In_PC, data_Out_PC, data_Out_Imem, signimm, ALU_Out;
  wire [M-1:0]rd1, rd2, rd_data_mem;
  
  PC #(.M(M)) U1 (.Data_In(data_In_PC),.Data_Out(data_Out_PC),.clk(clk),.rst(rst));
  Adder #(.M(M)) U2 (.A(data_Out_PC),.B(PC_B),.Data_Out(data_In_PC));
  Imem #(.M(M)) U3 (.addr(data_Out_PC),.RD(data_Out_Imem));
  reg_file #(.M(M),.N(N)) U4(   
    .clk(clk),
    .we_fr(we_fr),
    .ra1(data_Out_Imem[25:21]),
    .ra2(data_Out_Imem[20:16]),
    .wa_fr(PC_B),
    .wd_fr(rd_data_mem),
    .rd1(rd1),
    .rd2(rd2)
  );
  signext #(.M(M),.N(O)) U5 (.inst(data_Out_Imem[15:0]),.signimm(signimm));
  ALU #(.M(M)) U6 (.A(rd1),.B(signimm),.ALU_Sel(ALU_Sel),.ALU_Out(ALU_Out));
  data_mem #(.M(M)) U7 (.clk(clk),.we(we_data_mem),.a(ALU_Out),.wd(),.rd(rd_data_mem));

endmodule