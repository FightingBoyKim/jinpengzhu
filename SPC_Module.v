`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/03 20:05:51
// Design Name: 
// Module Name: SPC_Module
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

  
module SPC_Module(clk_sys_400m,Reset,Stop,Start,SPC_flag,Start_stop_flag,spc_acc_pluse,spc_acc_pluse_valid);
input                                   clk_sys_400m;
input                                   Reset;
input                                   Stop;
input                                   Start;
input                                   SPC_flag;
input                                   Start_stop_flag;
output[31:0]                            spc_acc_pluse;
output                                  spc_acc_pluse_valid;  
//连续模式最短0.05s最长100000s
reg[8:0]                                cnt_1us;
reg[9:0]                                cnt_1ms;
reg[9:0]                                cnt_1s;
reg                                     SPC_test_flag_r;
reg                                     SPC_test_flag_r1;
reg[1:0]                                fms_test;
reg                                     Stop_r;
reg                                     Stop_r1;
reg                                     Start_r;
reg                                     Start_r1;
reg[31:0]                               spc_acc_pluse;
reg[30:0]                               spc_acc_pluse_r;
reg[30:0]                               spc_acc_pluse_start_r;
reg                                     spc_acc_pluse_valid;  
reg[31:0]                               cnt_spc_acc_time;
reg[9:0]                                                      cnt_10;
reg[31:0]                               spc_acc_time_r;
reg[31:0]                               spc_acc_time_r1;
//使用UART发送是，一次只发送一次，
//使用USB3.0,一次发送1024个相同的数据
reg                 SPC_flag_r;
always@(posedge clk_sys_400m or negedge Reset)
    if(Reset == 1'b1)
        begin
           cnt_1us                     <= 9'd0; 
           SPC_test_flag_r             <= 1'b0;
           SPC_test_flag_r1            <= 1'b0;
           fms_test                    <= 2'd0;
           spc_acc_pluse_valid         <= 1'b0;
           spc_acc_pluse               <= 32'd0;
           spc_acc_pluse_r             <= 31'd0;
           spc_acc_pluse_start_r       <= 31'd0;
                      
           Stop_r                      <= 1'b0;
           Stop_r1                     <= 1'b0;
           Start_r                     <= 1'b0;
           Start_r1                    <= 1'b0;
           cnt_1ms                     <= 10'd0;
           cnt_1s                       <= 10'd0;     
           cnt_spc_acc_time            <= 32'd0;   
           cnt_10                      <= 10'd0; 
           spc_acc_time_r1             <= 32'd0;
           spc_acc_time_r              <= 32'd0;
        end
     else
        begin
            SPC_test_flag_r             <= Start_stop_flag;
            SPC_test_flag_r1            <= SPC_test_flag_r;
            Stop_r                      <= Stop;
            Stop_r1                     <= Stop_r;
            Start_r                     <= Start;
            Start_r1                    <= Start_r;
            
            
            SPC_flag_r                  <= SPC_flag;           
      //    if(((SPC_test_flag_r == 1'b0) &&(SPC_test_flag_r1 == 1'b1))||(SPC_flag == 1'b0))//下降沿结束
      if(((SPC_test_flag_r == 1'b0) &&(SPC_test_flag_r1 == 1'b1))||((SPC_flag== 1'b1)&&(SPC_flag_r == 1'b0))||((SPC_flag== 1'b0)&&(SPC_flag_r == 1'b1)))//下降沿结束
                begin
                    fms_test            <= 2'd0;
                    spc_acc_pluse_r     <= 31'd0;
                    spc_acc_pluse_start_r<= 31'd0;
                end
          else
                begin
                    case(fms_test)
                    2'd0:
                        begin
                            spc_acc_pluse_valid             <= 1'b0;
                            if((SPC_test_flag_r == 1'b1) &&(SPC_test_flag_r1 == 1'b0) )
                                fms_test                    <= 2'd1;
                            else
                                fms_test                    <= 2'd0;                           
                        end
                    2'd1:
                        begin
                            spc_acc_pluse_valid             <= 1'b0;
                             if((Stop_r == 1'b1) && (Stop_r1 == 1'b0))//统计脉冲个数
                                 spc_acc_pluse_r            <= spc_acc_pluse_r + 31'd1;

                             if((Start_r == 1'b1) && (Start_r1 == 1'b0))//统计脉冲个数
                                 spc_acc_pluse_start_r      <= spc_acc_pluse_start_r + 31'd1;



       //开始计数，最小时间为0.05s  
                           if(cnt_1us == 9'd399)
                   
                                begin
                                    cnt_1us                 <= 9'd0;        
                                     if(cnt_1ms == 10'd999)
                    
                                         begin
                                            cnt_1ms                 <= 10'd0;
                                              if(cnt_1s == 10'd999)//0.05s
                                                begin
                                                     cnt_1s       <= 10'd0;
                                                     fms_test       <= 2'd2; 
                                                  end
                                              else
                                                    begin
                                                        cnt_1s        <= cnt_1s + 10'd1;
                                                        fms_test       <= 2'd1; 
                                                    end
                                        end
                                     else         
                                        begin
                                         cnt_1ms                 <= cnt_1ms + 10'd1;
                                           fms_test                <= 2'd1; 
                                     end                         
                                end
                            else
                                begin
                                    cnt_1us                 <= cnt_1us + 9'd1;
                                      fms_test                <= 2'd1; 
                                end
                                
                        end
                    2'd2:   
                        begin
//                            if(cnt_10 <= 10'd511)                       
//                                spc_acc_pluse                      <= spc_acc_pluse_start_r;
//                            else
//                                spc_acc_pluse                      <=  spc_acc_pluse_r;

                            if(cnt_10 <= 10'd511)                       
                               spc_acc_pluse                      <= {1'b1,spc_acc_pluse_r};
                            else
                                spc_acc_pluse                      <=  {1'b0,spc_acc_pluse_start_r};

                              spc_acc_pluse_valid                <= 1'b1;
                            if(cnt_10 == 10'd1023)
                                begin
                                cnt_10                          <= 10'd0;
                                fms_test                         <= 2'd3;  
                                end
                            else
                                begin
                                cnt_10                          <= cnt_10 + 10'd1;
                                fms_test                        <= 2'd2;
                       
                                end
                        end
                    2'd3:
                        begin
                               spc_acc_pluse_valid              <= 1'b0;   
                               fms_test                         <= 2'd1; 
                               spc_acc_pluse_start_r            <= 32'd0;
                               spc_acc_pluse_r                   <= 32'd0;
              
                        end
                    default:
                        begin
                        end
                    endcase
                 end 
        end

endmodule
