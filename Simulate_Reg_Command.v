`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/11 09:27:05
// Design Name: 
// Module Name: Simulate_Reg_Command
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


module Simulate_Reg_Command(Clk,Rst_n,RW_Cmd,Reg_Addr,W_Data,R_Data,W_Valid,Write_Reg8b_0,
DA_Ref1_usb,DA_Ref2_usb,DA_Ref3_usb,DA_Ref4_usb,laser_freq_pinc,laser_freq_pluse,trig_mode
,TDC_Peak_Flag,TDC_ACC_Flag,T3_mode,S_delay1,S_delay2,TDC_ACC_Time,TDC_single_Time,TDC_bin,TDC_Peak_Value,Start_stop_flag
,SPC_flag,T3_mode_Time,Timestamp_mode,Conforms_Counting_mode_1,Conforms_Counting_mode_2,
Spd_Delay_cnt1,Spd_Delay_cnt2,Spd_Delay_flag1,Spd_Delay_flag2,Conforms_Counting_time
,Conforms_Counting_Sync_Time,Conforms_Counting_PW,Conforms_Counting_flag
);
input                               Clk;
input                               Rst_n;
input                               RW_Cmd;
input[7:0]                          Reg_Addr;
input[7:0]                          W_Data;
output reg [7:0]                    R_Data;
input                               W_Valid;
output reg                          Write_Reg8b_0;

output[9:0]                          DA_Ref1_usb;
output[9:0]                          DA_Ref2_usb; 
output[9:0]                          DA_Ref3_usb;
output[9:0]                          DA_Ref4_usb; 
output[31:0]                         laser_freq_pinc;
output[7:0]                          laser_freq_pluse; 
output                               trig_mode;
output                                TDC_Peak_Flag;
output                                TDC_ACC_Flag;
output                                T3_mode;  
output[1:0]                           T3_mode_Time;
output[15:0]                           S_delay1;
output[15:0]                           S_delay2;
output[31:0]                          TDC_ACC_Time;         
output[31:0]                          TDC_single_Time; 
output[4:0]                          TDC_bin;  
output[15:0]                          TDC_Peak_Value;  
output                               Start_stop_flag;
 
output                                SPC_flag;
output                              Timestamp_mode;
output                              Conforms_Counting_mode_1;
output                              Conforms_Counting_mode_2;
output[14:0]                        Spd_Delay_cnt1;
output[14:0]                        Spd_Delay_cnt2;
output                              Spd_Delay_flag1;
output                              Spd_Delay_flag2;
output[15:0]                        Conforms_Counting_time;

output[15:0]                        Conforms_Counting_Sync_Time;
output[15:0]                        Conforms_Counting_PW;
output                              Conforms_Counting_flag;
reg[9:0]                            DA_Ref1_usb;
reg[9:0]                            DA_Ref2_usb;
reg[9:0]                            DA_Ref3_usb;
reg[9:0]                            DA_Ref4_usb;
reg[31:0]                           laser_freq_pinc;
reg[7:0]                            laser_freq_pluse; 
reg                                 trig_mode;
reg                                 Conforms_Counting_mode_1;
reg                                 Conforms_Counting_mode_2;
reg                                 TDC_Peak_Flag;
reg                                 TDC_ACC_Flag;
reg                                 SPC_flag;
reg                                 T3_mode;   
reg[1:0]                            T3_mode_Time;
reg                                Timestamp_mode;
reg[31:0]                           TDC_ACC_Time;         
reg[31:0]                           TDC_single_Time; 
reg[4:0]                           TDC_bin;  
reg[15:0]                           TDC_Peak_Value;  
 reg                              Start_stop_flag;


reg[15:0]                          S_delay1; 
reg[15:0]                          S_delay2; 

reg[14:0]                        Spd_Delay_cnt1;
reg[14:0]                        Spd_Delay_cnt2;
reg                              Spd_Delay_flag1;
reg                              Spd_Delay_flag2;

reg[14:0]                        Spd_Delay_cnt1_r;
reg[14:0]                        Spd_Delay_cnt2_r;
reg                              Spd_Delay_flag1_r;
reg                              Spd_Delay_flag2_r;
reg[15:0]                       Conforms_Counting_time;
reg[15:0]                        Conforms_Counting_Sync_Time;
reg[15:0]                        Conforms_Counting_PW;
reg                              Conforms_Counting_flag;
wire[31:0]                          Reg32b_0;
wire[31:0]                          Reg32b_1;
wire[31:0]                          Reg32b_2;
wire[31:0]                          Reg32b_3;
wire[31:0]                          Reg32b_4;
wire[31:0]                          Reg32b_5;
wire[31:0]                          Reg32b_6;
wire[31:0]                          Reg32b_7;
wire[31:0]                          Reg32b_8;
wire[31:0]                          Reg32b_9; 
wire[31:0]                          Reg32b_10;
wire[31:0]                          Reg32b_11;
wire[31:0]                          Reg32b_12;
wire[31:0]                          Reg32b_13;
wire[31:0]                          Reg32b_14;
wire[31:0]                          Reg32b_15;
wire[31:0]                          Reg32b_16;
wire[31:0]                          Reg32b_17;
wire[31:0]                          Reg32b_18;
wire[31:0]                          Reg32b_19; 
 
 
 
reg [7:0]Reg8b[255:0];      //256个8位寄存器
reg [255:0]Reg8b_Wr_Flg;    //每当8为寄存器被写入时，对应标志拉高一个脉冲

assign Reg32b_0 = {Reg8b[ 3],Reg8b[ 2],Reg8b[ 1],Reg8b[ 0]};
assign Reg32b_1 = {Reg8b[ 7],Reg8b[ 6],Reg8b[ 5],Reg8b[ 4]};
assign Reg32b_2 = {Reg8b[11],Reg8b[10],Reg8b[ 9],Reg8b[ 8]};
assign Reg32b_3 = {Reg8b[15],Reg8b[14],Reg8b[13],Reg8b[12]};
assign Reg32b_4 = {Reg8b[19],Reg8b[18],Reg8b[17],Reg8b[16]};
assign Reg32b_5 = {Reg8b[23],Reg8b[22],Reg8b[21],Reg8b[20]};
assign Reg32b_6 = {Reg8b[27],Reg8b[26],Reg8b[25],Reg8b[24]};
assign Reg32b_7 = {Reg8b[31],Reg8b[30],Reg8b[29],Reg8b[28]};
assign Reg32b_8 = {Reg8b[35],Reg8b[34],Reg8b[33],Reg8b[32]};
assign Reg32b_9 = {Reg8b[39],Reg8b[38],Reg8b[37],Reg8b[36]};
assign Reg32b_10 = {Reg8b[43],Reg8b[42],Reg8b[41],Reg8b[40]};
assign Reg32b_11 = {Reg8b[47],Reg8b[46],Reg8b[45],Reg8b[44]};
assign Reg32b_12 = {Reg8b[51],Reg8b[50],Reg8b[49],Reg8b[48]};
assign Reg32b_13 = {Reg8b[55],Reg8b[54],Reg8b[53],Reg8b[52]};
assign Reg32b_14 = {Reg8b[59],Reg8b[58],Reg8b[57],Reg8b[56]};
assign Reg32b_15 = {Reg8b[63],Reg8b[62],Reg8b[61],Reg8b[60]};
assign Reg32b_16 = {Reg8b[67],Reg8b[66],Reg8b[65],Reg8b[64]};
assign Reg32b_17 = {Reg8b[71],Reg8b[70],Reg8b[69],Reg8b[68]};
assign Reg32b_18 = {Reg8b[75],Reg8b[74],Reg8b[73],Reg8b[72]};
assign Reg32b_19 = {Reg8b[79],Reg8b[78],Reg8b[77],Reg8b[76]};


always @(posedge Clk or negedge Rst_n)
    if(Rst_n)
        Write_Reg8b_0               <= 1'b0;
    else
        Write_Reg8b_0               <= Reg8b_Wr_Flg[0];

integer i;
//在W_Valid时将数据W_Data写入寄存器
always @(posedge Clk or negedge Rst_n)
    if(Rst_n) 
        begin
            for (i=0;i<256;i=i+1)
                 begin
                    Reg8b[i]            <= 8'h00;
                    Reg8b_Wr_Flg[i]     <= 1'b0;
                end
        end
    else if(W_Valid)
        begin
            Reg8b[Reg_Addr]             <= W_Data;
            Reg8b_Wr_Flg[Reg_Addr]      <= 1'b1;
        end
    else
         begin
            Reg8b[Reg_Addr]             <= Reg8b[Reg_Addr];
            Reg8b_Wr_Flg[Reg_Addr]      <= 1'b0;
        end

//在RW_Cmd为读(1)的时候，R_Data输出对应寄存器值
always @(posedge Clk or negedge Rst_n)
    if(Rst_n) 
        begin
            R_Data                  <= 8'h00;
        end
    else if(RW_Cmd) 
        begin
            R_Data              <= Reg8b[Reg_Addr];
        end
    else 
        begin
            R_Data              <= R_Data;
        end
///////////////////////指令解析//////////////////////////////////
 always @(posedge Clk or negedge Rst_n)
    if(Rst_n) 
        begin
            DA_Ref1_usb                    <= 10'd0;
            DA_Ref2_usb                    <= 10'd0;
            DA_Ref3_usb                    <= 10'd0;
            DA_Ref4_usb                    <= 10'd0;            
            laser_freq_pinc                <= 32'd0;
            laser_freq_pluse               <= 8'd0;   
            trig_mode                      <= 1'b0;
            TDC_Peak_Flag                  <= 1'b0;
            TDC_ACC_Flag                   <= 1'b0;
            SPC_flag                       <= 1'b0;
            T3_mode                        <= 1'b0;   
            T3_mode_Time                   <= 2'd0;         
            TDC_ACC_Time                   <= 32'd0;         
            TDC_single_Time                <= 32'd0; 
            TDC_bin                        <= 5'd0;  
            TDC_Peak_Value                 <= 16'd0;       
            Start_stop_flag                 <= 1'b0;      
      
            Timestamp_mode                 <= 1'b0;
            Conforms_Counting_mode_1       <= 1'b0;
            Conforms_Counting_mode_2       <= 1'b0;    
            
            Spd_Delay_cnt1                  <= 15'd0;
            Spd_Delay_cnt2                  <= 15'd0;
            Spd_Delay_flag1                  <= 1'b0;           
            Spd_Delay_flag2                  <= 1'b0;      
            
             Spd_Delay_cnt1_r                  <= 15'd0;
            Spd_Delay_cnt2_r                  <= 15'd0;
            Spd_Delay_flag1_r                  <= 1'b0;           
            Spd_Delay_flag2_r                  <= 1'b0;            
            Conforms_Counting_time             <= 16'd0;
            Conforms_Counting_Sync_Time        <= 16'd0;
            Conforms_Counting_PW               <= 16'd0; 
            Conforms_Counting_flag             <= 1'b0;                           
        end  
     else
        begin
            DA_Ref1_usb                    <= Reg32b_2[9:0];
            DA_Ref2_usb                    <= Reg32b_2[25:16];
            DA_Ref3_usb                    <= Reg32b_3[9:0];
            DA_Ref4_usb                    <= Reg32b_3[25:16];   
                 
           laser_freq_pinc                 <= Reg32b_4;
           laser_freq_pluse                <= Reg32b_5[7:0];    
           trig_mode                       <= Reg32b_0[0];
           TDC_Peak_Flag                   <= (~ Reg32b_1[2]) && Reg32b_1[1];
           TDC_ACC_Flag                    <= (~ Reg32b_1[2]) && Reg32b_1[0];
           T3_mode                         <= Reg32b_1[2];
           T3_mode_Time                    <= Reg32b_1[1:0];
           SPC_flag                        <= Reg32b_1[3]; 
           Timestamp_mode                  <= Reg32b_1[4];
           
           Conforms_Counting_mode_1        <= Reg32b_1[5];
           Conforms_Counting_mode_2        <= Reg32b_1[6];           
           Conforms_Counting_flag          <= Reg32b_1[7];
           
           S_delay1                        <= Reg32b_6[15:0];
           S_delay2                        <= Reg32b_6[31:16];
           TDC_ACC_Time                    <= Reg32b_7;         
           TDC_single_Time                 <= Reg32b_8; 
           TDC_bin                         <= Reg32b_9[15:0];  
           TDC_Peak_Value                  <= Reg32b_10[15:0];  
           Start_stop_flag                 <= Reg32b_11[0];   
    
     
            Spd_Delay_cnt1                  <= Spd_Delay_cnt1_r;
            Spd_Delay_cnt2                  <= Spd_Delay_cnt2_r;
            Spd_Delay_flag1                  <= Spd_Delay_flag1_r;           
            Spd_Delay_flag2                  <=Spd_Delay_flag2_r;      
           
           Spd_Delay_cnt1_r                  <= Reg32b_15[14:0];
           Spd_Delay_cnt2_r                  <= Reg32b_15[30:16];
           Spd_Delay_flag1_r                 <= Reg32b_15[15];           
           Spd_Delay_flag2_r                 <= Reg32b_15[31];           
           
           Conforms_Counting_time            <=  Reg32b_18[15:0];  
           Conforms_Counting_Sync_Time       <= Reg32b_19[15:0];  
           Conforms_Counting_PW              <= Reg32b_19[31:16];              
                          
        end
endmodule
