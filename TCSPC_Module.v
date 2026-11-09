`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/07 08:54:48
// Design Name: 
// Module Name: TCSPC_Module
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


module TCSPC_Module(Sys_Clk,Reset,Start_stop_flag,acc_time_done,
TDC_Data,TDC_Data_Valid,data_tcspc,data_tcspc_valid,tcspc_acc_num,tscpc_mode
    );
input										Sys_Clk;
input										Reset;	
input                                       tscpc_mode;
input                                       Start_stop_flag;
input										acc_time_done;
input[11:0]                                 TDC_Data;
input                                       TDC_Data_Valid;             
input[15:0]									tcspc_acc_num;
output[15:0]                                data_tcspc;
output                                      data_tcspc_valid;  
reg[15:0]                                   data_tcspc;
reg                                         data_tcspc_valid;  

reg                                         data_tcspc_valid_r;
reg                                         data_tcspc_valid_r1;


reg[15:0]                                   TDC_Data_TCSPC_1;
reg                                         TDC_Data_TCSPC_Valid_1;
reg                                         TDC_Data_TCSPC_Valid_1_r;
reg[15:0]                                   TDC_Data_TCSPC_2;
reg                                         TDC_Data_TCSPC_Valid_2; 
reg                                         TDC_Data_TCSPC_Valid_2_r;
reg                                         ram_ena_1;
reg                                         ram_wea_1;
reg[11:0]                                   ram_addra_1;
reg[15:0]                                   ram_dina_1;
reg                                         ram_enb_1;
reg                                         ram_enb_1_x;
reg                                         ram_enb_1_x1;

reg                                         ram_enb_2_x;
reg                                         ram_enb_2_x1;
reg[11:0]                                   ram_addrb_1;
wire[15:0]                                  ram_doutb_1; 

 
reg                                         ram_enb_r_1_r;
  
reg                                         ram_enb_1_r1;

 (*Mark_debug="TRUE"*)reg[3:0]                                    fms_stop_ram_1;  
reg[11:0]                                   ram_addrb_1_r;
reg[11:0]                                   ram_addra_1_r;

reg                                     ram_ena_2;
reg                                     ram_wea_2;
reg[11:0]                               ram_addra_2;
reg[15:0]                               ram_dina_2;
reg                                     ram_enb_2;
reg[11:0]                               ram_addrb_2;
wire[15:0]                              ram_doutb_2; 

  
reg                                     ram_enb_r_2_r;

reg                                     ram_enb_2_r1;

 (*Mark_debug="TRUE"*)reg[3:0]                                fms_stop_ram_2;  
reg[11:0]                               ram_addrb_2_r;
reg[11:0]                               ram_addra_2_r;


reg										test_flag_r;
reg										test_flag_r1;
reg[2:0]                                fms_start;
 (*Mark_debug="TRUE"*)reg                                     Start_flag1;
 (*Mark_debug="TRUE"*)reg                                     Start_flag2;
reg                                     Start_flag1_r;
reg                                     Start_flag2_r;

reg                                     ram_enb1;
reg                                     ram_enb2;
reg                                     read_data_flag;

reg[11:0]								  mcs_Time_scale_ra1;
reg[11:0]								  mcs_Time_scale_rb1;
reg[11:0]								  mcs_Time_scale_ra2;
reg[11:0]								  mcs_Time_scale_rb2;
reg[15:0]									tcspc_acc_num_r;
reg                                     ram1_flaga;
reg                                     ram2_flaga;
reg                                     ram1_flagb;
reg                                     ram2_flagb;
reg[15:0]                               ram_doutb_1_peak;
reg[15:0]                               ram_doutb_2_peak;
//tcspc_acc_num
reg                                     peak_flag1;
reg                                     peak_flag2;
always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1) 
        begin
            Start_flag1                 <= 1'b0;
            Start_flag2                 <= 1'b0;
            Start_flag1_r                 <= 1'b0;
            Start_flag2_r                 <= 1'b0;           
            fms_start                   <= 3'd0;
            test_flag_r                 <= 1'b0;
            test_flag_r1                <= 1'b0;
            tcspc_acc_num_r             <= 16'd0;
            ram_doutb_1_peak            <= 16'd0;
            ram_doutb_2_peak            <= 16'd0;
            peak_flag1                   <= 1'b0;
            peak_flag2                   <= 1'b0;
        end
    else
        begin
            ram_doutb_1_peak            <= ram_doutb_1;
            ram_doutb_2_peak            <= ram_doutb_2;
            test_flag_r               	<= Start_stop_flag;
            test_flag_r1               	<= test_flag_r;
			Start_flag1_r               <= Start_flag1;
			Start_flag2_r               <= Start_flag2;
			tcspc_acc_num_r             <= tcspc_acc_num;
			if((ram_doutb_1_peak == tcspc_acc_num_r) &&(tscpc_mode == 1'b0))
			     peak_flag1                   <= 1'b1;
			 else
			      peak_flag1                   <= 1'b0;
			      
			if((ram_doutb_2_peak == tcspc_acc_num_r) &&(tscpc_mode == 1'b0))
			     peak_flag2                   <= 1'b1;
			 else
			      peak_flag2                   <= 1'b0;			      
			      
			
	    if((test_flag_r == 1'b0) && (test_flag_r1==1'b1))//结束测量	
			begin
				fms_start				<= 3'd0;
				Start_flag1             <= 1'b0;//上升沿开姿
		        Start_flag2             <= 1'b0;//上升沿开姿
			end
		else
			begin
            case(fms_start)
                3'd0:
                  begin
                      if((test_flag_r == 1'b1) && (test_flag_r1 == 1'b0))//弿始测釿
                          begin
                              Start_flag1      <= 1'b1;//RAM1弿始测釿
                              fms_start        <= 3'd1;
                          end
                      else
                          begin
                              Start_flag1     <= 1'b0;
                              fms_start       <= 3'd0;
                          end
                      
                  end
				3'd1:
					begin
						Start_flag2      	  <= 1'b0;
						if ((acc_time_done == 1'b1)||(peak_flag1== 1'b1))
							begin
								Start_flag1   <= 1'b0;
								fms_start     <= 3'd2;
								
							end
						else
							begin
								Start_flag1	  <= 1'b1;
								fms_start     <= 3'd1;
							end
					end
				3'd2:
				    begin
				            if(acc_time_done ==1'b0)
				                 fms_start     <= 3'd3;
				            else
				             fms_start     <= 3'd2;
			        
				    end			
                3'd3:
                  begin
                      Start_flag1             <= 1'b0;
                      if ((acc_time_done == 1'b1)||(peak_flag2== 1'b1))
                          begin
                              Start_flag2      <= 1'b0;
                              fms_start        <= 3'd4;
                          end
                      else
                          begin
                              Start_flag2     <= 1'b1;
                              fms_start       <= 3'd3;
                          end
                  end
               3'd4:
                  begin
                       Start_flag2      <= 1'b0;
   				            if(acc_time_done ==1'b0)
				                 fms_start     <= 3'd1;
				            else
				             fms_start     <= 3'd4;
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
//笿1通道            
            ram_ena_1                         <= 1'b0;
            ram_wea_1                         <= 1'b0;
            ram_addra_1                       <= 12'd0;
            ram_dina_1                        <= 16'd0;
            ram_enb_1                         <= 1'b0;
            ram_addrb_1                        <= 12'd0;
  
            ram_enb_r_1_r                     <= 1'b0;
 
            ram_enb_1_r1                      <= 1'b0; 
            ram_enb_1_x                       <= 1'b0;
            ram_enb_1_x1                      <= 1'b0;      
            fms_stop_ram_1                    <= 4'd0;  
            ram_addrb_1_r                     <= 12'd0;
            ram_addra_1_r                     <= 12'd0;        
            ram_ena_2                         <= 1'b0;
            ram_wea_2                         <= 1'b0;
            ram_addra_2                       <= 12'd0;
            ram_dina_2                        <= 16'd0;
            ram_enb_2                         <= 1'b0;
            ram_addrb_2                       <= 12'd0;
  
            ram_enb_r_2_r                     <= 1'b0;
            ram_enb_2_r1                      <= 1'b0;      
            fms_stop_ram_2                    <= 4'd0;  
            ram_addrb_2_r                     <= 12'd0;
            ram_addra_2_r                     <= 12'd0;   
            ram_enb_2_x                       <= 1'b0;
            ram_enb_2_x1                      <= 1'b0;     
            TDC_Data_TCSPC_1                  <= 16'd0;
            TDC_Data_TCSPC_Valid_1            <= 1'b0;  
            TDC_Data_TCSPC_Valid_1_r            <= 1'b0;   
            TDC_Data_TCSPC_2                  <= 16'd0;
            TDC_Data_TCSPC_Valid_2            <= 1'b0;   
            TDC_Data_TCSPC_Valid_2_r            <= 1'b0;                       
            data_tcspc                        <= 16'd0;
            data_tcspc_valid                  <= 1'b0;   
            ram_enb1                          <= 1'b0;
            ram_enb2                          <= 1'b0;    
            read_data_flag                    <= 1'b0;           
            data_tcspc_valid_r                <= 1'b0;
            data_tcspc_valid_r1               <= 1'b0;   
         
            
            ram1_flaga                       <= 1'b0;
            ram2_flaga                       <= 1'b0; 
            ram1_flagb                      <= 1'b0;
            ram2_flagb                      <= 1'b0;
        end
     else
        begin

                 
                ram_enb_1_x                         <=  ram_enb1; 
                ram_enb_1_x1                        <= ram_enb_1_x;
                TDC_Data_TCSPC_Valid_1              <= ram_enb_1_x1;   
               TDC_Data_TCSPC_Valid_1_r             <= TDC_Data_TCSPC_Valid_1;  
              TDC_Data_TCSPC_1                    <= ram_doutb_1;
       //    TDC_Data_TCSPC_1                    <= 13'd1024;
                ram_enb_2_x                         <= ram_enb2;
                ram_enb_2_x1                        <= ram_enb_2_x;
                TDC_Data_TCSPC_Valid_2              <= ram_enb_2_x1; 
                TDC_Data_TCSPC_Valid_2_r            <= TDC_Data_TCSPC_Valid_2;

          TDC_Data_TCSPC_2                      <= ram_doutb_2;
            data_tcspc_valid_r                  <= data_tcspc_valid;
            data_tcspc_valid_r1                 <= data_tcspc_valid_r;



            if(read_data_flag == 1'b0)
                 begin
                    data_tcspc                       <= TDC_Data_TCSPC_1;
                    data_tcspc_valid                 <= TDC_Data_TCSPC_Valid_1_r; 
                end
           else
                begin
                    data_tcspc                       <= TDC_Data_TCSPC_2;
                    data_tcspc_valid                 <= TDC_Data_TCSPC_Valid_2_r; 
                end
            if(ram1_flaga == 1'b1)
                begin
                   if(ram_addra_1_r == 12'd4095)//长度
                         ram_addra_1_r             <= 12'd0;
                    else
                         ram_addra_1_r             <= ram_addra_1_r + 12'd1;  
                 end
            else
                 ram_addra_1_r                      <= 12'd0;
              
              if(ram2_flaga == 1'b1)
                begin
                   if(ram_addra_2_r == 12'd4095)//长度
                         ram_addra_2_r             <= 12'd0;
                    else
                         ram_addra_2_r             <= ram_addra_2_r + 12'd1;  
                 end
            else
                 ram_addra_2_r                      <= 12'd0;            
              
           if(ram1_flagb == 1'b1)
                 begin   
                       if(ram_addrb_1_r == 12'd4095)
						  ram_addrb_1_r             <= 12'd0;
                        else
						  ram_addrb_1_r             <= ram_addrb_1_r +  12'd1;
				  end
	       else
	           begin
	                 ram_addrb_1_r             <= 12'd0;
	           end            
             
            if(ram2_flagb == 1'b1)
                 begin   
                       if(ram_addrb_2_r == 12'd4095)
						  ram_addrb_2_r             <= 12'd0;
                        else
						  ram_addrb_2_r             <= ram_addrb_2_r +  12'd1;
				  end
	       else
	           begin
	                 ram_addrb_2_r             <= 12'd0;
	           end                
              
            if((test_flag_r == 1'b0) && (test_flag_r1==1'b1))//结束测量
                begin
                    fms_stop_ram_1            <= 4'd0;                  
                end
            else
                begin                                                  
                case(fms_stop_ram_1)
                4'd0:
                    begin   
                        ram_ena_1                         <= 1'b0;
                        ram_wea_1                         <= 1'b0;
                        ram_addra_1                       <= 12'd0;
                        ram_dina_1                        <= 16'd0;    
                        fms_stop_ram_1                    <= 4'd1;   
                        ram1_flaga                        <=1'b0;   
                        ram1_flagb                      <= 1'b0;                                   
                    end
                4'd1:  //复位，将RAM中的数据清零
                    begin
                        if(ram_addra_1_r == 12'd4095)//长度
                            fms_stop_ram_1            <= 4'd2; 
                        else
                              fms_stop_ram_1            <= 4'd1; 
                        ram_addra_1                       <= ram_addra_1_r;
                        ram_ena_1                         <= 1'b1;
                        ram_wea_1                         <= 1'b1;                         
                        ram_dina_1                        <= 16'd0;
                        ram1_flaga                        <= 1'b1;
                    end
                4'd2:
                    begin
                        ram1_flaga                        <= 1'b0;
                        if((Start_flag1 == 1'b1)&&(Start_flag1_r==1'b0))//偶次弿始，霿要等待奇数结板
                            fms_stop_ram_1    			<= 4'd3;
                        else
                            fms_stop_ram_1    			<= 4'd2;  
					end                 
               4'd3:
                    begin
                         ram_ena_1                        <= 1'b0;
                         ram_wea_1                        <= 1'b0;                      
//将数据写兿      

					     if(TDC_Data_Valid == 1'b1)//将RAM中的数据读出板
							begin      
									ram_enb_1              <= 1'b1;
									ram_addrb_1            <= TDC_Data;                                    
									fms_stop_ram_1         <= 4'd4;                           
						    end
					     else
						   begin
									fms_stop_ram_1         <= 4'd3;                          
					       end  
				    end
  
                4'd4:
					begin  
					    	if(Start_flag1 == 1'b0)//奇数数次统计结束
                      	 	fms_stop_ram_1         <= 4'd7;   
                      	else                                 
							fms_stop_ram_1                 <= 4'd5; 
					end       
				4'd5:
					begin    
					 	if(Start_flag1 == 1'b0)//奇数数次统计结束
                      	 	fms_stop_ram_1         <= 4'd7;   
                      	else            
							fms_stop_ram_1                <= 4'd6; 		
				    end			
				4'd6:
					begin//统计1欿
						 ram_enb_1                 <= 1'b0; 
				    	ram_addrb_1 				<=  12'd0;  
                      	if(Start_flag1 == 1'b0)//奇数数次统计结束
							begin
	
								fms_stop_ram_1             <= 4'd7; 
					
							end
						else
							begin          
								ram_ena_1                 <= 1'b1;
								ram_wea_1                 <= 1'b1;    
								ram_addra_1               <= TDC_Data;
								if(ram_dina_1 == 16'd65535)
								ram_dina_1               <= 16'd65535;
								else
								ram_dina_1                <= ram_doutb_1 +  16'd1;    
								fms_stop_ram_1            <= 4'd3; 
							end        
					end   
                4'd7:
                    begin
                        //弿始读  
                        ram_ena_1                       	<= 1'b0;      
                        ram_wea_1                           <= 1'b0;     
                        ram_addrb_1                     	<= ram_addrb_1_r;
                        ram_enb_1                       	<= 1'b1;   
                       read_data_flag                       <= 1'b0;   
                            ram1_flagb                      <= 1'b1;           
                        if(ram_addrb_1_r == 12'd4095)
							begin					
								fms_stop_ram_1            <= 4'd8; 
						      ram_enb1                            <= 1'b0; 
							end
                        else
							begin
								fms_stop_ram_1            <= 4'd7;
					             ram_enb1                 <= 1'b1;  
							end                
                   end   
                4'd8:
                    begin
                         ram1_flagb                      <= 1'b0;
                        ram_enb_1                          <= 1'b1;  
                        fms_stop_ram_1                    <= 4'd9;                     
                    end
                4'd9:
                    begin
 
                        ram_enb_1                            <= 1'b1;  
                        fms_stop_ram_1                    <= 4'd11; 
                    end     
                    
                    
                4'd11://发?完数据
                    begin
                 
                        ram_enb_1                            <= 1'b0;      
                        fms_stop_ram_1                      <= 4'd12; 
                        ram1_flaga                          <= 1'b0;
                    end
                4'd12:
                    begin
 //清零                     
                        ram1_flaga                          <= 1'b1;  
                        ram_enb_1                        <= 1'b0;                                 
                        if(ram_addra_1_r == 12'd4095)
							begin
								fms_stop_ram_1            <= 4'd13; 
							end
                        else
							begin
								fms_stop_ram_1            <= 4'd12; 
							end
                             ram_addra_1                  <= ram_addra_1_r;
                             ram_ena_1                    <= 1'b1;
                             ram_wea_1                    <= 1'b1;                         
                             ram_dina_1                   <= 16'd0;                  
                    end   
                4'd13://等待,从新弿始写数据
                    begin
                        ram1_flaga                      <= 1'b0;
                        fms_stop_ram_1            		<= 4'd2;   
                        ram_ena_1                         <= 1'b0;
                        ram_wea_1                         <= 1'b0;  
                         
                    end                     
               default:
                    begin           
                    end
               endcase
            end
           if((test_flag_r == 1'b0) && (test_flag_r1==1'b1))//结束测量
               begin
                   fms_stop_ram_2            <= 4'd0;              
               end
           else
               begin                       
                case(fms_stop_ram_2)
				4'd0:
					begin   
                       ram_ena_2                         <= 1'b0;
                       ram_wea_2                         <= 1'b0;
                       ram_addra_2                       <= 12'd0;
                       ram_dina_2                        <= 16'd0;    
                       ram_addra_2_r                     <= 12'd0;  
                       fms_stop_ram_2                    <= 4'd1; 
                       ram2_flaga                        <= 1'b0;    
                       ram2_flagb                        <= 1'b0;                 
					end
				4'd1:  //复位，将RAM中的数据清零
					begin
						if(ram_addra_2_r == 12'd4095)
							begin
                               fms_stop_ram_2            <= 4'd2; 
							end
                        else
							begin
                               fms_stop_ram_2            <= 4'd1; 
							end
					   ram2_flaga                        <= 1'b1;
                        ram_addra_2                      <= ram_addra_2_r;
                        ram_ena_2                        <= 1'b1;
                        ram_wea_2                        <= 1'b1;                         
                        ram_dina_2                       <= 16'd0;
					end
				4'd2:
                    begin
                        ram2_flaga                      <= 1'b0;
						if((Start_flag2 == 1'b1)&&(Start_flag2_r==1'b0))//偶次弿始，霿要等待奇数结板
                           fms_stop_ram_2    				<= 4'd3;
						else
                           fms_stop_ram_2    				<= 4'd2;  
                    end                 
				4'd3:
					begin
                        ram_ena_2                         <= 1'b0;
                        ram_wea_2                         <= 1'b0;                      
//将数据写兿    			
           
								if(TDC_Data_Valid == 1'b1)//将RAM中的数据读出板
									begin      
										ram_enb_2         <= 1'b1;
										ram_addrb_2       <= TDC_Data;                                    
										fms_stop_ram_2    <= 4'd4;                           
									end
								else
									begin
										fms_stop_ram_2    <= 4'd3;                          
									end 
						      end  		 
				4'd4:
					begin     
					   if(Start_flag2 == 1'b0)//奇数数次统计结束
                      	 	fms_stop_ram_2         <= 4'd7;   
                      	else           
								fms_stop_ram_2            <= 4'd5; 
					end       
				4'd5:
					begin    
				         if(Start_flag2 == 1'b0)//奇数数次统计结束
                      	 	   fms_stop_ram_2         <= 4'd7;   
                      	 else                 
								fms_stop_ram_2            <= 4'd6; 
					end     
				4'd6:
					begin//统计1欿
						    ram_enb_2                 <= 1'b0;
						  	ram_addrb_2 				<=  12'd0; 
                     	if(Start_flag2 == 1'b0)//偶数次统计结板
							begin
				
								fms_stop_ram_2            <= 4'd7; 
					
							end
						else
							begin          
								ram_ena_2                 <= 1'b1;
								ram_wea_2                 <= 1'b1;    
								ram_addra_2               <= TDC_Data;
								if(ram_dina_2 == 16'd65535)
								ram_dina_2                 <= 16'd65535;
								else
								ram_dina_2                <= ram_doutb_2 +  16'd1;    
								fms_stop_ram_2            <= 4'd3; 
							end        
					end   
				4'd7:
					begin
       //弿始读 
                        ram_addra_2_r                      <= 12'd0; 
                        ram_ena_2                          <= 1'b0;      
                        ram_wea_2                          <= 1'b0;           //20240512@CK
                        ram_addrb_2                        <= ram_addrb_2_r;
                        ram_enb_2                          <= 1'b1;                          
                        read_data_flag                      <= 1'b1;  
                        ram2_flagb                          <= 1'b1;   
                    if(ram_addrb_2_r == 12'd4095)
                        begin
                             fms_stop_ram_2                <= 4'd8; 
                             ram_enb2                            <= 1'b0;  
                        end
                      else
                        begin
                            fms_stop_ram_2                 <= 4'd7; 
                           ram_enb2                            <= 1'b1;  
                        end                
                  end   
               4'd8:
                   begin
                      ram2_flagb                          <= 1'b0;  
                    fms_stop_ram_2                          <= 4'd9; 
                    ram_enb_2                               <= 1'b1;              
                   end
               4'd9:
                   begin
                      fms_stop_ram_2                         <= 4'd11; 
                       ram_enb_2                            <= 1'b1;   
                          
                   end      
                4'd11://发?完数据
                   begin
                     
                      ram_enb_2                             <= 1'b0;    
                       fms_stop_ram_2                       <= 4'd12; 
                       ram2_flaga                      <= 1'b0;
                   end
                4'd12:
                    begin
//清零                  
                          ram2_flaga                      <= 1'b1;
                        ram_enb_2                          <= 1'b0;            
                        if(ram_addra_2_r == 12'd4095)
							begin
                             fms_stop_ram_2                <= 4'd13; 
							end
						else
							begin
                             fms_stop_ram_2                <= 4'd12; 
							end
                            ram_addra_2                    <= ram_addra_2_r;
                            ram_ena_2                      <= 1'b1;
                            ram_wea_2                      <= 1'b1;                         
                            ram_dina_2                     <= 16'd0;                  
                    end   
                4'd13://等待,从新弿始写数据
					begin
					         ram2_flaga                      <= 1'b0;
                            fms_stop_ram_2            	<= 4'd2;             
                            ram_ena_2                     <= 1'b0;
                            ram_wea_2                     <= 1'b0;           
                   end                                   
              default:
                   begin
                   end
              endcase               
           end  
        end 


blk_mem_gen_0  blk_mem_gen_0_inst_1(
.clka(Sys_Clk),
.ena(ram_ena_1),
.wea(ram_wea_1),
.addra(ram_addra_1),
.dina(ram_dina_1),
.clkb(Sys_Clk),
.enb(ram_enb_1),
.addrb(ram_addrb_1),
.doutb(ram_doutb_1)
);
                
blk_mem_gen_0 blk_mem_gen_0_inst_2(
.clka(Sys_Clk),
.ena(ram_ena_2),
.wea(ram_wea_2),
.addra(ram_addra_2),
.dina(ram_dina_2),
.clkb(Sys_Clk),
.enb(ram_enb_2),
.addrb(ram_addrb_2),
.doutb(ram_doutb_2)
);      
endmodule
  