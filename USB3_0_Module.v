`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/29 12:26:15
// Design Name: 
// Module Name: USB3_0_Module
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


module USB3_0_Module( Clk_100M,Clk_in_50m,Reset, I2C_SCL ,I2C_SDA,fdata,faddr,slrd,slwr, flaga ,flagb,flagc,flagd,sloe,slcs,pktend,Sys_Clk_ADC,ADC_Data,ADC_Data_Valid 
,DA_Ref1_usb,DA_Ref2_usb,DA_Ref3_usb,DA_Ref4_usb,laser_freq_pinc,laser_freq_pluse,trig_mode
,TDC_Peak_Flag,TDC_ACC_Flag,T3_mode,S_delay1,S_delay2,TDC_ACC_Time,TDC_single_Time,TDC_bin,TDC_Peak_Value,Start_stop_flag
,SPC_flag,T3_mode_Time,Timestamp_mode,Conforms_Counting_mode_1,Conforms_Counting_mode_2,
Spd_Delay_cnt1,Spd_Delay_cnt2,Spd_Delay_flag1,Spd_Delay_flag2,Conforms_Counting_time
,Conforms_Counting_Sync_Time,Conforms_Counting_PW,Conforms_Counting_flag


 );
input                                   Sys_Clk_ADC;
(*Mark_debug="TRUE"*)input[31:0]                             ADC_Data;   
(*Mark_debug="TRUE"*)input                                    ADC_Data_Valid;      
input                                   Clk_100M;
input                                   Clk_in_50m;
input                                   Reset;
input                                   I2C_SCL;
inout                                   I2C_SDA;
inout[31:0]                             fdata;//data bus
output[1:0]                             faddr;//output fifo address  
output                                  slrd;//output read select
output                                  slwr;//output write select
input                                   flaga;//full flag
input                                   flagb;//partial full flag
input                                    flagc;//empty flag
input                                    flagd;//empty partial flag
output                                   sloe;//output output enable select
output                                   slcs;//output chip select
output                                    pktend;//output pkt end


output[9:0]                           DA_Ref1_usb;
output[9:0]                           DA_Ref2_usb;
output[9:0]                           DA_Ref3_usb;
output[9:0]                           DA_Ref4_usb;

output[31:0]                         laser_freq_pinc;
output[7:0]                          laser_freq_pluse; 
output                               trig_mode;
output                                TDC_Peak_Flag;
output                                TDC_ACC_Flag;
output                                T3_mode;  
output[1:0]                           T3_mode_Time;
output[15:0]                           S_delay1;
output[15:0]                            S_delay2;
output[31:0]                          TDC_ACC_Time;         
output[31:0]                          TDC_single_Time; 
output[4:0]                          TDC_bin;  
output[15:0]                          TDC_Peak_Value;  
output                               Start_stop_flag;

output                               SPC_flag;  
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

wire                                RW_Cmd;
wire[7:0]                           Reg_Addr;
wire[7:0]                           W_Data;
wire[7:0]                           R_Data;
wire                                W_Valid;

wire                                rd_en;
wire[31:0]                          dout;
wire                                full;
wire                                empty;
wire                                almost_empty;
wire                                almost_full;
wire[12:0]                           rd_data_count;
wire                                wr_rst_busy;
wire                                rd_rst_busy ;

wire                               Write_Reg8b_0;
wire                                Data_Acq_Valid;








wire[31:0]                          Fifo_Din;
wire                                Fifo_Wr_En;

/*reg   clk_r;
always@(posedge Clk_in_50m or negedge Reset)
     if(Reset == 1'b1)
        begin
            clk_r             <= 1'b0;
        end
    else
        begin
            clk_r             <= ~clk_r;
        end*/
scl_debounce        scl_debounce_inst(
.clk (Clk_in_50m),// FPGA 主时钟
.scl_in(I2C_SCL ),// 原始 SCL 输入信号
.scl_out(scl_out) // 去毛刺后的 SCL 输出信号
);
I2C_Slave_Ctrl I2C_Slave_Ctrl_inst(
.Clk(Clk_in_50m),
.Rst_n(Reset),
.I2C_SCL(scl_out),
.I2C_SDA (I2C_SDA),
.RW_Cmd(RW_Cmd),
.Reg_Addr(Reg_Addr),
.W_Data(W_Data),
.R_Data(R_Data),
.W_Valid (W_Valid) 
);


Simulate_Reg_Command Simulate_Reg_Command_inst(
.Clk(Clk_in_50m),
.Rst_n(Reset),
.RW_Cmd(RW_Cmd),
.Reg_Addr(Reg_Addr),
.W_Data(W_Data),
.R_Data(R_Data),
.W_Valid (W_Valid),
.Write_Reg8b_0(Write_Reg8b_0), 
.Timestamp_mode(Timestamp_mode),
.Conforms_Counting_mode_1(Conforms_Counting_mode_1),
.Conforms_Counting_mode_2(Conforms_Counting_mode_2),
.DA_Ref1_usb(DA_Ref1_usb),
.DA_Ref2_usb(DA_Ref2_usb),
.DA_Ref3_usb(DA_Ref3_usb),
.DA_Ref4_usb(DA_Ref4_usb),
.laser_freq_pinc(laser_freq_pinc),
.laser_freq_pluse(laser_freq_pluse),
.trig_mode(trig_mode),
.TDC_Peak_Flag(TDC_Peak_Flag),
.TDC_ACC_Flag(TDC_ACC_Flag),
.T3_mode(T3_mode),
.T3_mode_Time(T3_mode_Time),
.S_delay1(S_delay1),
.S_delay2(S_delay2),
.TDC_ACC_Time(TDC_ACC_Time),
.TDC_single_Time(TDC_single_Time),
.TDC_bin(TDC_bin),
.TDC_Peak_Value(TDC_Peak_Value),
.Start_stop_flag(Start_stop_flag),
.SPC_flag(SPC_flag),
.Spd_Delay_cnt1(Spd_Delay_cnt1),
.Spd_Delay_cnt2(Spd_Delay_cnt2),
.Spd_Delay_flag1(Spd_Delay_flag1),
.Spd_Delay_flag2(Spd_Delay_flag2),
.Conforms_Counting_time(Conforms_Counting_time),
.Conforms_Counting_Sync_Time(Conforms_Counting_Sync_Time),
.Conforms_Counting_PW(Conforms_Counting_PW),
.Conforms_Counting_flag(Conforms_Counting_flag)
);


slaveFIFO2b_streamIN slaveFIFO2b_streamIN_inst(
.resetn(Reset),//input reset active low
.clk_100(Clk_100M ),//input clk 100 Mhz
.fdata(fdata),//data bus
.faddr(faddr),//output fifo address  
.slrd(slrd),//output read select
.slwr(slwr),//output write select
.flaga(flaga),//full flag
.flagb(flagb),//partial full flag
.flagc(flagc),//empty flag
.flagd(flagd),//empty partial flag
.sloe(sloe),//output output enable select
.slcs(slcs),//output chip select
.pktend(pktend),//output pkt end
.Fifo_Rd_En(rd_en),
.Fifo_Rd_Data(dout),
.Fifo_Empty(almost_empty),
.rd_data_count(rd_data_count) 
);





fifo_generator_1 fifo_inst1 (
.rst(~Start_stop_flag),// input wire rst
.wr_clk(Sys_Clk_ADC),// input wire wr_clk
.rd_clk(Clk_100M),// input wire rd_clk
.din(ADC_Data),// input wire [31 : 0] din
.wr_en(ADC_Data_Valid),// input wire wr_en
.rd_en(rd_en),// input wire rd_en
.dout(dout),// output wire [31 : 0] dout
.full(full),// output wire full
.empty(empty),// output wire empty
.almost_empty(almost_empty),
.almost_full(almost_full),// output wire almost_full
.rd_data_count(rd_data_count),// output wire [8 : 0] rd_data_count
.wr_rst_busy(wr_rst_busy),// output wire wr_rst_busy
.rd_rst_busy(rd_rst_busy)// output wire rd_rst_busy

);


endmodule
