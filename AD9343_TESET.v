`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//    
// Create Date: 2025/05/10 09:44:32
// Design Name: 
// Module Name: AD9343_TESET
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
                                                    
                            
module AD9343_TESET(Clk_in,
I2C_SCL ,I2C_SDA , Clk_100M_PR,fdata, faddr,slrd,slwr, flaga,flagb, flagc,flagd,sloe,slcs,pktend,Led_out
,fpga_din1,fpga_sclk1,fpga_cs1,fpga_din2,fpga_sclk2,fpga_cs2
,fpga_din3,fpga_sclk3,fpga_cs3
,FPGA_START_OUT,FPGA_STOP_OUT_2,FPGA_STOP_OUT_1,Start_2,F_Start_2,
Start_in1,Stop_in1,Stop_in2
 );

input                           Clk_in;
                                            

output[3:0]                     Led_out;
assign Led_out[0]=1'b0;
assign Led_out[1]=1'b1;
assign Led_out[2]=1'b0;
assign Led_out[3]=1'b1;

 
//usb3.0接口
input                                   I2C_SCL;
inout                                   I2C_SDA;
output                                  Clk_100M_PR;//output clk 100 Mhz and 180 phase shift
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


output                           fpga_din1;
output                           fpga_sclk1;
output                           fpga_cs1;
output                           fpga_din2;
output                           fpga_sclk2;
output                           fpga_cs2;
output                           fpga_din3;
output                           fpga_sclk3;
output                           fpga_cs3;




output                          FPGA_START_OUT;
output                          FPGA_STOP_OUT_2;
output                          FPGA_STOP_OUT_1;

input                           Start_in1;
input                           Stop_in1;
input                           Stop_in2;
output                          Start_2;
output                          F_Start_2;
wire                          FPGA_START_OUT_bug;
wire                          FPGA_STOP_OUT_2_bug;
wire                          FPGA_STOP_OUT_1_bug;

assign  Start_2=FPGA_START_OUT_bug;
assign   FPGA_START_OUT=FPGA_START_OUT_bug;
assign   FPGA_STOP_OUT_2=FPGA_STOP_OUT_2_bug;
assign  FPGA_STOP_OUT_1=FPGA_STOP_OUT_1_bug;
/*   BUFG BUFG_inst1 (
      .O(Start_2), // 1-bit output: Clock output
      .I(FPGA_START_OUT_bug)  // 1-bit input: Clock input
   );*/

/*   BUFG BUFG_inst2 (
      .O(FPGA_START_OUT), // 1-bit output: Clock output
      .I(FPGA_START_OUT_bug)  // 1-bit input: Clock input
   );
     BUFG BUFG_inst3 (
      .O(FPGA_STOP_OUT_2), // 1-bit output: Clock output
      .I(FPGA_STOP_OUT_2_bug)  // 1-bit input: Clock input
   );
   
      BUFG BUFG_inst4 (
      .O(FPGA_STOP_OUT_1), // 1-bit output: Clock output
      .I(FPGA_STOP_OUT_1_bug)  // 1-bit input: Clock input
   ); */
   
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

wire clk_sys_400m;
wire  Clk_in_50m;
wire Reset;
wire    ref_clk;
wire    Clk_100M;
wire    Clk_100M_PR;
Gen_Sys_Clk Gen_Sys_Clk_inst(
.Reset(Reset),
//.adc_clk_out(clk_sys_400m),
.Clk_100M_PR(Clk_100M_PR),
.Clk_100M(Clk_100M),
.Clk_in_50m(Clk_in_50m),
.Clk_in(Clk_in)
    );

reg         clk_50;
wire                                Sys_Clk_400m;
reg[9:0]             DA_Ref1;
reg[9:0]             DA_Ref2;
reg[9:0]             DA_Ref3;
reg[9:0]             DA_Ref4;





reg                  da_start1;
reg                  da_start2;
reg                  da_start3;
reg                  da_start4;

reg[10:0]             cnt_ad;


//(*Mark_debug="TRUE"*)reg                           Start_in1_r;
//(*Mark_debug="TRUE"*)reg                           Start_in2_r;
//(*Mark_debug="TRUE"*)reg                           Stop_in1_r;
//(*Mark_debug="TRUE"*)reg                           Stop_in2_r;

//always@(posedge Sys_Clk_400m)
//    begin
//        Start_in1_r <= Start_in1;
//        Start_in2_r <= Start_in2;     
        
//        Stop_in1_r <= Stop_in1;
//        Stop_in2_r <= Stop_in2;       
          
//    end


wire[9:0]             DA_Ref1_usb;
wire[9:0]             DA_Ref2_usb;
wire[9:0]             DA_Ref3_usb;
wire[9:0]             DA_Ref4_usb;
wire[31:0]                         laser_freq_pinc;
wire[7:0]                          laser_freq_pluse; 
wire                               trig_mode;
wire                                TDC_Peak_Flag;
wire                                TDC_ACC_Flag;

wire                                T3_mode;  
wire[1:0]                           T3_mode_Time;
wire[15:0]                           S_delay1;
wire[15:0]                          S_delay2;
wire[31:0]                          TDC_ACC_Time;         
wire[31:0]                          TDC_single_Time; 
wire[4:0]                          TDC_Bin;  
wire[15:0]                          TDC_Peak_Value;  
wire                               Start_stop_flag;


assign                          F_Start_2=trig_mode;//外出发为1，内触发为0
wire                                Timestamp_mode;
reg[32:0]                           cnt_T3_time_r;
reg[32:0]                           cnt_T3_time;
reg                                 T3_mode_flag;                       
reg                                 Start_stop_flag_r;
reg                                 Start_stop_flag_r1;
reg[1:0]                            fms_flag;

wire[14:0]                        Spd_Delay_cnt1;
wire[14:0]                        Spd_Delay_cnt2;
wire                              Spd_Delay_flag1;
wire                              Spd_Delay_flag2;
wire                                Stop_out1;
wire                                Stop_out2;


reg                              Stop_in1_r;
reg                              Stop_in2_r;  

/*always@(Spd_Delay_flag1,Stop_out1,Stop_in1)
    begin
        case(Spd_Delay_flag1)
     1'b0:
        begin
            Stop_in1_r           <= Stop_out1;
        end
     1'b1:
        begin
            Stop_in1_r           <= Stop_in1;
        end
    default:
        begin
        end
     endcase
    
    end

always@(Spd_Delay_flag2,Stop_out2,Stop_in2)
    begin
        case(Spd_Delay_flag2)
     1'b0:
        begin
            Stop_in2_r           <= Stop_out2;
        end
     1'b1:
        begin
            Stop_in2_r           <= Stop_in2;
        end
    default:
        begin
        end
     endcase
    
    end*/


Delay_Stop_Signal Delay_Stop_Signal_inst(
.Reset(Reset),
.Sys_Clk1(Sys_Clk_400m),
.Stop_in1(Stop_in1),
.Stop_in2(Stop_in2),
.Stop_out1(Stop_out1),
.Stop_out2(Stop_out2),
.Delay_cnt1(Spd_Delay_cnt1),
.Delay_cnt2(Spd_Delay_cnt2)
    );

reg                 T3_mode_r1;
reg                 T3_mode_r2;
(*Mark_debug="TRUE"*)reg                 Start_stop_flag_r2;
always@(posedge Sys_Clk_400m or negedge Reset)
    if(Reset == 1'b1)
        begin
            cnt_T3_time             <= 33'd0;
            cnt_T3_time_r           <= 33'd0;
            T3_mode_flag            <= 1'b0;
            Start_stop_flag_r       <= 1'b0;
            Start_stop_flag_r1      <= 1'b0;
            fms_flag                <= 2'd0;
            T3_mode_r1              <= 1'b0;
            T3_mode_r2              <= 1'b0;
            Start_stop_flag_r2  <= 1'b0;
        end
    else
        begin
            T3_mode_r1              <= T3_mode;
            T3_mode_r2              <= T3_mode_r1;
        Start_stop_flag_r           <= Start_stop_flag;
        Start_stop_flag_r1          <= Start_stop_flag_r;
          Start_stop_flag_r2          <= Start_stop_flag_r1;      
        if(Start_stop_flag == 1'b0)
            begin
               T3_mode_flag         <= 1'b0;
               cnt_T3_time          <= 33'd0; 
               fms_flag             <= 2'd0;
            end
         else
            begin
                case(fms_flag)
            2'd0:
                begin
                       T3_mode_flag        <= 1'b0;
                    if((Start_stop_flag_r1 == 1'b1) && (Start_stop_flag_r2 == 1'b0) && (T3_mode_r2 == 1'b1))
                        fms_flag        <= 2'd1;
                    else
                        fms_flag        <= 2'd0;
                end
            2'd1:
                begin
                    T3_mode_flag        <= 1'b1;
                    if(cnt_T3_time == cnt_T3_time_r)
                        begin
                            cnt_T3_time     <= 33'd0;
                            fms_flag        <= 2'd2;
                        end
                    else
                        begin
                            cnt_T3_time     <= cnt_T3_time + 33'd1;
                            fms_flag        <= 2'd1;
                        end
                end
              2'd2:
                begin
                     T3_mode_flag           <= 1'b0;
                     fms_flag                <= 2'd2;
                end
            default:
                begin
                end
            endcase
            end
            case(T3_mode_Time)
        2'd0:
            begin
                cnt_T3_time_r           <= 33'd399999999;//1s
            end
        2'd1:
            begin
                   cnt_T3_time_r           <= 33'd3999999999;//10s
            end
        2'd2:
            begin
                  cnt_T3_time_r           <= 33'd7999999999;//20s
            end
        default:
            begin
            end
        endcase
        
        end


ADCMP553_REF_DA ADCMP553_REF_DA_inst(
.Sys_Clk(Clk_in_50m),
.Reset(Reset),
.fpga_din1(fpga_din1), 
.fpga_sclk1(fpga_sclk1), 
.fpga_cs1(fpga_cs1), 
.fpga_din2(fpga_din2), 
.fpga_sclk2(fpga_sclk2), 
.fpga_cs2(fpga_cs2),
.DA_Ref1(DA_Ref1_usb),
.DA_Ref2(DA_Ref3_usb),
.fpga_din3(fpga_din3), 
.fpga_sclk3(fpga_sclk3), 
.fpga_cs3(fpga_cs3), 
.DA_Ref3(DA_Ref4_usb)
);

                

 


    
Gen_Delay_U0 Gen_Delay_U0_inst(
 .Reset(Reset),
.Sys_Clk1(Sys_Clk_400m),
.pinc1(laser_freq_pinc),
.pluse_width1(laser_freq_pluse),
.delay_cnt1(S_delay1),
.delay_cnt2(S_delay2),
.Trig_in1(FPGA_START_OUT_bug),
.Trig_out1(FPGA_STOP_OUT_1_bug),
.Trig_out2(FPGA_STOP_OUT_2_bug)
);    
    

(*Mark_debug="TRUE"*)wire[31:0]               USB_DATA;
(*Mark_debug="TRUE"*)wire                     USB_DATA_VALID;

(*Mark_debug="TRUE"*)wire[15:0]                    TCSPC_Data_A;
(*Mark_debug="TRUE"*)wire                          TCSPC_Data_Valid_A;
(*Mark_debug="TRUE"*)wire[15:0]                    TCSPC_Data_B;
(*Mark_debug="TRUE"*)wire                          TCSPC_Data_Valid_B;
        
(*Mark_debug="TRUE"*)wire[30:0]                                          T3_DATA_A;
(*Mark_debug="TRUE"*)wire                                                T3_DATA_A_Valid;
(*Mark_debug="TRUE"*)wire[30:0]                                          T3_DATA_B;
(*Mark_debug="TRUE"*)wire                                                T3_DATA_B_Valid;   

(*Mark_debug="TRUE"*)wire[31:0]                                          Timestamp_DATA;
(*Mark_debug="TRUE"*)wire                                                Timestamp_DATA_Valid; 
(*Mark_debug="TRUE"*)wire[15:0]                                          Conforms_Counting_time;
wire                                    Conforms_Counting_flag;
wire                                    SPC_flag;
 (*Mark_debug="TRUE"*)wire[31:0]                              spc_acc_pluse;
 (*Mark_debug="TRUE"*)wire                                    spc_acc_pluse_valid;

 (*Mark_debug="TRUE"*)wire                   Conforms_Counting_mode_1;
 wire                   Conforms_Counting_mode_2;  
       
(*Mark_debug="TRUE"*)  wire[31:0]             Timestamp_usb_data;
(*Mark_debug="TRUE"*) wire                   Timestamp_usb_data_valid;

wire[15:0]                      Conforms_Counting_Sync_Time;
wire[15:0]                      Conforms_Counting_PW;

wire[31:0]                                          Conforms_Counting_data;
wire                                                Conforms_Counting_data_Valid;  
     
                 
TDC_Module TDC_Module_inst(
.Reset(Reset),
.Start1(Start_in1),
.Stop1(Stop_in1),
.Stop2(Stop_in2),
.Spd_Delay_flag1(Spd_Delay_flag1),
.Spd_Delay_flag2(Spd_Delay_flag2),
.Stop_out1(Stop_out1),
.Stop_out2(Stop_out2),

.Sys_Clk(Clk_100M),
.Sys_Clk_out(Sys_Clk_400m),
.TDC_Bin(TDC_Bin),
.TDC_test_time(TDC_single_Time),
.TDC_acc_time(TDC_ACC_Time),

.T3_DATA_A(T3_DATA_A),
.T3_DATA_A_Valid(T3_DATA_A_Valid),
.T3_DATA_B(T3_DATA_B),
.T3_DATA_B_Valid(T3_DATA_B_Valid),



.Timestamp_DATA(Timestamp_DATA),
.Timestamp_DATA_Valid(Timestamp_DATA_Valid),


.TCSPC_Data_A(TCSPC_Data_A),
.TCSPC_Data_Valid_A(TCSPC_Data_Valid_A),
.TCSPC_Data_B(TCSPC_Data_B),
.TCSPC_Data_Valid_B(TCSPC_Data_Valid_B),
.TDC_tscpc_mode(TDC_ACC_Flag),//模式,1是累积时间，0是峰值模式
//.TDC_tscpc_mode(1'b1),//模式,1是累积时间，0是峰值模式
.TDC_tcspc_acc_num(TDC_Peak_Value),
//.TDC_test_flag(1'b1)
.Conforms_Counting_mode_1(Conforms_Counting_mode_1),
.Conforms_Counting_mode_2(Conforms_Counting_mode_2),
.TDC_test_flag(Start_stop_flag),
.SPC_flag(SPC_flag),
.spc_acc_pluse(spc_acc_pluse),
.spc_acc_pluse_valid(spc_acc_pluse_valid),
.Conforms_Counting_Sync_Time(Conforms_Counting_Sync_Time),
.Conforms_Counting_PW(Conforms_Counting_PW),
.Conforms_Counting_flag(Conforms_Counting_flag),
.Conforms_Counting_data(Conforms_Counting_data),
.Conforms_Counting_data_Valid(Conforms_Counting_data_Valid)

 );


 TDC_Data_Cache TDC_Data_Cache_inst(
.Sys_Clk(Sys_Clk_400m),
.Reset(Reset),
.Start_stop_flag(Start_stop_flag),
.T3_mode(T3_mode),
//.trig_mode(1'b0),
//.Start_stop_flag(1'b1),
//.T3_mode(1'b0),
.TCSPC_Data_A(TCSPC_Data_A),
.TCSPC_Data_Valid_A(TCSPC_Data_Valid_A),
.TCSPC_Data_B(TCSPC_Data_B),
.TCSPC_Data_Valid_B(TCSPC_Data_Valid_B),
.T3_DATA_A(T3_DATA_A),
.T3_DATA_A_Valid(T3_DATA_A_Valid),
.T3_DATA_B(T3_DATA_B),
.T3_DATA_B_Valid(T3_DATA_B_Valid),
.Timestamp_DATA(Timestamp_DATA),
.Timestamp_DATA_Valid(Timestamp_DATA_Valid),
.Timestamp_mode(Timestamp_mode),
.Conforms_Counting_mode_1(Conforms_Counting_mode_1),
.Conforms_Counting_mode_2(Conforms_Counting_mode_2),
.Conforms_Counting_data(Conforms_Counting_data),
.Conforms_Counting_data_Valid(Conforms_Counting_data_Valid),
.usb_data(USB_DATA),
.usb_data_valid(USB_DATA_VALID),
.Timestamp_usb_data(Timestamp_usb_data),
.Timestamp_usb_data_valid(Timestamp_usb_data_valid)
    );


(*Mark_debug="TRUE"*)reg[31:0]                           USB_DATA_r;
 (*Mark_debug="TRUE"*)reg                                 USB_DATA_VALID_r;
reg[3:0]                            send_reg;
reg                                 T3_mode_flag_r; 
reg                                 others_data_flag; 


reg                                           SPC_flag_r;
reg                                           SPC_flag_r1;

reg[15:0]                                   cnt_Conforms_Counting_time;
(*Mark_debug="TRUE"*)reg                                         Conforms_Counting_mode_2_flag;
//符合计数模式2保存时间
//10ms计数
reg[31:0]                                   cnt_10ms;
reg                                         pluse_10ms;
(*Mark_debug="TRUE"*)reg[1:0]                                    fms_Conforms_Counting;
reg                                         Conforms_Counting_mode_2_r;
(*Mark_debug="TRUE"*)reg                                         Conforms_Counting_mode_2_r1;  
reg[15:0]                                   Conforms_Counting_time_r;
reg[15:0]                                   Conforms_Counting_time_r1; 
reg                                         Timestamp_mode_r;
(*Mark_debug="TRUE"*)reg                                         Timestamp_mode_r1;
(*Mark_debug="TRUE"*)reg                                         Timestamp_mode_flag;
always@(posedge Sys_Clk_400m or negedge Reset)
    if(Reset == 1'b1)
        begin
            fms_Conforms_Counting           <= 2'd0;
            cnt_Conforms_Counting_time      <= 16'd0;
            Conforms_Counting_mode_2_flag   <= 1'b0; 
            cnt_10ms                        <= cnt_10ms;
            pluse_10ms                      <= 1'b0;
            Conforms_Counting_mode_2_r      <= 1'b0;
            Conforms_Counting_mode_2_r1     <= 1'b0;
            Conforms_Counting_time_r        <= 16'd0;
            Conforms_Counting_time_r1       <= 16'd0;
            Timestamp_mode_r                <= 1'b0;
            Timestamp_mode_r1               <= 1'b0;
            Timestamp_mode_flag             <= 1'b0;
        end
     else
        begin
            Conforms_Counting_time_r        <= Conforms_Counting_time;
            Conforms_Counting_time_r1       <= Conforms_Counting_time_r;
            Conforms_Counting_mode_2_r      <= Conforms_Counting_mode_2;
            Conforms_Counting_mode_2_r1     <= Conforms_Counting_mode_2_r;
            Timestamp_mode_r                <= Timestamp_mode;
            Timestamp_mode_r1               <= Timestamp_mode_r;
            if(Start_stop_flag_r1 == 1'b0)
                begin
                     cnt_10ms                   <= 32'd0;
                     pluse_10ms                 <= 1'b0;
                     fms_Conforms_Counting      <= 2'd0;
                end
            else
                begin
                    if(cnt_10ms == 32'd3999999)//10ms
                        begin
                            pluse_10ms          <= 1'b1;
                            cnt_10ms            <= 32'd0;                            
                        end
                    else
                        begin
                            pluse_10ms          <= 1'b0;
                            cnt_10ms            <= cnt_10ms + 32'd1;                         
                        end   
                end
             case(fms_Conforms_Counting) 
          2'd0:
            begin
                Conforms_Counting_mode_2_flag   <= 1'b0;
                Timestamp_mode_flag             <= 1'b0;
                 if((Start_stop_flag_r1 == 1'b1) && (Start_stop_flag_r2 == 1'b0) && ((Conforms_Counting_mode_2_r1 == 1'b1)||(Timestamp_mode_r1 == 1'b1)))
                    fms_Conforms_Counting       <= 2'd1;
                 else
                    fms_Conforms_Counting       <= 2'd0;              
            end
          2'd1:
            begin
                if(Conforms_Counting_mode_2_r1 == 1'b1)
                    Conforms_Counting_mode_2_flag   <= 1'b1;
                else
                   Timestamp_mode_flag              <= 1'b1; 
                if(pluse_10ms == 1'b1)
                    begin
                         if(cnt_Conforms_Counting_time == Conforms_Counting_time_r1)
                              begin
                                  cnt_Conforms_Counting_time             <= 16'd0;
                                  fms_Conforms_Counting                  <= 2'd2;
                              end
                        else
                            begin
                                cnt_Conforms_Counting_time              <= cnt_Conforms_Counting_time + 16'd1;
                                fms_Conforms_Counting                   <= 2'd1;
                            end
                     end
                 else
                    fms_Conforms_Counting                               <= 2'd1;
                    
            end
          2'd2:
            begin
                 Conforms_Counting_mode_2_flag                          <= 1'b0;
                 Timestamp_mode_flag                                    <= 1'b0;
                 fms_Conforms_Counting                                  <= 2'd0;
            end
         default:
            begin
            end
         endcase     
        end

always@(posedge Sys_Clk_400m or negedge Reset)
    if(Reset == 1'b1)
        begin

            USB_DATA_VALID_r      <= 1'b0;
            USB_DATA_r            <= 32'd0;   
            send_reg              <= 4'd0;       
            T3_mode_flag_r        <= 1'b0; 
            others_data_flag      <= 1'b0; 
            SPC_flag_r            <= 1'b0;
            SPC_flag_r1           <= 1'b0;
            
        end
    else
        begin
            SPC_flag_r              <= SPC_flag;
            SPC_flag_r1             <= SPC_flag_r;
            T3_mode_flag_r          <= T3_mode && T3_mode_flag;
            others_data_flag        <= TDC_Peak_Flag || TDC_ACC_Flag ||  Conforms_Counting_mode_1 || Conforms_Counting_mode_2_flag;
            send_reg                <= {others_data_flag,Timestamp_mode_flag,T3_mode_flag_r,SPC_flag_r1};
            
                case(send_reg)
          4'd1:
                begin
                     USB_DATA_r                    <= spc_acc_pluse;
                    USB_DATA_VALID_r              <= spc_acc_pluse_valid;                   
                end
           4'd2:
                begin
                      USB_DATA_VALID_r      <= USB_DATA_VALID;
                      USB_DATA_r            <= USB_DATA;    
                end
           4'd4:
                begin
                    USB_DATA_VALID_r      <= Timestamp_usb_data_valid;
                    USB_DATA_r            <= Timestamp_usb_data;    
                end
          4'd8:
                begin
                   USB_DATA_VALID_r      <= USB_DATA_VALID;
                   USB_DATA_r            <= USB_DATA; 
                end
           default:
                begin
                end
           endcase   
     end      


USB3_0_Module USB3_0_Module_inst( 
.Clk_100M(Clk_100M),
.Clk_in_50m(Clk_in_50m),
.Reset(Reset), 
.I2C_SCL(I2C_SCL) ,
.I2C_SDA(I2C_SDA),
.fdata(fdata),
.faddr(faddr),
.slrd(slrd),
.slwr(slwr), 
.flaga(flaga) ,
.flagb(flagb),
.flagc(flagc),
.flagd(flagd),
.sloe(sloe),
.slcs(slcs),
.pktend(pktend),
.Sys_Clk_ADC(Sys_Clk_400m),
//.Sys_Clk_ADC(Clk_100M),
.ADC_Data(USB_DATA_r) ,
.ADC_Data_Valid(USB_DATA_VALID_r),
.DA_Ref1_usb(DA_Ref1_usb),
.DA_Ref2_usb(DA_Ref2_usb),
.DA_Ref3_usb(DA_Ref3_usb),
.DA_Ref4_usb(DA_Ref4_usb),
.laser_freq_pinc(laser_freq_pinc),
.laser_freq_pluse(laser_freq_pluse),
.trig_mode(trig_mode),
.SPC_flag(SPC_flag),
.TDC_Peak_Flag(TDC_Peak_Flag),
.TDC_ACC_Flag(TDC_ACC_Flag),
.T3_mode(T3_mode),
.Timestamp_mode(Timestamp_mode),
.Conforms_Counting_mode_1(Conforms_Counting_mode_1),
.Conforms_Counting_mode_2(Conforms_Counting_mode_2),
.T3_mode_Time(T3_mode_Time),
.S_delay1(S_delay1),
.S_delay2(S_delay2),
.TDC_ACC_Time(TDC_ACC_Time),
.TDC_single_Time(TDC_single_Time),
.TDC_bin(TDC_Bin),
.TDC_Peak_Value(TDC_Peak_Value),
.Start_stop_flag(Start_stop_flag),
.Conforms_Counting_time(Conforms_Counting_time),
.Conforms_Counting_Sync_Time(Conforms_Counting_Sync_Time),
.Conforms_Counting_PW(Conforms_Counting_PW),
.Conforms_Counting_flag(Conforms_Counting_flag),
.Spd_Delay_cnt1(Spd_Delay_cnt1),
.Spd_Delay_cnt2(Spd_Delay_cnt2),
.Spd_Delay_flag1(Spd_Delay_flag1),
.Spd_Delay_flag2(Spd_Delay_flag2)
);

endmodule
