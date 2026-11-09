`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/03 20:06:43
// Design Name: 
// Module Name: Gen_Sys_Clk
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


module Gen_Sys_Clk(Reset,Clk_100M_PR,Clk_100M,Clk_in,Clk_in_50m
    );
output                          Reset;
output                          Clk_100M_PR;
output                          Clk_100M;
output                          Clk_in_50m;
input                           Clk_in;   
wire                    idelayctrl_reset_in;
 assign Reset = ~idelayctrl_reset_in;
clk_wiz_0 u_clk_wiz_0
(
    // Clock out ports
.clk_out1(Clk_100M),     // output clk_out1
.clk_out2(Clk_100M_PR),
.clk_out3(Clk_in_50m),
//.clk_out4(Clk_in_50m),
    // Status and control signals
.locked(idelayctrl_reset_in),       // output locked
.reset(1'b0),
    // Clock in ports
.clk_in1(Clk_in) 
    );      // input clk_in1
   
    
endmodule
