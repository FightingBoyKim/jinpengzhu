`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/29 11:26:35
// Design Name: 
// Module Name: scl_debounce
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

module scl_debounce(
 clk, scl_in, scl_out 
);
input                               clk;// FPGA 主时钟
input                               scl_in; // 原始 SCL 输入信号
output reg                          scl_out; // 去毛刺后的 SCL 输出信号
reg  [2: 0]                         scl_samples;// 保存最近的三次采样
reg                                 scl_stable;// 稳定的 SCL 信号
always @(posedge clk) 
    begin
        // 移位寄存器保存最近的采样值
       scl_samples                  <= {scl_samples[1:0], scl_in};
        // 当采样值一致时，认为信号稳定
        if (scl_samples == 3'b111) begin
            scl_stable              <= 1'b1;
        end else if (scl_samples == 3'b000) begin
            scl_stable              <= 1'b0;
        end
    end    
always @ (posedge clk)
     scl_out                        <= scl_stable;

endmodule
