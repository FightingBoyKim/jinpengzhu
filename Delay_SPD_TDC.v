`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/10 19:45:50
// Design Name: 
// Module Name: Delay_SPD_TDC
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


module Delay_SPD_TDC(Reset,Sys_Clk1,Start,Stop_out1,Stop_out2,Trig_Counter_Period_delay_1,Trig_Data_Valid_delay_1,
Stop_Counter_Period_delay_1_1,Stop_Data_Valid_delay_1_1,Stop_Counter_Period_delay_2_1,Stop_Data_Valid_delay_2_1
,count_abs
    );
input                                      Reset;
input                                      Sys_Clk1; 
input                                      Start;
input                                      Stop_out1;
input                                      Stop_out2; 
input[21:0]                                count_abs;
output[21:0]             Trig_Counter_Period_delay_1;
output                   Trig_Data_Valid_delay_1;




output[21:0]		      Stop_Counter_Period_delay_1_1;
output					  Stop_Data_Valid_delay_1_1;


output[21:0]			  Stop_Counter_Period_delay_2_1;
	
output					  Stop_Data_Valid_delay_2_1;
 
  
reg[21:0]               Trig_Counter_Period_delay_1;
reg                     Trig_Data_Valid_delay_1;
reg[21:0]		         Stop_Counter_Period_delay_1_1;
reg					    Stop_Data_Valid_delay_1_1;
reg[21:0]			    Stop_Counter_Period_delay_2_1;	
reg					    Stop_Data_Valid_delay_2_1;

reg                                      Start_r1;
reg                                      Stop_out1_r1;
reg                                      Stop_out2_r1;
 
reg                                      Start_r2;
reg                                      Stop_out1_r2;
reg                                      Stop_out2_r2;

always@(posedge Sys_Clk1 or negedge Reset)
   if(Reset == 1'b1)
       begin
        Start_r1                        <= 1'b0;
        Stop_out1_r1                    <= 1'b0;
        Stop_out2_r1                    <= 1'b0;
        Start_r2                        <= 1'b0;
        Stop_out1_r2                    <= 1'b0;
        Stop_out2_r2                    <= 1'b0;    
        
        Trig_Counter_Period_delay_1     <= 22'd0;
        Trig_Data_Valid_delay_1         <= 1'b0;
        Stop_Counter_Period_delay_1_1   <= 22'd0;
        Stop_Data_Valid_delay_1_1       <= 1'b0;
        Stop_Counter_Period_delay_2_1   <= 22'd0;	
        Stop_Data_Valid_delay_2_1       <= 1'b0;          
       end
    else
        begin
          Start_r1                        <=Start;
          Stop_out1_r1                    <= Stop_out1;
          Stop_out2_r1                    <= Stop_out2;
          Start_r2                        <= Start_r1;
          Stop_out1_r2                    <= Stop_out1_r1;
          Stop_out2_r2                    <= Stop_out2_r1;          
        

          if((Start_r1 == 1'b1) && (Start_r2 == 1'b0))
                begin
                    Trig_Counter_Period_delay_1     <= count_abs;
                    Trig_Data_Valid_delay_1         <= 1'b1;           
                end
           else
                begin
                    Trig_Data_Valid_delay_1         <= 1'b0;
                end
 
           if((Stop_out1_r1 == 1'b1) && (Stop_out1_r2 == 1'b0))
                begin
                    Stop_Counter_Period_delay_1_1     <= count_abs;
                    Stop_Data_Valid_delay_1_1         <= 1'b1;           
                end
           else
                begin
                    Stop_Data_Valid_delay_1_1         <= 1'b0;
                end
                
          if((Stop_out2_r1 == 1'b1) && (Stop_out2_r2 == 1'b0))
                begin
                    Stop_Counter_Period_delay_2_1     <= count_abs;
                    Stop_Data_Valid_delay_2_1         <= 1'b1;           
                end
           else
                begin
                    Stop_Data_Valid_delay_2_1         <= 1'b0;
                end                     
        
        end
  
endmodule
