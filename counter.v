`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/30 22:36:25
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(Sys_Clk,Reset,count_abs);
input    Sys_Clk;
input    Reset;
output[21:0]    count_abs;



wire     	 Sys_Clk;
wire     	 Reset;

reg[21:0]    count_abs;

reg    Timestamp_mode_r;
reg    TDC_test_flag_r;
reg    Start1_r;
reg    Timestamp_mode_r1;
reg    TDC_test_flag_r1;
reg    Start1_r1;
always@(posedge Sys_Clk or posedge Reset)
	if(Reset == 1'b1)
	   count_abs               <= 22'd0;
	else

	   count_abs           <= count_abs + 22'd1;



			
endmodule
