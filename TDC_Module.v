`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/13 22:19:46
// Design Name: 
// Module Name: TDC_Module
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
              

module TDC_Module(Reset,Start1,Stop1,Stop2,Sys_Clk,Sys_Clk_out,TDC_Bin,TDC_test_time,TDC_acc_time,
TCSPC_Data_A,TCSPC_Data_Valid_A,TCSPC_Data_B,TCSPC_Data_Valid_B,TDC_tscpc_mode,TDC_tcspc_acc_num,TDC_test_flag,
T3_DATA_A,T3_DATA_A_Valid,T3_DATA_B,T3_DATA_B_Valid,Timestamp_DATA,Timestamp_DATA_Valid,SPC_flag,spc_acc_pluse,spc_acc_pluse_valid,
Conforms_Counting_mode_1,Conforms_Counting_mode_2,Stop_out1,Stop_out2,Spd_Delay_flag1,Spd_Delay_flag2
,Conforms_Counting_Sync_Time,Conforms_Counting_PW,Conforms_Counting_flag,Conforms_Counting_data_Valid,Conforms_Counting_data
);
 input              Sys_Clk;
 input              Reset;
 input              Start1;
 input              Stop1;
 input              Stop2;
input[4:0]                      TDC_Bin;




           
input[31:0]                     TDC_test_time;//测量时间
input[31:0]                     TDC_acc_time; //tcspc累积时间 
 

input                           TDC_tscpc_mode;//模式
input[15:0]                     TDC_tcspc_acc_num;   
output[15:0]                    TCSPC_Data_A;
output                          TCSPC_Data_Valid_A;
output[15:0]                    TCSPC_Data_B;
output                          TCSPC_Data_Valid_B;
input                           TDC_test_flag;
output                          Sys_Clk_out;
output[30:0]                    T3_DATA_A;
output                          T3_DATA_A_Valid;
output[30:0]                    T3_DATA_B;
output                          T3_DATA_B_Valid;
output[31:0]                    Timestamp_DATA;
output                          Timestamp_DATA_Valid;

output[31:0]                                          Conforms_Counting_data;
output                                                Conforms_Counting_data_Valid;  


input                           SPC_flag;
input                           Conforms_Counting_mode_1;
input                           Conforms_Counting_mode_2;
output[31:0]                    spc_acc_pluse;
output                          spc_acc_pluse_valid;
input[15:0]                     Conforms_Counting_Sync_Time;
input[15:0]                     Conforms_Counting_PW;
input                           Conforms_Counting_flag;
wire                            Sys_Clk1;   
wire                            Sys_Clk2;  
wire                            Sys_Clk3;  
wire                            Sys_Clk4;  
wire                            Sys_Clk5;  
wire                            Sys_Clk6;  
wire                            Sys_Clk7;  
wire                            Sys_Clk8;  

assign   Sys_Clk_out=Sys_Clk1;

input                           Stop_out1;
input                           Stop_out2;
input                           Spd_Delay_flag1;//1不延时，0延时
input                           Spd_Delay_flag2;//1不延时，0延时


Gen_TDC_Clock Gen_TDC_Clock_inst(
.clk_in(Sys_Clk),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8)
    );


//总计数器

(*Mark_debug="TRUE"*)wire[21:0]             count_abs;


counter counter_inst(
.Sys_Clk(Sys_Clk1),
.Reset(Reset),
.count_abs(count_abs)
);


//多相位TDC模块


(*Mark_debug="TRUE"*)wire[21:0]             Trig_Counter_Period_1_1;
(*Mark_debug="TRUE"*)wire[3:0]              Trig_Phase_Value_1_1;
(*Mark_debug="TRUE"*)wire                   Trig_Data_Valid_1_1;
(*Mark_debug="TRUE"*)wire[21:0]             Trig_Counter_Period_1_2;
(*Mark_debug="TRUE"*)wire[3:0]              Trig_Phase_Value_1_2;
(*Mark_debug="TRUE"*)wire                   Trig_Data_Valid_1_2;
(*Mark_debug="TRUE"*)wire[21:0]             Trig_Counter_Period_1_3;
(*Mark_debug="TRUE"*)wire[3:0]              Trig_Phase_Value_1_3;
(*Mark_debug="TRUE"*)wire                   Trig_Data_Valid_1_3;
(*Mark_debug="TRUE"*)wire[21:0]             Trig_Counter_Period_1_4;
(*Mark_debug="TRUE"*)wire[3:0]              Trig_Phase_Value_1_4;
(*Mark_debug="TRUE"*)wire                   Trig_Data_Valid_1_4;



(*Mark_debug="TRUE"*)wire[21:0]			 Stop_Counter_Period_1_1;
(*Mark_debug="TRUE"*)wire[3:0]              Stop_Phase_Value_1_1;	
(*Mark_debug="TRUE"*)wire					 Stop_Data_Valid_1_1;

(*Mark_debug="TRUE"*)wire[21:0]			 Stop_Counter_Period_1_2;
(*Mark_debug="TRUE"*)wire[3:0]              Stop_Phase_Value_1_2;	
(*Mark_debug="TRUE"*)wire					 Stop_Data_Valid_1_2;

(*Mark_debug="TRUE"*)wire[21:0]			 Stop_Counter_Period_1_3;
(*Mark_debug="TRUE"*)wire[3:0]              Stop_Phase_Value_1_3;	
(*Mark_debug="TRUE"*)wire					 Stop_Data_Valid_1_3;

(*Mark_debug="TRUE"*)wire[21:0]			 Stop_Counter_Period_1_4;
(*Mark_debug="TRUE"*)wire[3:0]              Stop_Phase_Value_1_4;	
(*Mark_debug="TRUE"*)wire					 Stop_Data_Valid_1_4;


(*Mark_debug="TRUE"*)wire[21:0]			 Stop_Counter_Period_2_1;
(*Mark_debug="TRUE"*)wire[3:0]              Stop_Phase_Value_2_1;	
(*Mark_debug="TRUE"*)wire					 Stop_Data_Valid_2_1;

(*Mark_debug="TRUE"*)wire[21:0]			 Stop_Counter_Period_2_2;
(*Mark_debug="TRUE"*)wire[3:0]              Stop_Phase_Value_2_2;	
(*Mark_debug="TRUE"*)wire					 Stop_Data_Valid_2_2;

(*Mark_debug="TRUE"*)wire[21:0]			 Stop_Counter_Period_2_3;
(*Mark_debug="TRUE"*)wire[3:0]              Stop_Phase_Value_2_3;	
(*Mark_debug="TRUE"*)wire					 Stop_Data_Valid_2_3;

(*Mark_debug="TRUE"*)wire[21:0]			 Stop_Counter_Period_2_4;
(*Mark_debug="TRUE"*)wire[3:0]              Stop_Phase_Value_2_4;	
(*Mark_debug="TRUE"*)wire					 Stop_Data_Valid_2_4;


  
(*Mark_debug="TRUE"*)wire                start1_tdc1; 
(*Mark_debug="TRUE"*)wire                start1_tdc2; 
(*Mark_debug="TRUE"*)wire                start1_tdc3; 
(*Mark_debug="TRUE"*)wire                start1_tdc4; 
(*Mark_debug="TRUE"*)wire                start1_tdc5; 
(*Mark_debug="TRUE"*)wire                start1_tdc6; 
(*Mark_debug="TRUE"*)wire                stop1_tdc1; 
(*Mark_debug="TRUE"*)wire                stop1_tdc2; 
(*Mark_debug="TRUE"*)wire                stop1_tdc3; 
(*Mark_debug="TRUE"*)wire                stop1_tdc4; 
(*Mark_debug="TRUE"*)wire                stop1_tdc5; 
(*Mark_debug="TRUE"*)wire                stop1_tdc6; 

(*Mark_debug="TRUE"*)wire                stop2_tdc1; 
(*Mark_debug="TRUE"*)wire                stop2_tdc2; 
(*Mark_debug="TRUE"*)wire                stop2_tdc3; 
(*Mark_debug="TRUE"*)wire                stop2_tdc4; 
(*Mark_debug="TRUE"*)wire                stop2_tdc5; 
(*Mark_debug="TRUE"*)wire                stop2_tdc6; 
(*Mark_debug="TRUE"*)wire                Start1_bug_tdc1;
(*Mark_debug="TRUE"*)wire                Start1_bug_tdc2;
(*Mark_debug="TRUE"*)wire                Start1_bug_tdc3;
(*Mark_debug="TRUE"*)wire                Start1_bug_tdc4;
(*Mark_debug="TRUE"*)wire                Start1_bug_tdc5;
(*Mark_debug="TRUE"*)wire                Start1_bug_tdc6;
(*Mark_debug="TRUE"*)wire                Stop1_bug_tdc1;    
(*Mark_debug="TRUE"*)wire                Stop1_bug_tdc2;  
(*Mark_debug="TRUE"*)wire                Stop1_bug_tdc3;  
(*Mark_debug="TRUE"*)wire                Stop1_bug_tdc4;  
(*Mark_debug="TRUE"*)wire                Stop1_bug_tdc5;  
(*Mark_debug="TRUE"*)wire                Stop1_bug_tdc6;  


(*Mark_debug="TRUE"*)wire                Stop2_bug_tdc1; 
(*Mark_debug="TRUE"*)wire                Stop2_bug_tdc2;  
(*Mark_debug="TRUE"*)wire                Stop2_bug_tdc3;  
(*Mark_debug="TRUE"*)wire                Stop2_bug_tdc4; 
(*Mark_debug="TRUE"*)wire                Stop2_bug_tdc5;  
(*Mark_debug="TRUE"*)wire                Stop2_bug_tdc6; 
LUT1 #(
.INIT(2'b01) 
) LUT1_inst1 (
.O(start1_tdc1),   // LUT general output
.I0(Start1)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst2 (
.O(Start1_bug_tdc1),   // LUT general output
.I0(start1_tdc1)  // LUT input
);
  

   
LUT1 #(
.INIT(2'b01) 
) LUT1_inst3 (
.O(start1_tdc2),   // LUT general output
.I0(Start1_bug_tdc1)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst4 (
.O(Start1_bug_tdc2),   // LUT general output
.I0(start1_tdc2)  // LUT input
);
      
LUT1 #(
.INIT(2'b01) 
) LUT1_inst5 (
.O(start1_tdc3),   // LUT general output
.I0(Start1_bug_tdc2)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst6 (
.O(Start1_bug_tdc3),   // LUT general output
.I0(start1_tdc3)  // LUT input
);   
   

LUT1 #(
.INIT(2'b01) 
) LUT1_inst5_1 (
.O(start1_tdc4),   // LUT general output
.I0(Start1_bug_tdc3)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst6_2 (
.O(Start1_bug_tdc4),   // LUT general output
.I0(start1_tdc4)  // LUT input
);  

LUT1 #(
.INIT(2'b01) 
) LUT1_inst5_3 (
.O(start1_tdc5),   // LUT general output
.I0(Start1_bug_tdc4)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst6_4 (
.O(Start1_bug_tdc5),   // LUT general output
.I0(start1_tdc5)  // LUT input
);  


LUT1 #(
.INIT(2'b01) 
) LUT1_inst5_5 (
.O(start1_tdc6),   // LUT general output
.I0(Start1_bug_tdc5)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst6_6 (
.O(Start1_bug_tdc6),   // LUT general output
.I0(start1_tdc6)  // LUT input
);  


   
   
LUT1 #(
.INIT(2'b01) 
) LUT1_inst7 (
.O(stop1_tdc1),   // LUT general output
.I0(Stop1)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst8 (
.O(Stop1_bug_tdc1),   // LUT general output
.I0(stop1_tdc1)  // LUT input
);
   
LUT1 #(
.INIT(2'b01) 
) LUT1_inst9 (
.O(stop1_tdc2),   // LUT general output
.I0(Stop1_bug_tdc1)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst10 (
.O(Stop1_bug_tdc2),   // LUT general output
.I0(stop1_tdc2)  // LUT input
);
      
LUT1 #(
.INIT(2'b01) 
) LUT1_inst11 (
.O(stop1_tdc3),   // LUT general output
.I0(Stop1_bug_tdc2)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst12 (
.O(Stop1_bug_tdc3),   // LUT general output
.I0(stop1_tdc3)  // LUT input
);     


LUT1 #(
.INIT(2'b01) 
) LUT1_inst11_1 (
.O(stop1_tdc4),   // LUT general output
.I0(Stop1_bug_tdc3)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst12_1 (
.O(Stop1_bug_tdc4),   // LUT general output
.I0(stop1_tdc4)  // LUT input
);     

LUT1 #(
.INIT(2'b01) 
) LUT1_inst11_3 (
.O(stop1_tdc5),   // LUT general output
.I0(Stop1_bug_tdc4)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst12_4 (
.O(Stop1_bug_tdc5),   // LUT general output
.I0(stop1_tdc5)  // LUT input
);     


LUT1 #(
.INIT(2'b01) 
) LUT1_inst11_5 (
.O(stop1_tdc6),   // LUT general output
.I0(Stop1_bug_tdc5)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst12_6 (
.O(Stop1_bug_tdc6),   // LUT general output
.I0(stop1_tdc6)  // LUT input
);     
   
   
LUT1 #(
.INIT(2'b01) 
) LUT1_inst19 (
.O(stop2_tdc1),   // LUT general output
.I0(Stop2)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst20 (
.O(Stop2_bug_tdc1),   // LUT general output
.I0(stop2_tdc1)  // LUT input
);
   
LUT1 #(
.INIT(2'b01) 
) LUT1_inst21 (
.O(stop2_tdc2),   // LUT general output
.I0(Stop2_bug_tdc1)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst22 (
.O(Stop2_bug_tdc2),   // LUT general output
.I0(stop2_tdc2)  // LUT input
);
      
LUT1 #(
.INIT(2'b01) 
) LUT1_inst23 (
.O(stop2_tdc3),   // LUT general output
.I0(Stop2_bug_tdc2)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst24 (
.O(Stop2_bug_tdc3),   // LUT general output
.I0(stop2_tdc3)  // LUT input
);  

LUT1 #(
.INIT(2'b01) 
) LUT1_inst23_1 (
.O(stop2_tdc4),   // LUT general output
.I0(Stop2_bug_tdc3)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst24_1 (
.O(Stop2_bug_tdc4),   // LUT general output
.I0(stop2_tdc4)  // LUT input
);  

LUT1 #(
.INIT(2'b01) 
) LUT1_inst23_2 (
.O(stop2_tdc5),   // LUT general output
.I0(Stop2_bug_tdc4)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst24_3 (
.O(Stop2_bug_tdc5),   // LUT general output
.I0(stop2_tdc5)  // LUT input
);  

LUT1 #(
.INIT(2'b01) 
) LUT1_inst23_4 (
.O(stop2_tdc6),   // LUT general output
.I0(Stop2_bug_tdc5)  // LUT input
);

LUT1 #(
.INIT(2'b01) 
) LUT1_inst24_5 (
.O(Stop2_bug_tdc6),   // LUT general output
.I0(stop2_tdc6)  // LUT input
);  



TDC_Counter_Phase_Clk  Trig_1_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Trig_Counter_Period_1_1),
.Phase_Value(Trig_Phase_Value_1_1),
.Valid_flag(Trig_Data_Valid_1_1),
.Signal_TDC(Start1_bug_tdc1)
    );
	
 TDC_Counter_Phase_Clk  Trig_2_TDC_Counter_Phase_Clk_inst(
 .Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Trig_Counter_Period_1_2),
.Phase_Value(Trig_Phase_Value_1_2),
.Valid_flag(Trig_Data_Valid_1_2),
.Signal_TDC(Start1_bug_tdc1)
    );  	

TDC_Counter_Phase_Clk  Trig_3_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Trig_Counter_Period_1_3),
.Phase_Value(Trig_Phase_Value_1_3),
.Valid_flag(Trig_Data_Valid_1_3),
.Signal_TDC(Start1_bug_tdc1)
    ); 

TDC_Counter_Phase_Clk  Trig_4_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Trig_Counter_Period_1_4),
.Phase_Value(Trig_Phase_Value_1_4),
.Valid_flag(Trig_Data_Valid_1_4),
.Signal_TDC(Start1_bug_tdc1)
    );	

TDC_Counter_Phase_Clk  Stop_1_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Stop_Counter_Period_1_1),
.Phase_Value(Stop_Phase_Value_1_1),
.Valid_flag(Stop_Data_Valid_1_1),
.Signal_TDC(Stop1_bug_tdc1)
    );
	
 TDC_Counter_Phase_Clk  Stop_2_TDC_Counter_Phase_Clk_inst(
 .Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Stop_Counter_Period_1_2),
.Phase_Value(Stop_Phase_Value_1_2),
.Valid_flag(Stop_Data_Valid_1_2),
.Signal_TDC(Stop1_bug_tdc1)
    );  	

TDC_Counter_Phase_Clk  Stop_3_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Stop_Counter_Period_1_3),
.Phase_Value(Stop_Phase_Value_1_3),
.Valid_flag(Stop_Data_Valid_1_3),
.Signal_TDC(Stop1_bug_tdc1)
    ); 

TDC_Counter_Phase_Clk  Stop_4_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Stop_Counter_Period_1_4),
.Phase_Value(Stop_Phase_Value_1_4),
.Valid_flag(Stop_Data_Valid_1_4),
.Signal_TDC(Stop1_bug_tdc1)
    );	
	
TDC_Counter_Phase_Clk  Stop_5_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Stop_Counter_Period_2_1),
.Phase_Value(Stop_Phase_Value_2_1),
.Valid_flag(Stop_Data_Valid_2_1),
.Signal_TDC(Stop2_bug_tdc2)
    );
	
 TDC_Counter_Phase_Clk  Stop_6_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Stop_Counter_Period_2_2),
.Phase_Value(Stop_Phase_Value_2_2),
.Valid_flag(Stop_Data_Valid_2_2),
.Signal_TDC(Stop2_bug_tdc3)
    );  	

TDC_Counter_Phase_Clk  Stop_7_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Stop_Counter_Period_2_3),
.Phase_Value(Stop_Phase_Value_2_3),
.Valid_flag(Stop_Data_Valid_2_3),
.Signal_TDC(Stop2_bug_tdc2)
    ); 

TDC_Counter_Phase_Clk  Stop_8_TDC_Counter_Phase_Clk_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk1),
.Sys_Clk2(Sys_Clk2),
.Sys_Clk3(Sys_Clk3),
.Sys_Clk4(Sys_Clk4),
.Sys_Clk5(Sys_Clk5),
.Sys_Clk6(Sys_Clk6),
.Sys_Clk7(Sys_Clk7),
.Sys_Clk8(Sys_Clk8),
.Counter_Value(Stop_Counter_Period_2_4),
.Phase_Value(Stop_Phase_Value_2_4),
.Valid_flag(Stop_Data_Valid_2_4),
.Signal_TDC(Stop2_bug_tdc3)
    );		


	

(*Mark_debug="TRUE"*)wire[23:0]                              Trig_Counter_Period_delay_1;
(*Mark_debug="TRUE"*)wire                                    Trig_Data_Valid_delay_1;
(*Mark_debug="TRUE"*)wire[23:0]		                        Stop_Counter_Period_delay_1_1;
(*Mark_debug="TRUE"*)wire					               Stop_Data_Valid_delay_1_1;
(*Mark_debug="TRUE"*)wire[23:0]			                   Stop_Counter_Period_delay_2_1;	
(*Mark_debug="TRUE"*)wire					               Stop_Data_Valid_delay_2_1;
 	
	
	Delay_SPD_TDC Delay_SPD_TDC_inst(
	.Reset(Reset),
	.Sys_Clk1(Sys_Clk1),
	.Start(Start1),
	.Stop_out1(Stop_out1),
	.Stop_out2(Stop_out2),
	.Trig_Counter_Period_delay_1(Trig_Counter_Period_delay_1),
	.Trig_Data_Valid_delay_1(Trig_Data_Valid_delay_1),
    .Stop_Counter_Period_delay_1_1(Stop_Counter_Period_delay_1_1),
    .Stop_Data_Valid_delay_1_1(Stop_Data_Valid_delay_1_1),
    .Stop_Counter_Period_delay_2_1(Stop_Counter_Period_delay_2_1),
    .Stop_Data_Valid_delay_2_1(Stop_Data_Valid_delay_2_1),
    .count_abs(count_abs)
    );
	




(*Mark_debug="TRUE"*)wire[31:0]                              Timestamp_DATA;
(*Mark_debug="TRUE"*)wire                                    Timestamp_DATA_Valid;
(*Mark_debug="TRUE"*)wire[27:0]                              Sync_data;
(*Mark_debug="TRUE"*)wire                                    Sync_data_Valid;
(*Mark_debug="TRUE"*)wire[27:0]                              Spd1_Stop_data;
(*Mark_debug="TRUE"*)wire                                    Spd1_Stop_data_Valid;
(*Mark_debug="TRUE"*)wire[27:0]                              Spd2_Stop_data;
(*Mark_debug="TRUE"*)wire                                    Spd2_Stop_data_Valid;

(*Mark_debug="TRUE"*)wire[5:0]                              Sync_data_fine;
(*Mark_debug="TRUE"*)wire[5:0]                              Spd1_Stop_data_fine;
(*Mark_debug="TRUE"*)wire[5:0]                              Spd2_Stop_data_fine;


 Timestamp_mode_Module Timestamp_mode_Module_inst(
.TDC_test_flag(TDC_test_flag),
.Stop_Counter_Period_1_1(Stop_Counter_Period_1_1),
.Stop_Phase_Value_1_1(Stop_Phase_Value_1_1),
.Stop_Data_Valid_1_1(Stop_Data_Valid_1_1),
.Stop_Counter_Period_1_2(Stop_Counter_Period_1_2),
.Stop_Phase_Value_1_2(Stop_Phase_Value_1_2),
.Stop_Data_Valid_1_2(Stop_Data_Valid_1_2),
.Stop_Counter_Period_1_3(Stop_Counter_Period_1_3),
.Stop_Phase_Value_1_3(Stop_Phase_Value_1_3),
.Stop_Data_Valid_1_3(Stop_Data_Valid_1_3),
.Stop_Counter_Period_1_4(Stop_Counter_Period_1_4),
.Stop_Phase_Value_1_4(Stop_Phase_Value_1_4),
.Stop_Data_Valid_1_4(Stop_Data_Valid_1_4),
.Stop_Counter_Period_2_1(Stop_Counter_Period_2_1),
.Stop_Phase_Value_2_1(Stop_Phase_Value_2_1),
.Stop_Data_Valid_2_1(Stop_Data_Valid_2_1),
.Stop_Counter_Period_2_2(Stop_Counter_Period_2_2),
.Stop_Phase_Value_2_2(Stop_Phase_Value_2_2),
.Stop_Data_Valid_2_2(Stop_Data_Valid_2_2),
.Stop_Counter_Period_2_3(Stop_Counter_Period_2_3),
.Stop_Phase_Value_2_3(Stop_Phase_Value_2_3),
.Stop_Data_Valid_2_3(Stop_Data_Valid_2_3),
.Stop_Counter_Period_2_4(Stop_Counter_Period_2_4),
.Stop_Phase_Value_2_4(Stop_Phase_Value_2_4),
.Stop_Data_Valid_2_4(Stop_Data_Valid_2_4),

.Trig_Counter_Period_1_1(Trig_Counter_Period_1_1),
.Trig_Phase_Value_1_1(Trig_Phase_Value_1_1),
.Trig_Data_Valid_1_1(Trig_Data_Valid_1_1),
.Trig_Counter_Period_1_2(Trig_Counter_Period_1_2),
.Trig_Phase_Value_1_2(Trig_Phase_Value_1_2),
.Trig_Data_Valid_1_2(Trig_Data_Valid_1_2),
.Trig_Counter_Period_1_3(Trig_Counter_Period_1_3),
.Trig_Phase_Value_1_3(Trig_Phase_Value_1_3),
.Trig_Data_Valid_1_3(Trig_Data_Valid_1_3),
.Trig_Counter_Period_1_4(Trig_Counter_Period_1_4),
.Trig_Phase_Value_1_4(Trig_Phase_Value_1_4),
.Trig_Data_Valid_1_4(Trig_Data_Valid_1_4),
.Sys_Clk(Sys_Clk1),
.Reset(Reset),
.Spd_Delay_flag1(Spd_Delay_flag1),
.Spd_Delay_flag2(Spd_Delay_flag2),
.Trig_Counter_Period_delay_1(Trig_Counter_Period_delay_1),
.Trig_Data_Valid_delay_1(Trig_Data_Valid_delay_1),
.Stop_Counter_Period_delay_1_1(Stop_Counter_Period_delay_1_1),
.Stop_Data_Valid_delay_1_1(Stop_Data_Valid_delay_1_1),
.Stop_Counter_Period_delay_2_1(Stop_Counter_Period_delay_2_1),
.Stop_Data_Valid_delay_2_1(Stop_Data_Valid_delay_2_1),
.Timestamp_DATA(Timestamp_DATA),
.Timestamp_DATA_Valid(Timestamp_DATA_Valid),
.Sync_data(Sync_data),
.Sync_data_Valid(Sync_data_Valid),
.Spd1_Stop_data(Spd1_Stop_data),
.Spd1_Stop_data_Valid(Spd1_Stop_data_Valid),
.Spd2_Stop_data(Spd2_Stop_data),
.Spd2_Stop_data_Valid(Spd2_Stop_data_Valid),
.Sync_data_fine(Sync_data_fine),
.Spd1_Stop_data_fine(Spd1_Stop_data_fine),
.Spd2_Stop_data_fine(Spd2_Stop_data_fine)
);



(*Mark_debug="TRUE"*)wire[31:0]                                                    Conforms_Counting_data;
(*Mark_debug="TRUE"*)wire                                                          Conforms_Counting_data_Valid;   
(*Mark_debug="TRUE"*)wire[31:0]                                                    Conforms_Counting_data_1;
(*Mark_debug="TRUE"*)wire                                                          Conforms_Counting_data_Valid_1;   

Conforms_Counting_mode Conforms_Counting_mode_inst(
.Sync_data_Valid(Sync_data_Valid),
.Spd1_Stop_data(Spd1_Stop_data),
.Spd1_Stop_data_Valid(Spd1_Stop_data_Valid),
.Spd2_Stop_data(Spd2_Stop_data),
.Spd2_Stop_data_Valid(Spd2_Stop_data_Valid),
.Spd1_Stop_data_fine(Spd1_Stop_data_fine),
.Spd2_Stop_data_fine(Spd2_Stop_data_fine),
.Sys_Clk(Sys_Clk1),
.Reset(Reset),
.Conforms_Counting_Sync_Time(Conforms_Counting_Sync_Time),
.Conforms_Counting_PW(Conforms_Counting_PW),
.Conforms_Counting_flag(Conforms_Counting_flag),
.Start_stop_flag(TDC_test_flag),
.Conforms_Counting_data_1(Conforms_Counting_data_1),
.Conforms_Counting_data_Valid_1(Conforms_Counting_data_Valid_1),
.Conforms_Counting_data_2(Conforms_Counting_data),
.Conforms_Counting_data_Valid_2(Conforms_Counting_data_Valid),
.Conforms_Counting_mode_1(Conforms_Counting_mode_1),
.Conforms_Counting_mode_2(Conforms_Counting_mode_2)
    );




(*Mark_debug="TRUE"*)wire[11:0]                              TDC_DATA_BIN_A;
(*Mark_debug="TRUE"*)wire                                    TDC_DATA_BIN_A_Valid;
(*Mark_debug="TRUE"*)wire[11:0]                              TDC_DATA_BIN_B;
(*Mark_debug="TRUE"*)wire                                    TDC_DATA_BIN_B_Valid;

TDC_Cal_Cache TDC_Cal_Cache_inst(
.Sys_Clk(Sys_Clk1),
.Reset(Reset),
.TDC_Bin(TDC_Bin),
.TDC_test_flag(TDC_test_flag),
.Sync_data(Sync_data),
.Sync_data_Valid(Sync_data_Valid),
.Spd1_Stop_data(Spd1_Stop_data),
.Spd1_Stop_data_Valid(Spd1_Stop_data_Valid),
.Spd2_Stop_data(Spd2_Stop_data),
.Spd2_Stop_data_Valid(Spd2_Stop_data_Valid),
.Sync_data_fine(Sync_data_fine),
.Spd1_Stop_data_fine(Spd1_Stop_data_fine),
.Spd2_Stop_data_fine(Spd2_Stop_data_fine),
.Conforms_Counting_data_1(Conforms_Counting_data_1),
.Conforms_Counting_data_Valid_1(Conforms_Counting_data_Valid_1),
.Conforms_Counting_mode_1(Conforms_Counting_mode_1),
.T3_DATA_A(T3_DATA_A),
.T3_DATA_A_Valid(T3_DATA_A_Valid),
.T3_DATA_B(T3_DATA_B),
.T3_DATA_B_Valid(T3_DATA_B_Valid),
.TDC_DATA_BIN_A(TDC_DATA_BIN_A),
.TDC_DATA_BIN_A_Valid(TDC_DATA_BIN_A_Valid),
.TDC_DATA_BIN_B(TDC_DATA_BIN_B),
.TDC_DATA_BIN_B_Valid(TDC_DATA_BIN_B_Valid)
);

TDC_TCSPC_Module TDC_TCSPC_Module_inst1(
.clk_sys_400m(Sys_Clk1),
.Reset(Reset),
.test_flag(TDC_test_flag),
.test_time(TDC_test_time),
.acc_time(TDC_acc_time),
.TCSPC_Data(TCSPC_Data_A),
.TCSPC_Data_Valid(TCSPC_Data_Valid_A),
.Start(Start1),
.tscpc_mode(TDC_tscpc_mode),
.Conforms_Counting_mode( Conforms_Counting_mode_1),
.tcspc_acc_num(TDC_tcspc_acc_num),
.TDC_Data(TDC_DATA_BIN_A),
.TDC_Data_Valid(TDC_DATA_BIN_A_Valid)
    );
TDC_TCSPC_Module TDC_TCSPC_Module_inst2(
.clk_sys_400m(Sys_Clk1),
.Reset(Reset),
.test_flag(TDC_test_flag),
.test_time(TDC_test_time),
.acc_time(TDC_acc_time),
.TCSPC_Data(TCSPC_Data_B),
.TCSPC_Data_Valid(TCSPC_Data_Valid_B),
.Start(Start1),
.tscpc_mode(TDC_tscpc_mode),
.Conforms_Counting_mode(),
.tcspc_acc_num(TDC_tcspc_acc_num),
.TDC_Data(TDC_DATA_BIN_B),
.TDC_Data_Valid(TDC_DATA_BIN_B_Valid)
);


SPC_Module SPC_Module_inst(
.clk_sys_400m(Sys_Clk1),
.Reset(Reset),
.Stop(Stop2),
.Start(Stop1),
.SPC_flag(SPC_flag),
.Start_stop_flag(TDC_test_flag),
.spc_acc_pluse(spc_acc_pluse),
.spc_acc_pluse_valid(spc_acc_pluse_valid)
);

endmodule
