`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/26 19:26:40
// Design Name: 
// Module Name: Gen_Delay_U0
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


module Gen_Delay_U0(Reset,Sys_Clk1
,pinc1,pluse_width1,delay_cnt1,delay_cnt2
,Trig_in1,Trig_out1,Trig_out2
    );
input                          Reset;
input                           Sys_Clk1;


  


input[31:0]                     pinc1;
input[7:0]                     pluse_width1;
input[15:0]                     delay_cnt1;
input[15:0]                     delay_cnt2;

reg[15:0]                     delay_cnt1_r;
reg[15:0]                     delay_cnt2_r;    
output                           Trig_in1;
output                           Trig_out1;    
output                           Trig_out2;
(*Mark_debug="TRUE"*)reg                             Trig_in1;
(*Mark_debug="TRUE"*)reg                            Trig_out1;    
(*Mark_debug="TRUE"*)reg                            Trig_out2;

reg[7:0]   						cnt1_DS_Delay_Pluse;
reg[7:0]   						cnt2_DS_Delay_Pluse;
reg[15:0]   						cnt2_DS_Delay;  
reg[7:0]   						cnt3_DS_Delay_Pluse;
reg[15:0]   						cnt3_DS_Delay; 
reg                     		sync_en1_1;  
reg                     		sync_en1_2;  


reg                     		sync_en2_1;  
reg                     		sync_en2_2;  
reg                     		sync_en3_1;  
reg                     		sync_en3_2;  

wire                                m_axis_data_tvalid;
wire[15:0]                          sine;

wire                                m_axis_data_tvalid1;
wire[15:0]                          sine1;

reg                                 sine1_r1;
reg                                 sine1_r2;
wire                                sin_buf;

reg                                 Trig_out_r;
 
 reg[1:0]                           fms_data2;
 reg[1:0]                           fms_data3;
 reg                                asy2_o_r1;
 reg                                asy2_o_r2;
 wire                       sin_buf1;
   BUFG BUFG_inst (
      .O(sin_buf), // 1-bit output: Clock output
      .I(sine[15])  // 1-bit input: Clock input
   );
   

 
   
(*Mark_debug="TRUE"*)reg[1:0]           fms_data1;
 always@(posedge Sys_Clk1 or negedge Reset)
    if(Reset == 1'b1)
        begin         
           fms_data1      					 	<= 2'd0;
           cnt1_DS_Delay_Pluse                  <= 8'd0;
           Trig_in1                             <= 1'b0;
           sync_en1_1                           <= 1'b0;
           sync_en1_2                           <= 1'b0;
        end
    else
        begin 
            sync_en1_1                            <= sin_buf;
            sync_en1_2                            <= sync_en1_1;                     
            case(fms_data1)
        2'd0:
            begin
                     Trig_in1                        <= 1'b0;  
                if((sync_en1_1 == 1'b1) &&(sync_en1_2==1'b0))
                    begin
                    fms_data1       			<= 2'd1;
                    end
                else
                    fms_data1       			<= 2'd0;
            end
        2'd1:
             begin  //ÑÓÊ±
                Trig_in1                        <= 1'b1;  
                    if(cnt1_DS_Delay_Pluse == pluse_width1)
                        begin
                            fms_data1       	<= 2'd0;
                            cnt1_DS_Delay_Pluse <= 8'd0;
                        end
                    else
                        begin
                            cnt1_DS_Delay_Pluse <= cnt1_DS_Delay_Pluse +8'd1;
                            fms_data1       	<= 2'd1;
                       end				       
            end 
            default:
                begin
                end
            endcase
		end   


always@(posedge Sys_Clk1 or negedge Reset)
    if(Reset == 1'b1)
        begin         
           fms_data2      					 	<= 2'd0;
           cnt2_DS_Delay   		                <= 16'd0;
           cnt2_DS_Delay_Pluse                  <= 8'd0;
           Trig_out1                            <= 1'b0;
           delay_cnt1_r                         <= 16'd0;
           sync_en2_1                           <= 1'b0;
           sync_en2_2                           <= 1'b0;
        end
    else
        begin 
            delay_cnt1_r                        <= delay_cnt1;
            sync_en2_1                            <= sin_buf;
            sync_en2_2                            <= sync_en2_1; 
                            
            case(fms_data2)
        2'd0:
            begin
                Trig_out1       				<= 1'b0;
                if((sync_en2_1 == 1'b1) &&(sync_en2_2==1'b0))
                    begin
                    fms_data2       			<= 2'd1;
                    end
                else
                    fms_data2       			<= 2'd0;
            end
        2'd1:
             begin  //ÑÓÊ±
                if(cnt2_DS_Delay == delay_cnt1_r)
                    begin
                        cnt2_DS_Delay   		<= 16'd0;
                        fms_data2       		<= 2'd2;
                    end
                else
                    begin
                        cnt2_DS_Delay   		<= cnt2_DS_Delay+16'd1;
                        fms_data2       		<= 2'd1;
                     end                  
            end
        2'd2:
            begin//Âö¿í
                Trig_out1       				<= 1'b1;  
                    if(cnt2_DS_Delay_Pluse == pluse_width1)
                        begin
                            fms_data2       	<= 2'd0;
                            cnt2_DS_Delay_Pluse <= 8'd0;
                        end
                    else
                        begin
                            cnt2_DS_Delay_Pluse <= cnt2_DS_Delay_Pluse +8'd1;
                            fms_data2       	<= 2'd2;
                       end				       
            end 
            default:
                begin
                end
            endcase
		end   

 
 always@(posedge Sys_Clk1 or negedge Reset)
    if(Reset == 1'b1)
        begin         
           fms_data3      					 	<= 2'd0;
           cnt3_DS_Delay   		                <= 16'd0;
           cnt3_DS_Delay_Pluse                  <= 8'd0;
           Trig_out2                            <= 1'b0;
           delay_cnt2_r                         <= 16'd0;
           sync_en3_1                           <= 1'b0;
           sync_en3_2                           <= 1'b0;
        end
    else
        begin   
            delay_cnt2_r                        <= delay_cnt2;          
              sync_en3_1                            <= sin_buf;
            sync_en3_2                            <= sync_en3_1;                      
            case(fms_data3)
        2'd0:
            begin
                Trig_out2       				<= 1'b0;
                if((sync_en3_1 == 1'b1) &&(sync_en3_2==1'b0))
                    begin
                    fms_data3       			<= 2'd1;
                    end
                else
                    fms_data3       			<= 2'd0;
            end
        2'd1:
             begin  //ÑÓÊ±
                if(cnt3_DS_Delay == delay_cnt2_r)
                    begin
                        cnt3_DS_Delay   		<= 16'd0;
                        fms_data3       		<= 2'd2;
                    end
                else
                    begin
                        cnt3_DS_Delay   		<= cnt3_DS_Delay+16'd1;
                        fms_data3       		<= 2'd1;
                     end                  
            end
        2'd2:
            begin//Âö¿í
                Trig_out2       				<= 1'b1;  
                    if(cnt3_DS_Delay_Pluse == pluse_width1)
                        begin
                            fms_data3       	<= 2'd0;
                            cnt3_DS_Delay_Pluse <= 8'd0;
                        end
                    else
                        begin
                            cnt3_DS_Delay_Pluse <= cnt3_DS_Delay_Pluse +8'd1;
                            fms_data3       	<= 2'd2;
                       end				       
            end 
            default:
                begin
                end
            endcase
		end                  
           
dds_compiler_0 dds_compiler_0_inst(
.aclk(Sys_Clk1),
.s_axis_phase_tvalid(1'b1),
.s_axis_phase_tdata(pinc1),
.m_axis_data_tvalid(m_axis_data_tvalid),
.m_axis_data_tdata(sine)
);



endmodule