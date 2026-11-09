`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/06 22:59:15
// Design Name: 
// Module Name: DA_Module
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


module DA_Module(Sys_Clk,Reset,da_cs,
da_clk,
da_din,DA_Ref,da_start
    );
input                           Sys_Clk;
input                           Reset;    
output                          da_cs;
output                          da_clk;
output                          da_din;
input[9:0]                      DA_Ref;
input                          da_start;
reg                            da_cs; 
reg                            da_clk;     
reg                            da_din;
reg[3:0]                       fms_da;
reg                            clk_5m;
reg[5:0]                       cnt_10;
reg[8:0]                        cnt_255;
always@(posedge Sys_Clk or negedge Reset)
         if(Reset) 
            begin
                cnt_10          <= 6'd0;
                clk_5m          <= 1'b0;
                
            end
         else
            begin
                if(cnt_10 == 6'd39)//5m
                    begin
                       cnt_10          <= 6'd0;                       
                    end
                 else
                    begin
                        cnt_10          <= cnt_10 + 6'd1;
                    end
                if(cnt_10 > 6'd19)    
                    clk_5m              <= 1'b1;
                else
                    clk_5m              <= 1'b0;
            end
always@(posedge Sys_Clk or negedge Reset)
         if(Reset) 
            begin
                da_cs           <= 1'b1; 
                da_clk          <= 1'b0;     
                da_din          <= 1'b0;
                fms_da          <= 4'd15;
               cnt_255          <= 8'd0;
            end
          else
            begin
                da_clk          <= clk_5m &&(~da_cs);
                case(fms_da)
             4'd15:
                begin
                    if(da_start == 1'b1)
                        fms_da  <= 4'd0;
                    else
                        fms_da  <= 4'd15;                  
                end
            4'd0:
                begin
                 da_cs           <= 1'b1;    
                     if(cnt_10 == 4'd9)   
                        fms_da   <= 4'd1;                     
                     else
                        fms_da   <= 4'd0;       
                end
            4'd1:
                begin
                       da_cs      <= 1'b0; 
                     if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd2;                     
                     else
                        fms_da   <= 4'd1;   
                       da_din     <= DA_Ref[9];                  
                end
            4'd2:
                begin
                     if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd3;                     
                     else
                        fms_da   <= 4'd2;   
                       da_din     <= DA_Ref[8];                  
                end
            4'd3:
                begin
                     if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd4;                     
                     else
                        fms_da   <= 4'd3;   
                       da_din     <= DA_Ref[7];                 
                end
            4'd4:
                begin
                      if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd5;                     
                     else
                        fms_da   <= 4'd4;   
                       da_din     <= DA_Ref[6];                
                end
             4'd5:
                begin
                     if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd6;                     
                     else
                        fms_da   <= 4'd5;   
                       da_din     <= DA_Ref[5];                              
                end
             4'd6:
                begin
                      if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd7;                     
                     else
                        fms_da   <= 4'd6;   
                       da_din     <= DA_Ref[4];                
                end
             4'd7:
                begin
                     if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd8;                     
                     else
                        fms_da   <= 4'd7;   
                       da_din     <= DA_Ref[3];                 
                end
             4'd8:
                begin
                      if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd9;                     
                     else
                        fms_da   <= 4'd8;   
                       da_din     <= DA_Ref[2];                
                end
             4'd9:
                begin
                       if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd10;                     
                     else
                        fms_da   <= 4'd9;   
                       da_din     <= DA_Ref[1];               
                end
             4'd10:
                begin
                      if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd11;                     
                     else
                        fms_da   <= 4'd10;   
                        da_din   <= DA_Ref[0];                
                end
             4'd11:
                begin
                     if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd12;                     
                     else
                        fms_da   <= 4'd11;   
                       da_din     <= 1'b0;                  
                end
             4'd12:
                begin
                      if(cnt_10 == 6'd39)   
                        fms_da   <= 4'd13;                     
                     else
                        fms_da   <= 4'd12;   
                       da_din     <= 1'b0;                 
                end
             4'd13:
                begin
                       da_cs      <= 1'b1; 
                    if(cnt_255 == 8'd7)   
                        begin
                        fms_da   <= 4'd15;  
                        cnt_255 <= 8'd0;
                        end
                    else
                        begin
                        fms_da   <= 4'd13;  
                        cnt_255<= cnt_255 + 8'd1;
                        end
                end   
             default:
                begin
                end
             endcase
             
            end



endmodule
 