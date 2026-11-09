`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/25 19:39:01
// Design Name: 
// Module Name: Conforms_Counting_mode
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


module Conforms_Counting_mode(Sync_data_Valid,Spd1_Stop_data,Spd1_Stop_data_Valid,Spd2_Stop_data,Spd2_Stop_data_Valid,
Sys_Clk,Reset,Start_stop_flag,Conforms_Counting_Sync_Time,Conforms_Counting_PW,Conforms_Counting_flag
,Conforms_Counting_data_1,Conforms_Counting_data_Valid_1,Conforms_Counting_data_2,Conforms_Counting_data_Valid_2,
Conforms_Counting_mode_1,Conforms_Counting_mode_2,Spd1_Stop_data_fine,Spd2_Stop_data_fine
    );

input                                    Sync_data_Valid;
input[27:0]                              Spd1_Stop_data;
input                                    Spd1_Stop_data_Valid;
input[27:0]                              Spd2_Stop_data;
input                                    Spd2_Stop_data_Valid;

input[15:0]                              Conforms_Counting_Sync_Time;
input[15:0]                              Conforms_Counting_PW;
input                                   Conforms_Counting_flag;

input                                   Conforms_Counting_mode_1;
input                                   Conforms_Counting_mode_2;

input                                   Sys_Clk;
input                                   Reset; 
input                                   Start_stop_flag;
input[5:0]                            Spd1_Stop_data_fine;
input[5:0]                            Spd2_Stop_data_fine;

output[31:0]                            Conforms_Counting_data_1;
output                                  Conforms_Counting_data_Valid_1;            

reg[31:0]                              Conforms_Counting_data_1;
reg                                    Conforms_Counting_data_Valid_1;    

output[31:0]                            Conforms_Counting_data_2;
output                                  Conforms_Counting_data_Valid_2;            

reg[31:0]                              Conforms_Counting_data_2;
reg                                    Conforms_Counting_data_Valid_2;    



  
    
 //stop2-stop1
reg[1:0]                      			fms_tdc1;
reg       	                            Start_stop_flag_r;
reg                                     Start_stop_flag_r1;
reg                                     Sync_data_Valid_r;
reg                                     Sync_data_Valid_r1;



reg                                     sync_start_flag;
reg                                     sync_start_flag_r;
reg                                     sync_stop_flag;
reg                                     sync_stop_flag_r;
reg[1:0]                                fms_sync;
reg[15:0]                               cnt_Conforms_Counting_Sync_Time;
reg[15:0]                               cnt_Conforms_Counting_PW;

reg[27:0]                              Spd1_Stop_data_rx;
reg[5:0]                               Spd1_Stop_data_fine_rx;
reg                                    Spd1_Stop_data_Valid_rx;
reg[27:0]                              Spd2_Stop_data_rx;
reg[5:0]                               Spd2_Stop_data_fine_rx;
reg                                    Spd2_Stop_data_Valid_rx;

reg[27:0]                              Spd1_Stop_data_rx1;
reg[5:0]                               Spd1_Stop_data_fine_rx1;
reg                                    Spd1_Stop_data_Valid_rx1;
reg[27:0]                              Spd2_Stop_data_rx1;
reg[5:0]                               Spd2_Stop_data_fine_rx1;
reg                                    Spd2_Stop_data_Valid_rx1;

reg[27:0]                              Spd1_Stop_data_rx2;
reg[5:0]                               Spd1_Stop_data_fine_rx2;
reg                                    Spd1_Stop_data_Valid_rx2;
reg[27:0]                              Spd2_Stop_data_rx2;
reg[5:0]                               Spd2_Stop_data_fine_rx2;
reg                                    Spd2_Stop_data_Valid_rx2;






reg[15:0]                              Conforms_Counting_Sync_Time_r;
reg[15:0]                              Conforms_Counting_PW_r;

reg[15:0]                              Conforms_Counting_Sync_Time_r1;
reg[15:0]                              Conforms_Counting_PW_r1;
always@(posedge Sys_Clk or negedge Reset)
	if(Reset == 1'b1)
		begin
		  sync_start_flag                       <= 1'b0;
		  sync_start_flag_r                     <= 1'b0;
		  sync_stop_flag                        <= 1'b0;
		  sync_stop_flag_r                      <= 1'b0;
		  Start_stop_flag_r                     <= 1'b0;
		  Start_stop_flag_r1                    <= 1'b0;
		  fms_sync                              <= 2'd0;
		  cnt_Conforms_Counting_Sync_Time       <= 16'd0;
		  cnt_Conforms_Counting_PW              <= 16'd0;
		  Sync_data_Valid_r                     <= 1'b0;
		  Sync_data_Valid_r1                    <= 1'b0;
		  
          Spd1_Stop_data_rx                      <= 28'd0;
          Spd1_Stop_data_fine_rx                 <= 6'd0;
          Spd1_Stop_data_Valid_rx                <= 1'b0;
          Spd2_Stop_data_rx                      <= 30'd0;
          Spd2_Stop_data_fine_rx                 <= 6'd0;          
          Spd2_Stop_data_Valid_rx                <= 1'b0;		  
		  
          Spd1_Stop_data_rx1                      <= 28'd0;
         Spd1_Stop_data_fine_rx1                 <= 6'd0;
          Spd1_Stop_data_Valid_rx1                <= 1'b0;
          Spd2_Stop_data_rx1                      <= 28'd0;
         Spd2_Stop_data_fine_rx1                 <= 6'd0;
          Spd2_Stop_data_Valid_rx1                <= 1'b0;	
          
           Spd1_Stop_data_rx2                      <= 28'd0;
           Spd1_Stop_data_fine_rx2                  <= 6'd0;
          Spd1_Stop_data_Valid_rx2                <= 1'b0;
          Spd2_Stop_data_rx2                      <= 28'd0;
          Spd2_Stop_data_fine_rx2                  <= 6'd0;
          Spd2_Stop_data_Valid_rx2                <= 1'b0;	         
     
          Conforms_Counting_Sync_Time_r           <= 16'd0;
         Conforms_Counting_PW_r                  <= 16'd0;
          Conforms_Counting_Sync_Time_r1           <= 16'd0;
         Conforms_Counting_PW_r1                  <= 16'd0;          	  
		end
    else
        begin
  
          Conforms_Counting_Sync_Time_r           <= Conforms_Counting_Sync_Time;
         Conforms_Counting_PW_r                  <= Conforms_Counting_PW;
          Conforms_Counting_Sync_Time_r1           <= Conforms_Counting_Sync_Time_r;
         Conforms_Counting_PW_r1                  <= Conforms_Counting_PW_r;       
  
  
        
          Spd1_Stop_data_rx                      <= Spd1_Stop_data;
          Spd1_Stop_data_fine_rx                 <= Spd1_Stop_data_fine;
          Spd1_Stop_data_Valid_rx                <= Spd1_Stop_data_Valid;
          Spd2_Stop_data_rx                      <= Spd2_Stop_data;
          Spd2_Stop_data_fine_rx                 <= Spd2_Stop_data_fine;         
          Spd2_Stop_data_Valid_rx                <= Spd2_Stop_data_Valid;		  
		  
          Spd1_Stop_data_rx1                      <= Spd1_Stop_data_rx;
          Spd1_Stop_data_fine_rx1                 <= Spd1_Stop_data_fine_rx;
          Spd1_Stop_data_Valid_rx1                <= Spd1_Stop_data_Valid_rx;
          Spd2_Stop_data_rx1                      <= Spd2_Stop_data_rx;
          Spd2_Stop_data_fine_rx1                 <= Spd2_Stop_data_fine_rx;
          Spd2_Stop_data_Valid_rx1                <= Spd2_Stop_data_Valid_rx;	     
 
           Spd1_Stop_data_rx2                      <= Spd1_Stop_data_rx1;
          Spd1_Stop_data_fine_rx2                 <= Spd1_Stop_data_fine_rx1;
          Spd1_Stop_data_Valid_rx2                <= Spd1_Stop_data_Valid_rx1;
          Spd2_Stop_data_rx2                      <= Spd2_Stop_data_rx1;
          Spd2_Stop_data_fine_rx2                 <= Spd2_Stop_data_fine_rx1;         
          Spd2_Stop_data_Valid_rx2                <= Spd2_Stop_data_Valid_rx1;	
        
        
            Sync_data_Valid_r                   <= Sync_data_Valid;
            Sync_data_Valid_r1                  <= Sync_data_Valid_r;
            
        	Start_stop_flag_r			        <= Start_stop_flag;
			Start_stop_flag_r1			        <= Start_stop_flag_r;
			
            sync_start_flag_r                    <= sync_start_flag;
            sync_stop_flag_r                     <= sync_stop_flag;
            if(Start_stop_flag_r1 == 1'b0)
                begin
                    fms_sync                     <= 2'd0;
                    
                end
            else
                begin
            if(Conforms_Counting_flag == 1'b0)
                begin
                    sync_stop_flag              <= Sync_data_Valid;
                    sync_start_flag             <= sync_stop_flag_r;
                end
            else
                begin
                    case(fms_sync)
                 2'd0:
                    begin
                        sync_start_flag         <= 1'b0;
                        sync_stop_flag          <= 1'b0;
                        if((Sync_data_Valid_r == 1'b1) && (Sync_data_Valid_r1 == 1'b0))
                            fms_sync             <= 2'd1;
                        else
                            fms_sync             <= 2'd0;
                    end
                  2'd1:
                    begin
                        if(cnt_Conforms_Counting_Sync_Time == Conforms_Counting_Sync_Time_r1)
                            begin
                                cnt_Conforms_Counting_Sync_Time <= 16'd0;
                                fms_sync                        <= 2'd2;
                                sync_start_flag                 <= 1'b1;
                            end
                         else
                            begin
                                cnt_Conforms_Counting_Sync_Time <= cnt_Conforms_Counting_Sync_Time + 16'd1;
                                fms_sync                        <= 2'd1;
                                sync_start_flag                 <= 1'b0;
                            end
                    end
                  2'd2:
                    begin
                           sync_start_flag                 <= 1'b0;
                          if(cnt_Conforms_Counting_PW == Conforms_Counting_PW_r1)
                            begin
                                cnt_Conforms_Counting_PW        <= 16'd0;
                                fms_sync                        <= 2'd0;
                                sync_stop_flag                  <= 1'b1;
                            end
                         else
                            begin
                                cnt_Conforms_Counting_PW <= cnt_Conforms_Counting_PW + 16'd1;
                                fms_sync                        <= 2'd2;
                                sync_stop_flag                 <= 1'b0;
                            end                      
                    end
                  default:
                    begin
                    end
                  endcase
                end
                end
        end

reg[29:0]           Spd_data;
reg                 Spd_data_Valid;    
reg[27:0]                              Spd1_Stop_data_r;
reg[5:0]                               Spd1_Stop_data_r_fine;
reg                                    Spd1_Stop_data_Valid_r;
reg[27:0]                              Spd2_Stop_data_r;
reg[5:0]                              Spd2_Stop_data_r_fine;
reg                                    Spd2_Stop_data_Valid_r;
reg                                    Spd2_Stop_data_Valid_x; 
reg[27:0]                              Spd2_Stop_data_x;
reg[5:0]                              Spd2_Stop_data_x_fine;
always@(posedge Sys_Clk or negedge Reset)
	if(Reset == 1'b1)
		begin	
			fms_tdc1					<= 2'd3;
            Spd_data_Valid              <= 1'b0;
            Spd_data                    <= 30'd0;
            Spd1_Stop_data_r            <= 28'd0;
            Spd1_Stop_data_r_fine            <= 6'd0;            
            Spd1_Stop_data_Valid_r      <= 1'b0;
            Spd2_Stop_data_r            <= 28'd0;
            Spd2_Stop_data_r_fine            <= 6'd0;            
            Spd2_Stop_data_Valid_r      <= 1'b0;  
            Spd2_Stop_data_Valid_x      <= 1'b0;  
            Spd2_Stop_data_x            <= 28'd0;   
             Spd2_Stop_data_x_fine            <= 6'd0;                
		end
	else
		begin


		
			if((Start_stop_flag_r1 == 1'b0) ||((sync_stop_flag == 1'b1) && (sync_stop_flag_r == 1'b0)))
				begin
					fms_tdc1			<= 2'd3;
				end
			else
				begin	
					case(fms_tdc1)//开始测量
			    2'd3:
			      begin
			        if(sync_start_flag == 1'b1)//比上面晚一个周期
			             fms_tdc1                <= 2'd0;
			        else
			             fms_tdc1                <= 2'd3;
			      end
				2'd0:
					begin
				    	 Spd_data_Valid                	    <= 1'b0;
						if(Spd1_Stop_data_Valid_rx2 == 1'b1)//
							begin
								fms_tdc1					<= 2'd1;
								Spd1_Stop_data_r	        <= Spd1_Stop_data_rx2;
								Spd1_Stop_data_r_fine	        <= Spd1_Stop_data_fine_rx2;								
								if(Spd2_Stop_data_Valid_rx2 == 1'b1)
								    begin
								    Spd2_Stop_data_x        <= Spd2_Stop_data_rx2;
								    Spd2_Stop_data_x_fine        <= Spd2_Stop_data_fine_rx2;								    
								    Spd2_Stop_data_Valid_x  <= 1'b1;
								    end
								 else
								    begin
								    Spd2_Stop_data_Valid_x  <= 1'b0;
								    end
							end
						else
							begin
								fms_tdc1	               <= 2'd0;	
								 Spd2_Stop_data_Valid_x    <= 1'b0;							
							end
					end
				2'd1:
					begin
			          if(Spd2_Stop_data_Valid_rx2 == 1'b1)	
						 begin     					
							  fms_tdc1				    	<= 2'd2;
							  Spd2_Stop_data_r              <= Spd2_Stop_data_rx2;
							  Spd2_Stop_data_r_fine              <= Spd2_Stop_data_fine_rx2;							  
					     end
					 else if(Spd2_Stop_data_Valid_x == 1'b1)					   
					     begin
					       Spd2_Stop_data_r                <= Spd2_Stop_data_x;
						  Spd2_Stop_data_r_fine                <= Spd2_Stop_data_x_fine;				       
					        fms_tdc1				    	<= 2'd2;
					     end
			          else	
							  fms_tdc1						<= 2'd1;				
					end
				2'd2:
					begin//  ?  2   ??? 
						Spd_data_Valid				        <= 1'b1;
						fms_tdc1							<= 2'd0;	
						if(Spd2_Stop_data_r < Spd1_Stop_data_r)		
						  Spd_data                            <= 32'd0;						
						else						
						Spd_data						<= Spd2_Stop_data_r - Spd1_Stop_data_r + Spd1_Stop_data_r_fine - Spd2_Stop_data_r_fine;													

					end			
				default:
					begin
					end
				endcase
				end
		end
 




reg[31:0]                               data_reg;
reg[2:0]                                fms_data;
    always@(posedge Sys_Clk or negedge Reset)
        if(Reset)
            begin    
                 fms_data                      <= 3'd0;
                 Conforms_Counting_data_1      <= 32'd0;
                 Conforms_Counting_data_Valid_1 <= 1'b0;    
                 Conforms_Counting_data_2       <= 32'd0;
                 Conforms_Counting_data_Valid_2 <= 1'b0;               
                 data_reg                      <= 32'd0;                                               
            end
        else
            begin
             
                 Conforms_Counting_data_1      <= {2'b0,Spd_data};
                 Conforms_Counting_data_Valid_1 <= Spd_data_Valid;    
    
        
                
            
                if(Start_stop_flag_r1 == 1'b0)
                    begin
                        fms_data                      <= 3'd0;                  
                    end
                else
                    case(fms_data)
                3'd0:
                    begin
                        if(Start_stop_flag_r1 == 1'b1)
                            fms_data              <= 3'd1;
                        else
                            fms_data              <= 3'd0;
                    end
               3'd1:
                    begin
                      
                         if(Spd_data_Valid == 1'b1)
                            begin
                                 Conforms_Counting_data_Valid_2         <= 1'b1;  
                                 fms_data                               <= 3'd2;
                                 Conforms_Counting_data_2               <= 32'hEB90B713;
                                 data_reg                               <= {2'b0,Spd_data};
                            end
                         
                         else
                            begin
                                fms_data            <= 3'd1;   
                                 Conforms_Counting_data_Valid_2 <= 1'b0;  
                            end                       
                    end
                3'd2:
                    begin
                   
                        Conforms_Counting_data_Valid_2           <= 1'b1; 
                         Conforms_Counting_data_2               <= data_reg; 
                        fms_data                                 <= 3'd1;                         
                    end

                default:
                    begin
                    end
                endcase
            end




	
endmodule
