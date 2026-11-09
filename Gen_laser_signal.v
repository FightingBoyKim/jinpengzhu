`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/09 22:40:56
// Design Name: 
// Module Name: Gen_laser_signal
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


module Gen_laser_signal(Clk_in_200m,Reset,FPGA_START_OUT,FPGA_STOP_OUT_2,FPGA_STOP_OUT_1,laser_freq_pinc,laser_freq_pluse,S_delay1,S_delay2
    );
input                           Clk_in_200m;
input                           Reset;
output                          FPGA_START_OUT;
output                          FPGA_STOP_OUT_2;
output                          FPGA_STOP_OUT_1;
input[31:0]                     laser_freq_pinc;
input[7:0]                      laser_freq_pluse;
input[15:0]                      S_delay1;
input[15:0]                     S_delay2;
reg[1:0]                        SPDT_mode_r;
reg[1:0]                        SPDT_mode_r1;
wire                            m_axis_data_tvalid;
wire[15:0]                      m_axis_data_tdata;

wire                            m_axis_data_tvalid2;
wire[15:0]                      m_axis_data_tdata2;
reg                             FPGA_START_OUT;
reg                             FPGA_STOP_OUT_1;
reg                             FPGA_STOP_OUT_2;

reg                             FPGA_STOP_OUT_1_1;
reg                             FPGA_STOP_OUT_2_1;
reg                             FPGA_STOP_OUT_1_1r;
reg                             FPGA_STOP_OUT_2_1r;
reg[15:0]                      sin_start;
reg[15:0]                      sin_stop;
reg                            sin_start_r;
reg                            sin_stop_r; 

reg                             FPGA_START_OUT_r;
reg                             FPGA_STOP_OUT_r;
reg                             FPGA_STOP_OUT_r1;
reg[1:0]                     fms_start;
reg[1:0]                     fms_stop;
reg[7:0]                     cnt_start;
reg[7:0]                     cnt_stop;
reg[1:0]                     cnt_2;
reg                          cnt_1;
reg[7:0]                     laser_freq_pluse_r;
reg[7:0]                     laser_freq_pluse_r1;

reg[31:0]                     laser_freq_pinc1;
reg[31:0]                     laser_freq_pinc2;
always@(posedge Clk_in_200m or negedge Reset)
    if(Reset == 1'b1)
        begin
            FPGA_START_OUT          <= 1'b0;
            FPGA_START_OUT_r          <= 1'b0;
            FPGA_STOP_OUT_r           <= 1'b0;            
            sin_start               <= 16'd0;
            sin_stop                <= 16'd0;
            sin_start_r             <= 1'b0;
            sin_stop_r              <= 1'b0;

            fms_start               <= 2'd0;
            fms_stop                <= 2'd0; 
            cnt_start               <= 8'd0;
            cnt_stop                <= 8'd0;
            laser_freq_pluse_r      <= 8'd0;
            laser_freq_pluse_r1     <= 8'd0;
        end
     else
        begin
            laser_freq_pinc1        <= laser_freq_pinc;
            laser_freq_pinc2        <= laser_freq_pinc1;
            FPGA_START_OUT          <= FPGA_START_OUT_r;
        
            sin_start               <= m_axis_data_tdata;
            sin_stop                <= m_axis_data_tdata2; 
            
            sin_start_r             <= sin_start[15];
            sin_stop_r              <= sin_stop[15];         
     
            laser_freq_pluse_r      <= {laser_freq_pluse[6:0],1'b0};
            laser_freq_pluse_r1     <= laser_freq_pluse_r;     
           case(fms_start)
        2'd0:
            begin
               if((sin_start[15] == 1'b1) && (sin_start_r == 1'b0))    
                 fms_start           <= 2'd1;
             else
                 fms_start           <= 2'd0;
            end
        2'd1:
            begin
                FPGA_START_OUT_r          <= 1'b1;
                if(cnt_start == laser_freq_pluse_r1)
                    begin
                        cnt_start       <= 8'd0;
                        fms_start       <= 2'd2;
                    end
                else
                    begin
                        cnt_start       <= cnt_start + 8'd1;
                        fms_start       <= 2'd1;
                    end
            end
       2'd2:
            begin
                FPGA_START_OUT_r          <= 1'b0;
               fms_start               <= 2'd0; 
            end
         default:
            begin
            end
         endcase      
                 
    
                 
           case(fms_stop)
        2'd0:
            begin
             if((sin_stop[15] == 1'b1) && (sin_stop_r == 1'b0))     
                 fms_stop           <= 2'd1;
             else
                 fms_stop           <= 2'd0;
            end
        2'd1:
            begin
                FPGA_STOP_OUT_r          <= 1'b1;
                if(cnt_stop == laser_freq_pluse_r1)
                    begin
                        cnt_stop       <= 8'd0;
                        fms_stop       <= 2'd2;
                    end
                else
                    begin
                        cnt_stop       <= cnt_stop + 8'd1;
                        fms_stop       <= 2'd1;
                    end
            end
       2'd2:
            begin
                FPGA_STOP_OUT_r          <= 1'b0;
                   fms_stop               <= 2'd0; 
            end
         default:
            begin
            end
         endcase                                                                  
        end
//stop切换

   always@(posedge Clk_in_200m or negedge Reset)
    if(Reset == 1'b1)
        begin
            SPDT_mode_r             <= 2'd0;
            SPDT_mode_r1            <= 2'd0;
            FPGA_STOP_OUT_1           <= 1'b0;
            FPGA_STOP_OUT_2           <= 1'b0;   
            
            FPGA_STOP_OUT_1_1         <= 1'b0;
            FPGA_STOP_OUT_2_1         <= 1'b0;    
            FPGA_STOP_OUT_1_1r         <= 1'b0;
            FPGA_STOP_OUT_2_1r         <= 1'b0;                             
            cnt_1                   <= 1'd0;
            cnt_2                   <= 2'd0; 
            FPGA_STOP_OUT_r1        <= 1'b0;           
        end
    else
        begin
             FPGA_STOP_OUT_r1       <= FPGA_STOP_OUT_r;
             SPDT_mode_r            <= SPDT_mode;
             SPDT_mode_r1           <= SPDT_mode_r;
             
            FPGA_STOP_OUT_1         <= FPGA_STOP_OUT_1_1;
            FPGA_STOP_OUT_2         <= FPGA_STOP_OUT_2_1;  
             
 
                     
            case(SPDT_mode_r1)
          2'd0:
            begin
                FPGA_STOP_OUT_1_1       <= FPGA_STOP_OUT_r;//固定同频率
                FPGA_STOP_OUT_2_1       <= FPGA_STOP_OUT_r;//固定同频率              
            end
          2'd1:
            begin//1/2
                case(cnt_1)
               1'b0:
                    begin
                        FPGA_STOP_OUT_1_1           <= 1'b0;
                        FPGA_STOP_OUT_2_1            <= 1'b0;
                        if((FPGA_STOP_OUT_r == 1'b0) &&(FPGA_STOP_OUT_r1 == 1'b1))
                            cnt_1               <= 1'b1;
                        else
                            cnt_1                <= 1'b0;
                    end
                1'b1:
                    begin
                        FPGA_STOP_OUT_1_1            <= FPGA_STOP_OUT_r1;
                        FPGA_STOP_OUT_2_1           <= FPGA_STOP_OUT_r1;
                        if((FPGA_STOP_OUT_r == 1'b0) &&(FPGA_STOP_OUT_r1 == 1'b1))
                            cnt_1               <= 1'b0;
                        else
                            cnt_1                <= 1'b1;                    
                    end
                default:
                    begin
                    end
                endcase
            end
           2'd2://1/4
            begin
                       case(cnt_2)
               2'd0:
                    begin
                        FPGA_STOP_OUT_2_1           <= FPGA_STOP_OUT_r1;
                        FPGA_STOP_OUT_1_1            <= FPGA_STOP_OUT_r1;
                        if((FPGA_STOP_OUT_r == 1'b0) &&(FPGA_STOP_OUT_r1 == 1'b1))
                            cnt_2               <= 2'd1;
                        else
                            cnt_2                <= 2'd0;
                    end
               2'd1:
                    begin
                          FPGA_STOP_OUT_2_1           <= 1'b0;
                        FPGA_STOP_OUT_1_1            <= 1'b0;
                        if((FPGA_STOP_OUT_r == 1'b0) &&(FPGA_STOP_OUT_r1 == 1'b1))
                            cnt_2               <= 2'd2;
                        else
                            cnt_2                <= 2'd1;                    
                    end
                2'd2:
                    begin
                  
                        if((FPGA_STOP_OUT_r == 1'b0) &&(FPGA_STOP_OUT_r1 == 1'b1))
                            cnt_2               <= 2'd3;
                        else
                            cnt_2                <= 2'd2;
                    end
               2'd3:
                    begin
      
                        if((FPGA_STOP_OUT_r == 1'b0) &&(FPGA_STOP_OUT_r1 == 1'b1))
                            cnt_2               <= 2'd0;
                        else
                            cnt_2                <= 2'd3;                    
                    end                   
                    
                default:
                    begin
                    end
                endcase               
            end
          default:
            begin
            end
          endcase
        end     
dds_compiler_1 dds_compiler_1_inst(
.aclk(Clk_in_200m),
.s_axis_phase_tvalid(1'b1),
.s_axis_phase_tdata(laser_freq_pinc2),//1KHz~100KHz
.m_axis_data_tvalid(m_axis_data_tvalid),
.m_axis_data_tdata(m_axis_data_tdata)
); 
  
 dds_compiler_1 dds_compiler_2_inst(
.aclk(Clk_in_200m),
.s_axis_phase_tvalid(1'b1),
.s_axis_phase_tdata(laser_freq_pinc2),//1KHz~100KHz
.m_axis_data_tvalid(m_axis_data_tvalid2),
.m_axis_data_tdata(m_axis_data_tdata2)
); 
     
endmodule
