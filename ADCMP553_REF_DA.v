`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 22:34:14
// Design Name: 
// Module Name: ADCMP553_REF_DA
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


module ADCMP553_REF_DA(
Sys_Clk,Reset,fpga_din1, fpga_sclk1, fpga_cs1, fpga_din2, fpga_sclk2, fpga_cs2,DA_Ref1,DA_Ref2 
,fpga_din3, fpga_sclk3, fpga_cs3,DA_Ref3 
);
input   Sys_Clk;
input   Reset;  
input[9:0] DA_Ref1;

input[9:0] DA_Ref2;
   
(*Mark_debug="TRUE"*)output  fpga_din1;
(*Mark_debug="TRUE"*)output  fpga_sclk1;
(*Mark_debug="TRUE"*)output  fpga_cs1;
(*Mark_debug="TRUE"*)output  fpga_din2;
(*Mark_debug="TRUE"*)output  fpga_sclk2;
(*Mark_debug="TRUE"*)output  fpga_cs2; 
  
input[9:0] DA_Ref3;
(*Mark_debug="TRUE"*)output  fpga_din3;
(*Mark_debug="TRUE"*)output  fpga_sclk3;
(*Mark_debug="TRUE"*)output  fpga_cs3;

   
(*Mark_debug="TRUE"*)reg     da_start1;
(*Mark_debug="TRUE"*)reg     da_start3;
(*Mark_debug="TRUE"*)reg     da_start2;


 reg[1:0]   fms_data1;
 reg[1:0]   fms_data2; 
 reg[1:0]   fms_data3;
 reg[9:0]   DA_Ref1_r;
 reg[9:0]   DA_Ref1_r1;
 
 reg[9:0]   DA_Ref2_r;
 reg[9:0]   DA_Ref2_r1;
  
 reg[9:0]   DA_Ref3_r;
 reg[9:0]   DA_Ref3_r1;
 always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1)
        begin
            da_start1       <= 1'b0;
            fms_data1       <= 2'd0;
            DA_Ref1_r       <= 10'd0;
            DA_Ref1_r1      <= 10'd0;
        end
     else
        begin
            DA_Ref1_r       <= DA_Ref1;
            DA_Ref1_r1      <= DA_Ref1_r;
            if((DA_Ref1_r>DA_Ref1_r1) ||(DA_Ref1_r<DA_Ref1_r1))
                begin
                       da_start1       <= 1'b0;
                       fms_data1       <= 2'd0;
                end           
            else
                begin
                    case(fms_data1)
                 2'd0:
                    begin

                       fms_data1   <= 2'd1;
                       da_start1       <= 1'b1;
                            
                    end
                 2'd1:
                    begin
                          fms_data1     <= 2'd1;
                          da_start1     <= 1'b0;
                    end
                 default:
                    begin
                    end
                 endcase
                end
        end

  always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1)
        begin
            da_start3       <= 1'b0;
            fms_data3       <= 2'd0;
            DA_Ref3_r       <= 10'd0;
            DA_Ref3_r1      <= 10'd0;
        end
     else
        begin
            DA_Ref3_r       <= DA_Ref3;
            DA_Ref3_r1      <= DA_Ref3_r;
            if((DA_Ref3_r>DA_Ref3_r1) ||(DA_Ref3_r<DA_Ref3_r1))
                begin
                       da_start3       <= 1'b0;
                       fms_data3       <= 2'd0;
                end           
            else
                begin
                    case(fms_data3)
                 2'd0:
                    begin
                                fms_data3   <= 2'd1;
                               da_start3       <= 1'b1;
                        
                    end
                 2'd1:
                    begin
                          fms_data3     <= 2'd1;
                          da_start3     <= 1'b0;
                    end
                 default:
                    begin
                    end
                 endcase
                end
        end
 always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1)
        begin
            da_start2       <= 1'b0;
            fms_data2       <= 2'd0;
            DA_Ref2_r       <= 10'd0;
            DA_Ref2_r1      <= 10'd0;
        end
     else
        begin
            DA_Ref2_r       <= DA_Ref2;
            DA_Ref2_r1      <= DA_Ref2_r;
            if((DA_Ref2_r>DA_Ref2_r1) ||(DA_Ref2_r<DA_Ref2_r1))
                begin
                       da_start2       <= 1'b0;
                       fms_data2       <= 2'd0;
                end           
            else
                begin
                    case(fms_data2)
                 2'd0:
                    begin

                                fms_data2   <= 2'd1;
                               da_start2       <= 1'b1;
                    end
                 2'd1:
                    begin
                          fms_data2     <= 2'd1;
                          da_start2     <= 1'b0;
                    end
                 default:
                    begin
                    end
                 endcase
                end
        end
 
  
    
 DA_Module DA_Module_inst1(
.Sys_Clk(Sys_Clk),
.Reset(Reset),
.da_cs(fpga_cs1),
.da_clk(fpga_sclk1),
.da_din(fpga_din1),
.DA_Ref(DA_Ref1+10'd14),
.da_start(da_start1)
  );   
  
 DA_Module DA_Module_inst2(
.Sys_Clk(Sys_Clk),
.Reset(Reset),
.da_cs(fpga_cs2),
.da_clk(fpga_sclk2),
.da_din(fpga_din2),
.DA_Ref(DA_Ref2+10'd14),
.da_start(da_start2)
  ); 
  
    
 DA_Module DA_Module_inst3(
.Sys_Clk(Sys_Clk),
.Reset(Reset),
.da_cs(fpga_cs3),
.da_clk(fpga_sclk3),
.da_din(fpga_din3),
.DA_Ref(DA_Ref3+10'd14),
.da_start(da_start3)
  );   
  

     
endmodule
