`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/11 12:42:57
// Design Name: 
// Module Name: TDC_Data_Cache
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


module TDC_Data_Cache(
Sys_Clk,Reset,Start_stop_flag,T3_mode,
TCSPC_Data_A,TCSPC_Data_Valid_A,TCSPC_Data_B,TCSPC_Data_Valid_B,T3_DATA_A,T3_DATA_A_Valid,
T3_DATA_B,T3_DATA_B_Valid,
Timestamp_mode,Timestamp_DATA,Timestamp_DATA_Valid,
usb_data,usb_data_valid,Timestamp_usb_data,Timestamp_usb_data_valid,Conforms_Counting_mode_1,Conforms_Counting_mode_2
,Conforms_Counting_data_Valid,Conforms_Counting_data
 );

input                           Sys_Clk;
input                           Reset; 
input                           Start_stop_flag;
input                           T3_mode;  

 
input[15:0]                    TCSPC_Data_A;
input                          TCSPC_Data_Valid_A;
input[15:0]                    TCSPC_Data_B;
input                          TCSPC_Data_Valid_B; 
input[30:0]                    T3_DATA_A;
input                          T3_DATA_A_Valid;
input[30:0]                    T3_DATA_B;
input                           T3_DATA_B_Valid;


input[31:0]                    Timestamp_DATA;
input                          Timestamp_DATA_Valid;
input                          Timestamp_mode;
input                           Conforms_Counting_mode_1;
input                           Conforms_Counting_mode_2;
output[31:0]                   usb_data;
output                         usb_data_valid; 

output[31:0]                   Timestamp_usb_data;
output                         Timestamp_usb_data_valid; 
input[31:0]                     Conforms_Counting_data;
input                           Conforms_Counting_data_Valid;

(*Mark_debug="TRUE"*)reg[31:0]                   Timestamp_usb_data;
(*Mark_debug="TRUE"*)reg                         Timestamp_usb_data_valid; 

(*Mark_debug="TRUE"*)reg[31:0]                   Timestamp_usb_data_r;
reg                         Timestamp_usb_data_valid_r; 
(*Mark_debug="TRUE"*)reg[31:0]                      usb_data;
(*Mark_debug="TRUE"*)reg                            usb_data_valid; 

reg[31:0]                                           usb_data_tscpc;
reg                                                 usb_data_tscpc_valid; 

reg[31:0]                                           usb_data_tscpc1;
reg                                                 usb_data_tscpc_valid1; 

wire[12:0]                      fifo_count1;
wire                            fifo_valid1;
wire                            fifo_empty1;
wire                            fifo_full1;
wire[31:0]                      fifo_dout1;
reg                             fifo_rd1;
reg                             fifo_wr1;
reg[31:0]                       fifo_din1;
reg                             fifo_rst1;

wire[12:0]                      fifo_count2;
wire                            fifo_valid2;
wire                            fifo_empty2;
wire                            fifo_full2;
wire[31:0]                      fifo_dout2;
reg                             fifo_rd2;
reg                             fifo_wr2;
reg[31:0]                       fifo_din2;
reg                             fifo_rst2;

reg[31:0]                      fifo_dout2_r;
reg[31:0]                      fifo_dout1_r;
reg                            fifo_valid2_r;
reg                            fifo_valid1_r;


reg[31:0]                      Timestamp_fifo_dout2_r;
reg[31:0]                      Timestamp_fifo_dout1_r;
reg                            Timestamp_fifo_valid2_r;
reg                            Timestamp_fifo_valid1_r;





reg[31:0]                      Timestamp_fifo_dout2_r1;
reg[31:0]                      Timestamp_fifo_dout1_r1;
reg                            Timestamp_fifo_valid2_r1;
reg                            Timestamp_fifo_valid1_r1;


reg[31:0]                      Conforms_Counting_fifo_dout1_r;
reg                            Conforms_Counting_fifo_valid1_r;
reg[31:0]                      Conforms_Counting_fifo_dout1_r1;
reg                            Conforms_Counting_fifo_valid1_r1;
reg                             Conforms_Counting_mode_1_r;
reg                             Conforms_Counting_mode_1_r1;
reg                             Conforms_Counting_mode_2_r;
reg                             Conforms_Counting_mode_2_r1;

reg[3:0]                        fms_fifo;
reg[2:0]                        cnt_3;
reg                             T3_mode_r;
reg                             T3_mode_r1;
reg                             Start_stop_flag_r;
reg                             Start_stop_flag_r1;
reg                             Start_stop_flag_r2;
reg[11:0]                       cnt_12_1;
reg[11:0]                       cnt_12_2;
reg[1:0]                        cnt_4;


 (*Mark_debug="TRUE"*)reg                             fifo_wr1_r;
 (*Mark_debug="TRUE"*)reg[31:0]                       fifo_din1_r;
reg                             fifo_wr2_r;
reg[31:0]                       fifo_din2_r;
reg                             Timestamp_mode_r;
reg                             Timestamp_mode_r1;
reg[1:0]                        fms_Timestamp;
reg[9:0]                       cnt_1022;
reg[11:0]                       cnt_4096;
reg[4:0]                        cnt_7_1;
reg[4:0]                        cnt_7_2;
reg[1:0]                        fms_tscpc;
always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1)
        begin
            fms_fifo            <= 4'd0;
            fifo_rst1           <= 1'b1;
            fifo_rd1            <= 1'b0;
            fifo_wr1            <= 1'b0;
            fifo_din1           <= 32'd0;
            fifo_rst2           <= 1'b1;
            fifo_rd2            <= 1'b0;
            fifo_wr2            <= 1'b0;
            fifo_din2           <= 32'd0;           
            cnt_3               <= 3'd0;
            T3_mode_r           <= 1'b0;
            T3_mode_r1          <= 1'b0;
            Start_stop_flag_r   <= 1'b0;
            Start_stop_flag_r1  <= 1'b0;
            cnt_12_1            <= 12'd0;
            cnt_12_2            <= 12'd0;
            usb_data_valid      <= 1'b0;
            usb_data            <= 32'd0;
            cnt_4               <= 2'd0;

            
            fifo_dout2_r        <= 32'd0;
            fifo_dout1_r        <= 32'd0;
            fifo_valid2_r       <= 1'b0;
            fifo_valid1_r       <= 1'b0;           
            
            fifo_wr1_r          <= 1'b0;
            fifo_din1_r         <= 32'd0;
            fifo_wr2_r          <= 1'b0;
            fifo_din2_r         <= 32'd0;   
            
            Timestamp_mode_r    <= 1'b0;
            Timestamp_mode_r1   <= 1'b0;  
            
            
            Timestamp_usb_data          <= 32'd0;
            Timestamp_usb_data_valid    <= 1'b0;  
            Timestamp_usb_data_r          <= 32'd0;
            Timestamp_usb_data_valid_r    <= 1'b0;              
                     
            Timestamp_fifo_dout2_r      <= 32'd0;
            Timestamp_fifo_dout1_r      <= 32'd0;
            Timestamp_fifo_valid2_r     <= 1'b0;
            Timestamp_fifo_valid1_r     <= 1'b0;
  
            Timestamp_fifo_dout2_r1      <= 32'd0;
            Timestamp_fifo_dout1_r1      <= 32'd0;
            Timestamp_fifo_valid2_r1     <= 1'b0;
            Timestamp_fifo_valid1_r1     <= 1'b0; 
            
            Conforms_Counting_mode_1_r   <= 1'b0;
            Conforms_Counting_mode_1_r1  <= 1'b0;
            Conforms_Counting_mode_2_r   <= 1'b0;
            Conforms_Counting_mode_2_r1  <= 1'b0;          
            
            fms_Timestamp                <= 2'd0; 
            cnt_1022                     <= 10'd0;    
            
            
            Conforms_Counting_fifo_dout1_r<= 32'd0;
            Conforms_Counting_fifo_valid1_r<= 1'b0;       
            Conforms_Counting_fifo_dout1_r1<= 32'd0;
            Conforms_Counting_fifo_valid1_r1<= 1'b0;              
            cnt_4096                       <= 12'd0;    
            cnt_7_1                         <= 5'd0;
            cnt_7_2                        <= 5'd0;  
            
            usb_data_tscpc                  <= 32'd0;
            usb_data_tscpc_valid            <= 1'b0;     
            usb_data_tscpc1                  <= 32'd0;
            usb_data_tscpc_valid1            <= 1'b0;  
            fms_tscpc                       <= 2'b0;                
        end
        
    else
        begin
            Timestamp_mode_r    <= Timestamp_mode;
            Timestamp_mode_r1   <= Timestamp_mode_r;
            
            Conforms_Counting_mode_1_r   <= Conforms_Counting_mode_1;
            Conforms_Counting_mode_1_r1  <= Conforms_Counting_mode_1_r;
            Conforms_Counting_mode_2_r   <= Conforms_Counting_mode_2;
            Conforms_Counting_mode_2_r1  <= Conforms_Counting_mode_2_r;                 
            
            
            fifo_dout2_r        <= fifo_dout2;
            fifo_dout1_r        <= fifo_dout1;
            fifo_valid2_r       <= fifo_valid2;
            fifo_valid1_r       <= fifo_valid1;            
//符合计数模式      
            Conforms_Counting_fifo_dout1_r<= fifo_dout1;
            Conforms_Counting_fifo_valid1_r<= fifo_valid1;      
            
//32'hEB90B712;  
            usb_data_tscpc1                  <= usb_data_tscpc;
            usb_data_tscpc_valid1            <= usb_data_tscpc_valid;  
                    
                    usb_data_tscpc_valid      <= fifo_valid1_r || fifo_valid2_r;            
                     if(fifo_valid1_r == 1'b1)
                        usb_data_tscpc          <= fifo_dout1_r;
                    else if(fifo_valid2_r == 1'b1)
                        usb_data_tscpc          <= fifo_dout2_r;
                    else
                        usb_data_tscpc          <= 32'd0;  
          
                           
             if(Start_stop_flag_r2== 1'b0)
                begin
                fms_tscpc                       <= 2'd0;
                cnt_4096                        <= 12'd0;
                end
             else
                begin
                    if(usb_data_tscpc_valid == 1'b1)
                        begin
                            if(cnt_4096 == 12'd4095)
                                cnt_4096        <= 12'd0;
                            else
                                cnt_4096        <= cnt_4096 + 12'd1;
                        end                 
                    case(fms_tscpc)
                  2'd0:
                    begin
                        if(usb_data_tscpc_valid== 1'b1)
                            begin
                                fms_tscpc           <= 2'd1;
                               usb_data_tscpc_valid1       <= 1'b1;
                               usb_data_tscpc1      <= 32'hEB90B714; 
                            end
                        else
                            begin
                                fms_tscpc                   <= 2'd0;
                                usb_data_tscpc_valid1       <= 1'b0;
                            end
                    end
                  2'd1:
                    begin
                     if(cnt_4096 == 12'd4095)
                        fms_tscpc                           <= 2'd0;
                     else
                        fms_tscpc                           <= 2'd1;
                      usb_data_tscpc_valid1       <= 1'b1;
                      usb_data_tscpc1             <= usb_data_tscpc;
                    end
                  2'd2:
                    begin
                    end
                  default:
                    begin
                    end
                  endcase
                    
                end
             

                
      
            if((Conforms_Counting_mode_1_r1 == 1'b1)||(Conforms_Counting_mode_2_r1 == 1'b1))
                begin
                    usb_data_valid          <=   Conforms_Counting_fifo_valid1_r;
                    usb_data                <=   Conforms_Counting_fifo_dout1_r;
                end
            else
                begin   
                    usb_data_valid          <=   usb_data_tscpc_valid1;
                    usb_data                <=   usb_data_tscpc1;
                
 
              end 

//时间戳模式





            Timestamp_fifo_dout1_r      <= fifo_dout1;
            Timestamp_fifo_valid1_r     <= fifo_valid1;  

            Timestamp_fifo_dout1_r1      <= Timestamp_fifo_dout1_r;
            Timestamp_fifo_valid1_r1     <= Timestamp_fifo_valid1_r;   
            
            Timestamp_usb_data          <= Timestamp_usb_data_r;//帧头
            Timestamp_usb_data_valid    <= Timestamp_usb_data_valid_r; 
//组帧头，组帧尾

                         Timestamp_usb_data_valid_r      <= Timestamp_fifo_valid1_r1;          
                         if(Timestamp_fifo_valid1_r1 == 1'b1)
                            Timestamp_usb_data_r          <= Timestamp_fifo_dout1_r1;
                        else
                             Timestamp_usb_data_r          <= 32'd0;   
                      

            T3_mode_r           <= T3_mode;
            T3_mode_r1          <= T3_mode_r;
            Start_stop_flag_r   <= Start_stop_flag;
            Start_stop_flag_r1  <= Start_stop_flag_r;
            Start_stop_flag_r2  <= Start_stop_flag_r1;

            
            
            fifo_wr1          <= fifo_wr1_r;
            fifo_din1         <= fifo_din1_r;
            fifo_wr2          <= fifo_wr2_r;
            fifo_din2         <= fifo_din2_r;    
            
            if(Timestamp_mode_r1 == 1'b1)
                begin
                    fifo_din1_r           <= Timestamp_DATA;
                    fifo_wr1_r            <= Timestamp_DATA_Valid;
                    fifo_din2_r           <= 32'd0;
                    fifo_wr2_r            <= 1'b0;                           
                end
            else
                begin
                    if(T3_mode_r == 1'b1)//T3模式
                        begin     
                            fifo_din1_r           <= {1'b0,T3_DATA_A};
                            fifo_wr1_r            <= T3_DATA_A_Valid;
                            fifo_din2_r           <= {1'b1,T3_DATA_B};
                            fifo_wr2_r            <= T3_DATA_B_Valid;                                    
                        end
                    else
                        begin
                            if(Conforms_Counting_mode_2_r1 == 1'b1)
                                begin
                                    fifo_din1_r           <= Conforms_Counting_data;
                                    fifo_wr1_r            <= Conforms_Counting_data_Valid;
                                    fifo_din2_r           <= 32'd0;
                                    fifo_wr2_r            <= 1'b0;                                      
                                end
                            else if(Conforms_Counting_mode_1_r1 == 1'b1)
                                begin
                                    fifo_din1_r           <= {1'b0,15'd0,TCSPC_Data_A};
                                    fifo_wr1_r            <= TCSPC_Data_Valid_A;
                                    fifo_din2_r           <= 32'd0;
                                    fifo_wr2_r            <= 1'b0;                                  
                                end
                            else
                                begin
                                    fifo_din1_r           <= {1'b0,15'd0,TCSPC_Data_A};
                                    fifo_wr1_r            <= TCSPC_Data_Valid_A;
                                    fifo_din2_r           <= {1'b1,15'd0,TCSPC_Data_B};
                                    fifo_wr2_r            <= TCSPC_Data_Valid_B;        
                            end                                    
                        end
                end
 //每次模式切换的时候，需要清零
               if(Start_stop_flag_r2== 1'b0)
                begin
                      fms_fifo            <= 4'd0;
                      fifo_rst1           <= 1'b1;
                      fifo_rst2           <= 1'b1;
                end
            else
                begin
  //每次输出4096个数据，奇数帧发送tdc1,偶数帧发送tdc2,为了保护期间，等待一定时间，如果没有数据，直接发送0
  //如果有1个大于3/2，一个人小于1/2，则开始发送0
                        case(fms_fifo)
                   4'd0:
                        begin
                            if(Start_stop_flag_r2 == 1'b1)
                                 fms_fifo                <= 4'd1;
                            else
                                 fms_fifo                <= 4'd0;                      
                        end
                   4'd1:
                        begin
                            if(cnt_3 == 3'd7)
                                begin
                                    cnt_3               <= 3'd0;
                                    fms_fifo            <= 4'd2;
                                    fifo_rst1           <= 1'b0;
                                    fifo_rst2           <= 1'b0;
                                end
                            else
                                begin
                                    cnt_3               <=  cnt_3 + 3'd1;
                                    fms_fifo            <= 4'd1;
                                end
                        end            
                   4'd2:
                    begin
                        if(fifo_count1 > 13'd4095)
                               fms_fifo            <= 4'd3; 
                        else
                            begin
                                if(fifo_count2 > 13'd2500)
                                      fms_fifo            <= 4'd6;
                                else
                                     fms_fifo            <= 4'd2;
                            end      
                    end
                   4'd3:
                        begin
//fifo1中的数据大于4095，可以发送数据了      
                            if(cnt_12_1 == 12'd4095)
                                begin
                                    cnt_12_1                <= 12'd0;
                                    fms_fifo                <= 4'd4;
                                end
                            else
                                begin
                                    cnt_12_1                <= cnt_12_1 + 12'd1;
                                    fms_fifo                <= 4'd3;
                                end
                                    fifo_rd1            <= 1'b1;     
                        end     
                    4'd4:
                        begin
                             fifo_rd1            <= 1'b0; 
//fifo1发完后，等待一定周期  
                            if(cnt_7_1 == 5'd31)
                                begin
                                  fms_fifo       <= 4'd5;  
                                  cnt_7_1       <= 5'd0;
                                end
                            else
                                begin
                                  fms_fifo       <= 4'd4;  
                                  cnt_7_1        <= cnt_7_1 + 5'd1;
                                end
          
                                 
                                    
                        end 
                    4'd5:
                        begin
                              if(fifo_count2 > 13'd2500)
                                  fms_fifo     <= 4'd6;
                              else
                                   fms_fifo    <= 4'd2;
                        end                    
                    4'd6:
                        begin
                            if(cnt_12_2 == 12'd4095)
                                begin
                                    cnt_12_2                <= 12'd0;
                                    fms_fifo                <= 4'd7;
                                end
                            else
                                begin
                                    cnt_12_2                <= cnt_12_2 + 12'd1;
                                    fms_fifo                <= 4'd6;
                                end
                            fifo_rd2            <= 1'b1;                      
                        end               
                  4'd7:
                        begin
                            fifo_rd2                         <= 1'b0; 
                    
                                    if(cnt_7_1 == 5'd31)
                                begin
                                   cnt_7_1                  <= 5'd0;
                                   fms_fifo                    <= 4'd2;  
                                end
                            else
                                begin
                                  fms_fifo       <= 4'd7;  
                                  cnt_7_1        <= cnt_7_1 + 5'd1;
                                end             
                            
                                                                                            
                        end  
  

                   default:
                    begin
                    end
                   endcase
                end
        end 
        
        
 fifo_generator_0 fifo_generator_0_inst1(
.clk(Sys_Clk),
.srst(fifo_rst1),
.din(fifo_din1),
.wr_en(fifo_wr1),
.rd_en(fifo_rd1),
.dout(fifo_dout1),
.full(fifo_full1),
.empty(fifo_empty1),
.valid(fifo_valid1),
.data_count(fifo_count1)
  );    
  
 fifo_generator_0 fifo_generator_0_inst2(
.clk(Sys_Clk),
.srst(fifo_rst2),
.din(fifo_din2),
.wr_en(fifo_wr2),
.rd_en(fifo_rd2),
.dout(fifo_dout2),
.full(fifo_full2),
.empty(fifo_empty2),
.valid(fifo_valid2),
.data_count(fifo_count2)
  );  
  
     
endmodule
