`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/13 22:32:18
// Design Name: 
// Module Name: Gen_TDC_Clock
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


module Gen_TDC_Clock(clk_in,Sys_Clk1,Sys_Clk2,Sys_Clk3,Sys_Clk4,Sys_Clk5,Sys_Clk6,Sys_Clk7,Sys_Clk8
    );
 input               clk_in;
output              Sys_Clk1;
output              Sys_Clk2;    
output              Sys_Clk3;
output              Sys_Clk4;      
output              Sys_Clk5;
output              Sys_Clk6;    
output              Sys_Clk7;
output              Sys_Clk8;          
    
    
  wire locked1;  
  wire locked2;  
      
 clk_wiz_2  clk_wiz_2_inst (
 .clk_out1(Sys_Clk1),
.clk_out2(Sys_Clk2),
.clk_out3(Sys_Clk3),
.clk_out4(Sys_Clk4),
 .reset(1'b0),
.locked(locked1),
.clk_in1(clk_in)
 );   
 
 
  clk_wiz_3  clk_wiz_3_inst (
 .clk_out1(Sys_Clk5),
.clk_out2(Sys_Clk6),
.clk_out3(Sys_Clk7),
.clk_out4(Sys_Clk8),
 .reset(1'b0),
.locked(locked2),
.clk_in1(clk_in)
 ); 
    
endmodule
