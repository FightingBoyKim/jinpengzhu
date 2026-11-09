`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/01 08:55:12
// Design Name: 
// Module Name: Delay_Stop_Signal
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


module Delay_Stop_Signal(Reset,Sys_Clk1,Stop_in1,Stop_in2,Stop_out1,Stop_out2,Delay_cnt1,Delay_cnt2
    );
input                               Reset;
input                               Sys_Clk1;
input                               Stop_in1;
input                               Stop_in2;
output                              Stop_out1;
output                              Stop_out2;
input[14:0]                         Delay_cnt1;
input[14:0]                         Delay_cnt2;  
reg                                 Stop_out1;
reg                                 Stop_out2; 
reg                                 Stop_in1_r;
reg                                 Stop_in2_r;

reg[14:0]                         Delay_cnt1_r;
reg[14:0]                         Delay_cnt1_r1;

reg[14:0]                         Delay_cnt2_r;
reg[14:0]                         Delay_cnt2_r1;



reg[1:0]                            fms_data1;
reg[1:0]                            fms_data2;

reg[14:0]                           Cnt_Delay_cnt1;
reg[14:0]                           Cnt_Delay_cnt2;  

always@(posedge Sys_Clk1 or negedge Reset)
    if(Reset == 1'b1)
        begin
            fms_data1               <= 1'b0;
            Stop_out1               <= 1'b0;
            Cnt_Delay_cnt1          <= 15'd0;
            Stop_in1_r              <= 1'b0;
            Delay_cnt1_r            <= 15'd0;
            Delay_cnt1_r1           <= 15'd0;            
            
            
        end
    else
        begin
            begin
                Delay_cnt1_r        <= Delay_cnt1;
                Delay_cnt1_r1       <= Delay_cnt1_r-1;
                Stop_in1_r          <= Stop_in1;
               case(fms_data1)
             2'd0:
                begin
                      Stop_out1       <= 1'b0;
                    if((Stop_in1_r == 1'b0) && (Stop_in1 == 1'b1))
                        begin
                            fms_data1   <= 2'd1;
                        end
                    else
                        begin
                            fms_data1   <= 2'd0;
                        end
                end
             2'd1:
                begin
                    if(Cnt_Delay_cnt1 == Delay_cnt1_r1)
                        begin
                            Cnt_Delay_cnt1  <= 15'd0;
                            fms_data1       <= 2'd2;
                            Stop_out1       <= 1'b1;
                        end
                    else
                        begin
                            Cnt_Delay_cnt1  <= Cnt_Delay_cnt1 + 15'd1;
                            fms_data1       <= 2'd1;
                            Stop_out1       <= 1'b0;
                        end
                end
             2'd2:
                begin
                     fms_data1              <= 2'd3;
                end
             2'd3:
                begin
                      fms_data1             <= 2'd0;
                end
            default:
                begin
                end
            endcase
            end
        end



always@(posedge Sys_Clk1 or negedge Reset)
    if(Reset == 1'b1)
        begin
            fms_data2               <= 1'b0;
            Stop_out2               <= 1'b0;
            Cnt_Delay_cnt2          <= 15'd0;
            Stop_in2_r              <= 1'b0;
            Delay_cnt2_r            <= 15'd0;
            Delay_cnt2_r1           <= 15'd0;               
        end
    else
        begin
            begin
             Delay_cnt2_r            <= Delay_cnt2;
            Delay_cnt2_r1           <= Delay_cnt2_r-1;            
                Stop_in2_r          <= Stop_in2;
               case(fms_data2)
             2'd0:
                begin
                      Stop_out2       <= 1'b0;
                    if((Stop_in2_r == 1'b0) && (Stop_in2 == 1'b1))
                        begin
                            fms_data2   <= 2'd1;
                        end
                    else
                        begin
                            fms_data2   <= 2'd0;
                        end
                end
             2'd1:
                begin
                    if(Cnt_Delay_cnt2 == Delay_cnt2_r1)
                        begin
                            Cnt_Delay_cnt2  <= 15'd0;
                            fms_data2       <= 2'd2;
                            Stop_out2       <= 1'b1;
                        end
                    else
                        begin
                            Cnt_Delay_cnt2  <= Cnt_Delay_cnt2 + 15'd1;
                            fms_data2       <= 2'd1;
                            Stop_out2       <= 1'b0;
                        end
                end
             2'd2:
                begin
                     fms_data2              <= 2'd3;
                end
             2'd3:
                begin
                      fms_data2             <= 2'd0;
                end
            default:
                begin
                end
            endcase
            end
        end



endmodule
