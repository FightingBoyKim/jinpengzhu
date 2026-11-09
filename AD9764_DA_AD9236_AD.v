`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/17 13:11:10
// Design Name: 
// Module Name: AD9764_DA_AD9236_AD
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


module AD9764_DA_AD9236_AD(Clk_in,Reset,DA_CLK,DA_Data,AD_CLK,AD_Data,AD_OTR
,Scan_start,Scan_flag,Scan_pinc
    );
input                           Clk_in;
input                           Reset;
input                                Scan_start;
input                                Scan_flag;
input[15:0]                          Scan_pinc;
output                          DA_CLK;
output[13:0]                    DA_Data;   
output                          AD_CLK;
(*Mark_debug="TRUE"*)input[11:0]                     AD_Data;

input                           AD_OTR;

reg[13:0]                       DA_Data;
(*Mark_debug="TRUE"*)reg[13:0]                       m_axis_data_tdata;
//DA输出，按0.1s变化一次，进行扫描，扫描范围从-3v到+3V,步进位0.1V,0-8191
(*Mark_debug="TRUE"*)reg                             Scan_start_r;
reg                             Scan_start_r1;
(*Mark_debug="TRUE"*)reg[2:0]                        fms_scan;
reg[31:0]                       cnt_100ms;
reg[31:0]                       cnt_100ms_1;
reg[6:0]                        cnt_7;
reg                             lock_flag;
(*Mark_debug="TRUE"*)reg[2:0]                        fms_ad;
reg[33:0]                       acc_adc;//22+12
(*Mark_debug="TRUE"*)reg[11:0]                       aver_data;
reg                             acc_flag; 
(*Mark_debug="TRUE"*)reg[11:0]                       min_adc;
(*Mark_debug="TRUE"*)reg[13:0]                       min_adc_index;
reg[5:0]                        cnt_61;
assign       DA_CLK=  Clk_in;
assign AD_CLK=Clk_in;
always@(posedge Clk_in or negedge Reset)//主时钟50mhz
    if(Reset == 1'b1)
        begin
            DA_Data             <= 14'd0;
            m_axis_data_tdata   <= 14'd132;
            Scan_start_r        <= 1'b0;
            Scan_start_r1       <= 1'b0;
            fms_scan            <= 3'd0;
            cnt_100ms           <= 32'd0;
            cnt_100ms_1         <= 32'd0;
            fms_ad              <= 3'd0;
            acc_adc             <= 34'd0;
            aver_data           <= 12'd0;
            acc_flag            <= 1'b0;
            min_adc             <= 12'd4095;
            min_adc_index       <= 14'd0;
            cnt_61              <= 6'd0;
        end
    else
        begin
 
        
        Scan_start_r        <= Scan_start;
            Scan_start_r1       <= Scan_start_r;
            
            if((Scan_start_r == 1'b0) && (Scan_start_r1 == 1'b1))
                begin
                   fms_scan            <= 3'd0;
                   DA_Data             <= 14'd0;
                   cnt_100ms           <= 32'd0;
                end
             else
                begin
                    case(fms_scan)
                 3'd0:
                    begin
                         if((Scan_start_r == 1'b1) && (Scan_start_r1 == 1'b0))
                            fms_scan    <= 3'd1;
                         else
                            fms_scan    <= 3'd0;
                    end
                 3'd1:
                    begin
 //开始扫描，步进0.1v，扫描时间0.1s，132表示0.1
                     if(cnt_100ms == 32'd4194303)//22bit
        
                            begin
                               cnt_100ms        <= 32'd0; 
                                fms_scan        <= 3'd2;
                            end
                        else
                            begin
                               cnt_100ms        <= cnt_100ms + 32'd1;
                                fms_scan        <= 3'd1;
                            end
                                           
                    end
                 3'd2:
                    begin
                         fms_scan               <= 3'd3;
                    end
                 3'd3:
                    begin
                         fms_scan               <= 3'd4;
                    end
                 3'd4:
                    begin
                       if(m_axis_data_tdata > 14'd8052)
                            m_axis_data_tdata       <= 14'd0;     
                       else
                            m_axis_data_tdata        <= m_axis_data_tdata + 14'd132; 
                        fms_scan                <= 3'd5;
                    end
                 3'd5:
                    begin
                         if(lock_flag == 1'b1)
                            begin
                                  fms_scan            <= 3'd6;
                                  DA_Data             <= min_adc_index;
                            end
                         else
                            begin
                                DA_Data             <= m_axis_data_tdata[13:0]+14'h2000;
                                fms_scan            <= 3'd1;
                            end
                    end
                 default:
                    begin
                    end
                  endcase
                end   
//AD判断极小值，±5V  12bit数据 
             if((Scan_start_r == 1'b0) && (Scan_start_r1 == 1'b1))
                begin
                    fms_ad              <= 3'd0;
                    acc_adc             <= 34'd0;
                    aver_data           <= 12'd0;   
                    cnt_100ms_1         <= 32'd0;  
                    min_adc_index       <= 14'd0;  
                    lock_flag           <= 1'b0;           
                end
             else
                begin
                case(fms_ad)
            3'd0:
                begin
                       if((Scan_start_r == 1'b1) && (Scan_start_r1 == 1'b0))
                           begin
                                fms_ad              <= 3'd1;
                                acc_adc             <= 34'd0;
                           end
                         else
                            fms_ad                  <= 3'd0;            
                end
            3'd1:
                begin
 //累积时间65536*64 =22bit      
                      acc_adc                       <= acc_adc +  AD_Data; 
                   if(cnt_100ms_1 == 32'd4194303)//22bit
         
              
                            begin
                               cnt_100ms_1        <= 32'd0; 
                                fms_ad            <= 3'd2;
                            end
                        else
                            begin
                               cnt_100ms_1        <= cnt_100ms_1 + 32'd1;
                                fms_ad            <= 3'd1;
                            end
                                                       
                end
            3'd2:
                begin
                  aver_data                     <= acc_adc[33:22]+acc_adc[21];
               
                     fms_ad                       <= 3'd3;
                end
             3'd3:
                begin
                      fms_ad                     <= 3'd4;//扫描扫2个周期，
                    if(min_adc >aver_data)
                       begin
                            min_adc              <= aver_data;
                            min_adc_index        <= m_axis_data_tdata;
                       end
                    else
                       begin
                            min_adc                 <= min_adc;
                            min_adc_index           <= min_adc_index;
                        end
                end
              3'd4:
                begin
                    if(cnt_61 == 6'd60)
                        begin
                            lock_flag                   <= 1'b1;
                            cnt_61                      <= 6'd0;
                            fms_ad                      <= 3'd6;
                        end
                    else
                        begin
                            lock_flag                  <= 1'b0;
                            cnt_61                     <= cnt_61 + 6'd1;
                           fms_ad                      <= 3'd5;
                        end
                    
                end
              3'd5:
                begin
                          fms_ad                     <= 3'd1;
                end
            default:
                begin
                
                end
            endcase
            end    
        end
        
        
   
        
endmodule
