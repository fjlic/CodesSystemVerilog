`timescale 1ns/1ps

`include "PC.sv"
`include "Adder.sv"
`include "Imem.sv"
`include "reg_file.sv"
`include "signext.sv"
`include "ALU.sv"
`include "data_mem.sv"

module DataPath_LW_tb;

reg clk,rst;

DataPath_LW dut(.clk(clk),.rst(rst));

always #1 clk = ~clk;

initial begin
	clk = 1; rst  = 1;
	#1; rst = 0;
	
	#50;
	$finish;
end

endmodule