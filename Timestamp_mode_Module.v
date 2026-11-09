`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/24 19:27:17
// Design Name: 
// Module Name: Timestamp_mode_Module
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


module Timestamp_mode_Module(TDC_test_flag,
Trig_Counter_Period_1_1,Trig_Phase_Value_1_1,Trig_Data_Valid_1_1,Trig_Counter_Period_1_2,Trig_Phase_Value_1_2,Trig_Data_Valid_1_2,
Trig_Counter_Period_1_3,Trig_Phase_Value_1_3,Trig_Data_Valid_1_3,Trig_Counter_Period_1_4,Trig_Phase_Value_1_4,Trig_Data_Valid_1_4,
Stop_Counter_Period_1_1,Stop_Phase_Value_1_1,Stop_Data_Valid_1_1,Stop_Counter_Period_1_2,Stop_Phase_Value_1_2,Stop_Data_Valid_1_2,
Stop_Counter_Period_1_3,Stop_Phase_Value_1_3,Stop_Data_Valid_1_3,Stop_Counter_Period_1_4,Stop_Phase_Value_1_4,Stop_Data_Valid_1_4,
Stop_Counter_Period_2_1,Stop_Phase_Value_2_1,Stop_Data_Valid_2_1,Stop_Counter_Period_2_2,Stop_Phase_Value_2_2,Stop_Data_Valid_2_2,
Stop_Counter_Period_2_3,Stop_Phase_Value_2_3,Stop_Data_Valid_2_3,Stop_Counter_Period_2_4,Stop_Phase_Value_2_4,Stop_Data_Valid_2_4,
Sys_Clk,Reset,Timestamp_DATA,Timestamp_DATA_Valid,Sync_data,Sync_data_Valid,Spd1_Stop_data,Spd1_Stop_data_Valid,Spd2_Stop_data,Spd2_Stop_data_Valid,Spd_Delay_flag1,Spd_Delay_flag2
,Trig_Counter_Period_delay_1,Trig_Data_Valid_delay_1,Stop_Counter_Period_delay_1_1,Stop_Data_Valid_delay_1_1,Stop_Counter_Period_delay_2_1,Stop_Data_Valid_delay_2_1
,Sync_data_fine,Spd1_Stop_data_fine,Spd2_Stop_data_fine
);


(*Mark_debug="TRUE"*)output[31:0]                    Timestamp_DATA;
(*Mark_debug="TRUE"*)output                          Timestamp_DATA_Valid;
(*Mark_debug="TRUE"*)input[21:0]             Trig_Counter_Period_1_1;
(*Mark_debug="TRUE"*)input[3:0]              Trig_Phase_Value_1_1;
(*Mark_debug="TRUE"*)input                   Trig_Data_Valid_1_1;
(*Mark_debug="TRUE"*)input[21:0]             Trig_Counter_Period_1_2;
(*Mark_debug="TRUE"*)input[3:0]              Trig_Phase_Value_1_2;
(*Mark_debug="TRUE"*)input                   Trig_Data_Valid_1_2;
(*Mark_debug="TRUE"*)input[21:0]             Trig_Counter_Period_1_3;
(*Mark_debug="TRUE"*)input[3:0]              Trig_Phase_Value_1_3;
(*Mark_debug="TRUE"*)input                   Trig_Data_Valid_1_3;
(*Mark_debug="TRUE"*)input[21:0]             Trig_Counter_Period_1_4;
(*Mark_debug="TRUE"*)input[3:0]              Trig_Phase_Value_1_4;
(*Mark_debug="TRUE"*)input                   Trig_Data_Valid_1_4;
input                       TDC_test_flag;           
(*Mark_debug="TRUE"*)input[21:0]				                 Stop_Counter_Period_1_1;
(*Mark_debug="TRUE"*)input[3:0]                               Stop_Phase_Value_1_1;	
(*Mark_debug="TRUE"*)input					                 Stop_Data_Valid_1_1;

(*Mark_debug="TRUE"*)input[21:0]				                 Stop_Counter_Period_1_2;
(*Mark_debug="TRUE"*)input[3:0]                               Stop_Phase_Value_1_2;	
(*Mark_debug="TRUE"*)input					                 Stop_Data_Valid_1_2;

(*Mark_debug="TRUE"*)input[21:0]				                 Stop_Counter_Period_1_3;
(*Mark_debug="TRUE"*)input[3:0]                               Stop_Phase_Value_1_3;	
(*Mark_debug="TRUE"*)input					                 Stop_Data_Valid_1_3;

(*Mark_debug="TRUE"*)input[21:0]				                 Stop_Counter_Period_1_4;
(*Mark_debug="TRUE"*)input[3:0]                               Stop_Phase_Value_1_4;	
(*Mark_debug="TRUE"*)input					                 Stop_Data_Valid_1_4;


input[21:0]				                 Stop_Counter_Period_2_1;
input[3:0]                               Stop_Phase_Value_2_1;	
input					                 Stop_Data_Valid_2_1;

input[21:0]				                 Stop_Counter_Period_2_2;
input[3:0]                               Stop_Phase_Value_2_2;	
input					                 Stop_Data_Valid_2_2;

input[21:0]				                 Stop_Counter_Period_2_3;
input[3:0]                               Stop_Phase_Value_2_3;	
input					                 Stop_Data_Valid_2_3;

input[21:0]				                 Stop_Counter_Period_2_4;
input[3:0]                               Stop_Phase_Value_2_4;	
input					                 Stop_Data_Valid_2_4;

input[21:0]                              Trig_Counter_Period_delay_1;
input                                    Trig_Data_Valid_delay_1;
input[21:0]		                        Stop_Counter_Period_delay_1_1;
input					               Stop_Data_Valid_delay_1_1;
input[21:0]			                   Stop_Counter_Period_delay_2_1;	
input					               Stop_Data_Valid_delay_2_1;



input                                   Sys_Clk;
input                                   Reset; 
input                                   Spd_Delay_flag1;
input                                   Spd_Delay_flag2;
(*Mark_debug="TRUE"*)output[27:0]                            Sync_data;
(*Mark_debug="TRUE"*)output                                  Sync_data_Valid;
(*Mark_debug="TRUE"*)output[27:0]                            Spd1_Stop_data;
(*Mark_debug="TRUE"*)output                                  Spd1_Stop_data_Valid;
(*Mark_debug="TRUE"*)output[27:0]                            Spd2_Stop_data;
(*Mark_debug="TRUE"*)output                                  Spd2_Stop_data_Valid;

(*Mark_debug="TRUE"*)output[5:0]                            Sync_data_fine;
(*Mark_debug="TRUE"*)output[5:0]                            Spd1_Stop_data_fine;
(*Mark_debug="TRUE"*)output[5:0]                            Spd2_Stop_data_fine;

(*Mark_debug="TRUE"*)reg[5:0]                            Sync_data_fine;
(*Mark_debug="TRUE"*)reg[5:0]                            Spd1_Stop_data_fine;
(*Mark_debug="TRUE"*)reg[5:0]                            Spd2_Stop_data_fine;
reg[27:0]                            Sync_data;
reg                                  Sync_data_Valid;
reg[27:0]                            Spd1_Stop_data;
reg                                  Spd1_Stop_data_Valid;
reg[27:0]                            Spd2_Stop_data;
reg                                  Spd2_Stop_data_Valid;

reg[21:0]                               Trig_Counter_Period_1_1_r;
reg[3:0]                                Trig_Phase_Value_1_1_r;
reg                                     Trig_Data_Valid_1_1_r;
reg[21:0]                               Trig_Counter_Period_1_2_r;
reg[3:0]                                Trig_Phase_Value_1_2_r;
reg                                     Trig_Data_Valid_1_2_r;
reg[21:0]                               Trig_Counter_Period_1_3_r;
reg[3:0]                                Trig_Phase_Value_1_3_r;
reg                                     Trig_Data_Valid_1_3_r;
reg[21:0]                                Trig_Counter_Period_1_4_r;
reg[3:0]                                Trig_Phase_Value_1_4_r;
reg                                     Trig_Data_Valid_1_4_r;

reg[21:0]				                 Stop_Counter_Period_1_1_r;
reg[3:0]                                Stop_Phase_Value_1_1_r;	
reg					                    Stop_Data_Valid_1_1_r;

reg[21:0]				                 Stop_Counter_Period_1_2_r;
reg[3:0]                                Stop_Phase_Value_1_2_r;	
reg					                    Stop_Data_Valid_1_2_r;

reg[21:0]				                 Stop_Counter_Period_1_3_r;
reg[3:0]                                Stop_Phase_Value_1_3_r;	
reg					                    Stop_Data_Valid_1_3_r;

reg[21:0]				                 Stop_Counter_Period_1_4_r;
reg[3:0]                                Stop_Phase_Value_1_4_r;	
reg					                    Stop_Data_Valid_1_4_r;


reg[21:0]				                 Stop_Counter_Period_2_1_r;
reg[3:0]                                Stop_Phase_Value_2_1_r;	
reg					                    Stop_Data_Valid_2_1_r;

reg[21:0]				                 Stop_Counter_Period_2_2_r;
reg[3:0]                                Stop_Phase_Value_2_2_r;	
reg					                    Stop_Data_Valid_2_2_r;

reg[21:0]				                 Stop_Counter_Period_2_3_r;
reg[3:0]                                Stop_Phase_Value_2_3_r;	
reg					                    Stop_Data_Valid_2_3_r;

reg[21:0]				                 Stop_Counter_Period_2_4_r;
reg[3:0]                                Stop_Phase_Value_2_4_r;	
reg					                    Stop_Data_Valid_2_4_r;



reg                                     trig_flag1;
reg                                     trig_flag2;
reg                                     trig_flag3;
reg                                     trig_flag4;
reg                                     stop1_flag1;
reg                                     stop1_flag2;
reg                                     stop1_flag3;
reg                                     stop1_flag4;
reg[3:0]                                stop1_cnt;
reg                                     stop2_flag1;
reg                                     stop2_flag2;
reg                                     stop2_flag3;
reg                                     stop2_flag4;
reg[3:0]                                stop2_cnt;

reg[21:0]                               Trig1_1_r;
reg[21:0]                               Trig1_2_r;
reg[21:0]                               Trig1_3_r;
reg[21:0]                               Trig1_4_r;

reg[3:0]                               Trig1_1_r_fine;
reg[3:0]                               Trig1_2_r_fine;
reg[3:0]                               Trig1_3_r_fine;
reg[3:0]                               Trig1_4_r_fine;

//Coarse

reg[23:0]                               Trig1_data;
reg[5:0]                               Trig1_data_fine;
reg                                     Trig1_data_valid;

reg[23:0]                               Trig1_data_r;
reg[5:0]                                Trig1_data_r_fine;
reg                                     Trig1_data_valid_r;

      
(*Mark_debug="TRUE"*)reg[21:0]                               Stop1_1_r;
(*Mark_debug="TRUE"*)reg[21:0]                               Stop1_2_r;
(*Mark_debug="TRUE"*)reg[21:0]                               Stop1_3_r;
(*Mark_debug="TRUE"*)reg[21:0]                               Stop1_4_r;

(*Mark_debug="TRUE"*)reg[3:0]                               Stop1_1_r_fine;
(*Mark_debug="TRUE"*)reg[3:0]                               Stop1_2_r_fine;
(*Mark_debug="TRUE"*)reg[3:0]                               Stop1_3_r_fine;
(*Mark_debug="TRUE"*)reg[3:0]                               Stop1_4_r_fine;

(*Mark_debug="TRUE"*)reg[23:0]                               Stop1_data;
(*Mark_debug="TRUE"*)reg[5:0]                               Stop1_data_fine;
(*Mark_debug="TRUE"*)reg                                     Stop1_data_valid;

reg[23:0]                               Stop1_data_r;
reg[5:0]                               Stop1_data_r_fine;
reg                                     Stop1_data_valid_r;

(*Mark_debug="TRUE"*)reg[21:0]                               Stop2_1_r;
(*Mark_debug="TRUE"*)reg[21:0]                               Stop2_2_r;
(*Mark_debug="TRUE"*)reg[21:0]                               Stop2_3_r;
(*Mark_debug="TRUE"*)reg[21:0]                               Stop2_4_r;

(*Mark_debug="TRUE"*)reg[5:0]                               Stop2_1_r_fine;
(*Mark_debug="TRUE"*)reg[5:0]                               Stop2_2_r_fine;
(*Mark_debug="TRUE"*)reg[5:0]                               Stop2_3_r_fine;
(*Mark_debug="TRUE"*)reg[5:0]                               Stop2_4_r_fine;

(*Mark_debug="TRUE"*)reg[23:0]                               Stop2_data;
(*Mark_debug="TRUE"*)reg[5:0]                               Stop2_data_fine;
(*Mark_debug="TRUE"*)reg                                     Stop2_data_valid;

reg[23:0]                               Stop2_data_r;
reg[23:0]                               Stop2_data_r_fine;
reg                                     Stop2_data_valid_r;

reg                                     TDC_test_flag_r;
reg                                     TDC_test_flag_r1;
reg[1:0]                                fms_data;
reg[31:0]                               Timestamp_DATA;
reg                                     Timestamp_DATA_Valid;
reg[31:0]                               data_reg;


reg                 Spd_Delay_flag1_r;
reg                 Spd_Delay_flag1_r1;
reg                 Spd_Delay_flag2_r;
reg                 Spd_Delay_flag2_r1;










always@(posedge Sys_Clk or negedge Reset)
	if(Reset == 1'b1)
		begin	
		  Spd_Delay_flag1_r           <= 1'b0;
		  Spd_Delay_flag1_r1          <= 1'b0;
		  Spd_Delay_flag2_r           <= 1'b0;
		  Spd_Delay_flag2_r1          <= 1'b0;		  
		  
            Trig_Counter_Period_1_1_r   <= 22'd0;
            Trig_Phase_Value_1_1_r      <= 4'd0;
            Trig_Data_Valid_1_1_r       <= 1'b0;
            Trig_Counter_Period_1_2_r   <= 22'd0;
            Trig_Phase_Value_1_2_r      <= 4'd0;
            Trig_Data_Valid_1_2_r       <= 1'b0;
            Trig_Counter_Period_1_3_r   <= 22'd0;
            Trig_Phase_Value_1_3_r      <= 4'd0;
            Trig_Data_Valid_1_3_r       <= 1'b0;
            Trig_Counter_Period_1_4_r   <= 22'd0;
            Trig_Phase_Value_1_4_r      <= 4'd0;
            Trig_Data_Valid_1_4_r       <= 1'b0; 


            Stop_Counter_Period_1_1_r           <= 22'd0;
            Stop_Phase_Value_1_1_r              <= 4'd0;	
            Stop_Data_Valid_1_1_r               <= 1'b0;
            Stop_Counter_Period_1_2_r           <= 22'd0;
            Stop_Phase_Value_1_2_r              <= 4'd0;	
            Stop_Data_Valid_1_2_r               <= 1'b0;

            Stop_Counter_Period_1_3_r           <= 22'd0;
            Stop_Phase_Value_1_3_r              <= 4'd0;	
            Stop_Data_Valid_1_3_r               <= 1'b0;

            Stop_Counter_Period_1_4_r           <= 22'd0;
            Stop_Phase_Value_1_4_r              <= 4'd0;	
            Stop_Data_Valid_1_4_r               <= 1'b0;  

            Stop_Counter_Period_2_1_r           <= 22'd0;
            Stop_Phase_Value_2_1_r              <= 4'd0;	
            Stop_Data_Valid_2_1_r               <= 1'b0;
            Stop_Counter_Period_2_2_r           <= 24'd0;
            Stop_Phase_Value_2_2_r              <= 4'd0;	
            Stop_Data_Valid_2_2_r               <= 1'b0;

            Stop_Counter_Period_2_3_r           <= 22'd0;
            Stop_Phase_Value_2_3_r              <= 4'd0;	
            Stop_Data_Valid_2_3_r               <= 1'b0;

            Stop_Counter_Period_2_4_r           <= 22'd0;
            Stop_Phase_Value_2_4_r              <= 4'd0;	
            Stop_Data_Valid_2_4_r               <= 1'b0;
                 
		
		end
	else
	   begin
	      Spd_Delay_flag1_r           <= Spd_Delay_flag1;
		  Spd_Delay_flag1_r1          <= Spd_Delay_flag1_r;
		  Spd_Delay_flag2_r           <= Spd_Delay_flag2;
		  Spd_Delay_flag2_r1          <= Spd_Delay_flag2_r;	  
		  
		  if((Spd_Delay_flag1_r1 == 1'b1) && (Spd_Delay_flag2_r1 == 1'b1))
		      begin		  
            Trig_Counter_Period_1_1_r   <= Trig_Counter_Period_1_1;
            Trig_Phase_Value_1_1_r      <= Trig_Phase_Value_1_1;
            Trig_Data_Valid_1_1_r       <= Trig_Data_Valid_1_1;
            Trig_Counter_Period_1_2_r   <= Trig_Counter_Period_1_2;
            Trig_Phase_Value_1_2_r      <= Trig_Phase_Value_1_2;
            Trig_Data_Valid_1_2_r       <= Trig_Data_Valid_1_2;
            Trig_Counter_Period_1_3_r   <= Trig_Counter_Period_1_3;
            Trig_Phase_Value_1_3_r      <= Trig_Phase_Value_1_3;
            Trig_Data_Valid_1_3_r       <= Trig_Data_Valid_1_3;
            Trig_Counter_Period_1_4_r   <= Trig_Counter_Period_1_4;
            Trig_Phase_Value_1_4_r      <= Trig_Phase_Value_1_4;
            Trig_Data_Valid_1_4_r       <= Trig_Data_Valid_1_4;	     
		      end
		   else
		      begin
             Trig_Counter_Period_1_1_r   <= Trig_Counter_Period_delay_1;
            Trig_Phase_Value_1_1_r      <= 4'd0;
            Trig_Data_Valid_1_1_r       <= Trig_Data_Valid_delay_1;
            Trig_Counter_Period_1_2_r   <= Trig_Counter_Period_delay_1;
            Trig_Phase_Value_1_2_r      <= 4'd0;
            Trig_Data_Valid_1_2_r       <= Trig_Data_Valid_delay_1;
            Trig_Counter_Period_1_3_r   <= Trig_Counter_Period_delay_1;
            Trig_Phase_Value_1_3_r      <= 4'd0;
            Trig_Data_Valid_1_3_r       <= Trig_Data_Valid_delay_1;
            Trig_Counter_Period_1_4_r   <= Trig_Counter_Period_delay_1;
            Trig_Phase_Value_1_4_r      <= 4'd0;
            Trig_Data_Valid_1_4_r       <= Trig_Data_Valid_delay_1;	 		    
		    end


	    if(Spd_Delay_flag1_r1 == 1'b1)
		      begin
            Stop_Counter_Period_1_1_r   <= Stop_Counter_Period_1_1;
            Stop_Phase_Value_1_1_r      <= Stop_Phase_Value_1_1;	
            Stop_Data_Valid_1_1_r       <= Stop_Data_Valid_1_1;
            Stop_Counter_Period_1_2_r   <= Stop_Counter_Period_1_2;
            Stop_Phase_Value_1_2_r      <= Stop_Phase_Value_1_2;	
            Stop_Data_Valid_1_2_r       <= Stop_Data_Valid_1_2;
            Stop_Counter_Period_1_3_r   <= Stop_Counter_Period_1_3;
            Stop_Phase_Value_1_3_r      <= Stop_Phase_Value_1_3;	
            Stop_Data_Valid_1_3_r       <= Stop_Data_Valid_1_3;
            Stop_Counter_Period_1_4_r   <= Stop_Counter_Period_1_4;
            Stop_Phase_Value_1_4_r      <= Stop_Phase_Value_1_4;	
            Stop_Data_Valid_1_4_r       <= Stop_Data_Valid_1_4;		      
	      end
		   else
		      begin
           Stop_Counter_Period_1_1_r   <= Stop_Counter_Period_delay_1_1;
            Stop_Phase_Value_1_1_r      <= 4'd0;	
            Stop_Data_Valid_1_1_r       <= Stop_Data_Valid_delay_1_1;
            Stop_Counter_Period_1_2_r   <= Stop_Counter_Period_delay_1_1;
            Stop_Phase_Value_1_2_r      <= 4'd0;		
            Stop_Data_Valid_1_2_r       <= Stop_Data_Valid_delay_1_1;
            Stop_Counter_Period_1_3_r   <= Stop_Counter_Period_delay_1_1;
            Stop_Phase_Value_1_3_r      <= 4'd0;		
            Stop_Data_Valid_1_3_r       <= Stop_Data_Valid_delay_1_1;
            Stop_Counter_Period_1_4_r   <= Stop_Counter_Period_delay_1_1;
            Stop_Phase_Value_1_4_r      <= 4'd0;		
            Stop_Data_Valid_1_4_r       <= Stop_Data_Valid_delay_1_1;		      
       		      
		    end

	    if(Spd_Delay_flag2_r1 == 1'b1)
		      begin
            Stop_Counter_Period_2_1_r   <= Stop_Counter_Period_2_1;
            Stop_Phase_Value_2_1_r      <= Stop_Phase_Value_2_1;	
            Stop_Data_Valid_2_1_r       <= Stop_Data_Valid_2_1;
            Stop_Counter_Period_2_2_r   <= Stop_Counter_Period_2_2;
            Stop_Phase_Value_2_2_r      <= Stop_Phase_Value_2_2;	
            Stop_Data_Valid_2_2_r       <= Stop_Data_Valid_2_2;
            Stop_Counter_Period_2_3_r   <= Stop_Counter_Period_2_3;
            Stop_Phase_Value_2_3_r      <= Stop_Phase_Value_2_3;	
            Stop_Data_Valid_2_3_r       <= Stop_Data_Valid_2_3;
            Stop_Counter_Period_2_4_r   <= Stop_Counter_Period_2_4;
            Stop_Phase_Value_2_4_r      <= Stop_Phase_Value_2_4;	
            Stop_Data_Valid_2_4_r       <= Stop_Data_Valid_2_4;		       
		      end
		   else
		      begin
            Stop_Counter_Period_2_1_r   <= Stop_Counter_Period_delay_2_1;
            Stop_Phase_Value_2_1_r      <= 4'd0;	
            Stop_Data_Valid_2_1_r       <= Stop_Data_Valid_delay_2_1;
            Stop_Counter_Period_2_2_r   <= Stop_Counter_Period_delay_2_1;
            Stop_Phase_Value_2_2_r      <= 4'd0;		
            Stop_Data_Valid_2_2_r       <= Stop_Data_Valid_delay_2_1;
            Stop_Counter_Period_2_3_r   <= Stop_Counter_Period_delay_2_1;
            Stop_Phase_Value_2_3_r      <= 4'd0;		
            Stop_Data_Valid_2_3_r       <= Stop_Data_Valid_delay_2_1;
            Stop_Counter_Period_2_4_r   <= Stop_Counter_Period_delay_2_1;
            Stop_Phase_Value_2_4_r      <= 4'd0;		
            Stop_Data_Valid_2_4_r       <= Stop_Data_Valid_delay_2_1;		           		  
		    end
	   end



always@(posedge Sys_Clk or negedge Reset)
    if(Reset)
        begin
       
        
            trig_flag1                  <= 1'b0;
            trig_flag2                  <= 1'b0;
            trig_flag3                  <= 1'b0;
            trig_flag4                  <= 1'b0; 
            Trig1_1_r                   <= 22'd0;
            Trig1_2_r                   <= 22'd0;
            Trig1_3_r                   <= 22'd0;
            Trig1_4_r                   <= 22'd0;
            
            Trig1_1_r_fine              <= 4'd0;
            Trig1_2_r_fine              <= 4'd0;
            Trig1_3_r_fine              <= 4'd0;
            Trig1_4_r_fine              <= 4'd0;         
  
            Trig1_data_r                <= 24'd0;
            Trig1_data_r_fine           <= 6'd0;
            Trig1_data_valid_r          <= 1'b0;              
        end
    else
        begin
       
        
        
        if(Trig_Data_Valid_1_1_r == 1'b1)
            begin
                trig_flag1              <= 1'b1;
                Trig1_1_r               <= Trig_Counter_Period_1_1_r;
                Trig1_1_r_fine          <= Trig_Phase_Value_1_1_r;
            end

            
         if(Trig_Data_Valid_1_2_r == 1'b1)
            begin
                trig_flag2              <= 1'b1;
                Trig1_2_r               <= Trig_Counter_Period_1_2_r;
                Trig1_2_r_fine          <= Trig_Phase_Value_1_2_r;
            end

            
         if(Trig_Data_Valid_1_3_r == 1'b1)
            begin
                trig_flag3              <= 1'b1;
                Trig1_3_r               <= Trig_Counter_Period_1_3_r;
                Trig1_3_r_fine          <= Trig_Phase_Value_1_3_r;
            end

            
         if(Trig_Data_Valid_1_4_r == 1'b1)
            begin
                trig_flag4              <= 1'b1;
                Trig1_4_r               <= Trig_Counter_Period_1_4_r;
                Trig1_4_r_fine          <= Trig_Phase_Value_1_4_r;              
            end
 
        if((trig_flag1 == 1'b1)&& (trig_flag2 == 1'b1)&&(trig_flag3 == 1'b1)&&(trig_flag4 == 1'b1))
            begin
                trig_flag1              <= 1'b0;
                trig_flag2              <= 1'b0;
                trig_flag3              <= 1'b0;
                trig_flag4              <= 1'b0;
                Trig1_data_r            <= Trig1_1_r + Trig1_2_r + Trig1_3_r + Trig1_4_r;
                Trig1_data_r_fine       <= Trig1_1_r_fine + Trig1_2_r_fine + Trig1_3_r_fine + Trig1_4_r_fine;
                Trig1_data_valid_r      <= 1'b1;  
            end
        else
            begin
  
                Trig1_data_valid_r      <= 1'b0;                             
            end

        end


always@(posedge Sys_Clk or negedge Reset)
    if(Reset)
        begin
    
        
            stop1_flag1                  <= 1'b0;
            stop1_flag2                  <= 1'b0;
            stop1_flag3                  <= 1'b0;
            stop1_flag4                  <= 1'b0;   
            Stop1_1_r                   <= 22'd0;
            Stop1_2_r                   <= 22'd0;
            Stop1_3_r                   <= 22'd0;
            Stop1_4_r                   <= 22'd0;   
            Stop1_1_r_fine                   <= 6'd0;
            Stop1_2_r_fine                   <= 6'd0;
            Stop1_3_r_fine                   <= 6'd0;
            Stop1_4_r_fine                   <= 6'd0;             
            
            Stop1_data_r                <= 24'd0;
            Stop1_data_r_fine                <= 6'd0;           
            Stop1_data_valid_r          <= 1'b0;              
        end
    else
        begin
       

        
        if(Stop_Data_Valid_1_1_r == 1'b1)
            begin
                stop1_flag1              <= 1'b1;
                Stop1_1_r               <= Stop_Counter_Period_1_1_r;
                Stop1_1_r_fine         <= Stop_Phase_Value_1_1_r;
            end
  
            
         if(Stop_Data_Valid_1_2_r == 1'b1)
            begin
                stop1_flag2              <= 1'b1;
                Stop1_2_r               <= Stop_Counter_Period_1_2_r;
                Stop1_2_r_fine         <= Stop_Phase_Value_1_2_r;              
            end

            
         if(Stop_Data_Valid_1_3_r == 1'b1)
            begin
                stop1_flag3              <= 1'b1;
                Stop1_3_r               <= Stop_Counter_Period_1_3_r;
                Stop1_3_r_fine         <= Stop_Phase_Value_1_3_r;                   
            end

            
         if(Stop_Data_Valid_1_4_r == 1'b1)
            begin
                stop1_flag4              <= 1'b1;
                Stop1_4_r               <= Stop_Counter_Period_1_4_r;
                Stop1_4_r_fine         <= Stop_Phase_Value_1_4_r;                       
            end
    
        if((stop1_flag1 == 1'b1)&& (stop1_flag2 == 1'b1)&&(stop1_flag3 == 1'b1)&&(stop1_flag4 == 1'b1))
            begin
                stop1_flag1              <= 1'b0;
                stop1_flag2              <= 1'b0;
                stop1_flag3              <= 1'b0;
                stop1_flag4              <= 1'b0;
                Stop1_data_r             <= Stop1_1_r + Stop1_2_r + Stop1_3_r + Stop1_4_r;
                Stop1_data_r_fine        <= Stop1_1_r_fine + Stop1_2_r_fine + Stop1_3_r_fine + Stop1_4_r_fine;                
                Stop1_data_valid_r       <= 1'b1;  
            end
        else
            begin
    
                Stop1_data_valid_r      <= 1'b0;                             
            end

        end

always@(posedge Sys_Clk or negedge Reset)
    if(Reset)
        begin
      
        
            stop2_flag1                  <= 1'b0;
            stop2_flag2                  <= 1'b0;
            stop2_flag3                  <= 1'b0;
            stop2_flag4                  <= 1'b0;   
            Stop2_1_r                   <= 22'd0;
            Stop2_2_r                   <= 22'd0;
            Stop2_3_r                   <= 22'd0;
            Stop2_4_r                   <= 22'd0;
            Stop2_1_r_fine                   <= 6'd0;
            Stop2_2_r_fine                   <= 6'd0;
            Stop2_3_r_fine                   <= 6'd0;
            Stop2_4_r_fine                   <= 6'd0;   
            Stop2_data_r                <= 24'd0;
            Stop2_data_r_fine                <= 6'd0;            
            Stop2_data_valid_r          <= 1'b0;              
        end
    else
        begin
  
        
        
        if(Stop_Data_Valid_2_1_r == 1'b1)
            begin
                stop2_flag1              <= 1'b1;
                Stop2_1_r               <= Stop_Counter_Period_2_1_r;
                Stop2_1_r_fine          <= Stop_Phase_Value_2_1_r;                
            end

            
         if(Stop_Data_Valid_2_2_r == 1'b1)
            begin
                stop2_flag2              <= 1'b1;
                Stop2_2_r               <= Stop_Counter_Period_2_2_r;
                Stop2_2_r_fine          <= Stop_Phase_Value_2_2_r;                 
            end

            
         if(Stop_Data_Valid_2_3_r == 1'b1)
            begin
                stop2_flag3              <= 1'b1;
                Stop2_3_r               <= Stop_Counter_Period_2_3_r;
               Stop2_3_r_fine          <= Stop_Phase_Value_2_3_r;                 
            end

            
         if(Stop_Data_Valid_2_4_r == 1'b1)
            begin
                stop2_flag4              <= 1'b1;
                Stop2_4_r               <= Stop_Counter_Period_2_4_r;
               Stop2_4_r_fine          <= Stop_Phase_Value_2_4_r;                  
            end

        if((stop2_flag1 == 1'b1)&& (stop2_flag2 == 1'b1)&&(stop2_flag3 == 1'b1)&&(stop2_flag4 == 1'b1))
            begin
                stop2_flag1              <= 1'b0;
                stop2_flag2              <= 1'b0;
                stop2_flag3              <= 1'b0;
                stop2_flag4              <= 1'b0;
                Stop2_data_r            <= Stop2_1_r + Stop2_2_r + Stop2_3_r + Stop2_4_r;
                Stop2_data_r_fine         <= Stop2_1_r_fine + Stop2_2_r_fine + Stop2_3_r_fine + Stop2_4_r_fine;                
                Stop2_data_valid_r      <= 1'b1;  
            end
        else
            begin  
                Stop2_data_valid_r      <= 1'b0;                             
            end

        end
always@(posedge Sys_Clk or negedge Reset)
   if(Reset)
       begin
            Sync_data                   <= 28'd0;
            Sync_data_Valid             <= 1'b0;
            Spd1_Stop_data              <= 28'd0;
            Spd1_Stop_data_Valid        <= 1'b0;
            Spd2_Stop_data              <= 28'd0;
            Spd2_Stop_data_Valid        <= 1'b0;  
            
            Sync_data_fine              <= 6'd0;
            Spd1_Stop_data_fine         <= 6'd0;
            Spd2_Stop_data_fine         <= 6'd0;                    
       end
   else
       begin
            Sync_data                   <= {Trig1_data_r,4'd0};
            Sync_data_Valid             <= Trig1_data_valid_r;
            Spd1_Stop_data              <= {Stop1_data_r,4'd0};
            Spd1_Stop_data_Valid        <= Stop1_data_valid_r;
            Spd2_Stop_data              <= {Stop2_data_r,4'd0};
            Spd2_Stop_data_Valid        <= Stop2_data_valid_r;      
            
            Sync_data_fine                   <= Trig1_data_r_fine;
            Spd1_Stop_data_fine              <= Stop1_data_r_fine;
            Spd2_Stop_data_fine              <= Stop2_data_r_fine;                
       end        
  
        
    always@(posedge Sys_Clk or negedge Reset)
        if(Reset)
            begin
                TDC_test_flag_r         <= 1'b0;
                TDC_test_flag_r1        <= 1'b0;
                fms_data                <= 2'd0;
                Timestamp_DATA          <= 32'd0;
                Timestamp_DATA_Valid    <= 1'b0;
                Stop2_data              <= 24'd0;
                Stop2_data_valid        <= 1'b0;   
                Stop1_data              <= 24'd0;
                Stop1_data_valid        <= 1'b0;  
                Trig1_data              <= 24'd0;
                Trig1_data_valid        <= 1'b0; 
                data_reg                <= 32'd0;                                               
            end
        else
            begin
                TDC_test_flag_r         <= TDC_test_flag;
                TDC_test_flag_r1        <= TDC_test_flag_r;
                
                

                
                if(Trig1_data_valid_r == 1'b1)  
                    begin
                        Trig1_data               <= Trig1_data_r;
                        Trig1_data_fine          <= Trig1_data_r_fine;
                        Trig1_data_valid         <= 1'b1; 
                    end
                else
                    begin
                        Trig1_data_valid          <= Trig1_data_valid;      
                    end   
                       
                 if(Stop1_data_valid_r == 1'b1)  
                    begin
                         Stop1_data               <= Stop1_data_r;
                         Stop1_data_fine          <= Stop1_data_r_fine;                        
                        Stop1_data_valid         <= 1'b1; 
                    end
                else
                    begin
                        Stop1_data_valid          <= Stop1_data_valid;      
                    end                     
                                   
                 if(Stop2_data_valid_r == 1'b1)  
                    begin
                        Stop2_data               <= Stop2_data_r;
                        Stop2_data_fine          <= Stop2_data_r_fine;                       
                        Stop2_data_valid         <= 1'b1; 
                    end
                else
                    begin
                        Stop2_data_valid          <= Stop2_data_valid;      
                    end   
                if(TDC_test_flag_r1 == 1'b0)
                    begin
                        fms_data                      <= 2'd0;
                        Timestamp_DATA              <= 32'd0;
                        Timestamp_DATA_Valid        <= 1'b0;                    
                    end
                else
                    case(fms_data)
                2'd0:
                    begin
                        if(TDC_test_flag_r1 == 1'b1)
                            fms_data              <= 2'd1;
                        else
                            fms_data              <= 2'd0;
                    end
               2'd1:
                    begin
                          Timestamp_DATA_Valid            <= 1'b0;                       
                         if(Trig1_data_valid == 1'b1)
                            begin
                                Trig1_data_valid                <= 1'b0;
                                fms_data                        <= 2'd2;
                                data_reg                        <= {2'b00,Trig1_data,Trig1_data_fine};
                                Timestamp_DATA                  <= 32'hEB90B712;
                                 Timestamp_DATA_Valid           <= 1'b1;
                            end
                        else if(Stop1_data_valid == 1'b1)
                            begin
                                Stop1_data_valid                <= 1'b0;
                                fms_data                        <= 3'd2;
                                data_reg                        <= {2'b01,Stop1_data,Stop1_data_fine};                                
                            end
                         else if(Stop2_data_valid == 1'b1)
                            begin
                                Stop2_data_valid                <= 1'b0;
                                fms_data                        <= 3'd2;
                                data_reg                        <= {2'b10,Stop2_data,Stop2_data_fine};                                    
                            end                          
                         else
                            begin
                                fms_data                        <= 3'd1;   
                              
                             end                      
                    end    
                2'd2:
                    begin
                        Timestamp_DATA              <= data_reg;
                        Timestamp_DATA_Valid        <= 1'b1;  
                        fms_data                     <= 2'd1;   
                        
                        
                                           
                    end
                default:
                    begin
                    end
                endcase
            end

endmodule
