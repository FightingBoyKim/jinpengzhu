`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/23 19:57:44
// Design Name: 
// Module Name: TDC_TCSPC_Module
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


module TDC_TCSPC_Module(clk_sys_400m,Reset,test_flag,test_time,acc_time,TCSPC_Data,TCSPC_Data_Valid,Start
,tscpc_mode,tcspc_acc_num ,TDC_Data,TDC_Data_Valid,Conforms_Counting_mode
    );
input                           clk_sys_400m;
input                           Reset;
input                           test_flag;//测量开始信号
input                           Start;
input[31:0]                     test_time;//测量时间
input[31:0]                     acc_time; //tcspc累积时间 
(*Mark_debug="TRUE"*)output[15:0]                    TCSPC_Data;
(*Mark_debug="TRUE"*)output                          TCSPC_Data_Valid;   
input                           tscpc_mode;//模式,1是累积时间，0是峰值模式
input                           Conforms_Counting_mode;
input[15:0]                      tcspc_acc_num;
(*Mark_debug="TRUE"*)input[11:0]                     TDC_Data;
(*Mark_debug="TRUE"*)input                           TDC_Data_Valid;
//
/*SPC是用鉴别器数脉冲，单次测量循环中將10us拆成1K段即10ns，
將每段10ns中的脉冲数记下，得到10us时段的一个1K点数组，
然后放入寄存器，再在触发脉冲下进行下一次测试循环，
得到的数组累加到寄存器，这样多次测量累加得到最终衰减*/
//是不是已Start为信号的开始，然后测start往后的时间，主时间是2.5ns,这样比如测量10us,1k，则信号的分辨率为10ns,10ns/2.5则4个周期
//信号死时间多少，需要用RAM，做统计，当start开始时，信号一直计数，当有stop时，将当前的计数值取出，根据它是哪个时间点的，将它放在RAM中
//因此RAM的地址应该是1024，2048，4096和8192
//时间应该是4*1024*2.5=10.24us，类似于这种，方便于统计
//分辨率最好是2^n*2.5ns
//具有两种结束模式，一种是累积时间，一种是强度值
//先考虑通道点数是1024，时间为10.24us
//做累积的RAM按最大8192，累积地址最大为14bit
reg                     Start_r1;
reg                     Start_r2;
reg[11:0]               cnt_10_24us;//10.24us是最小单位，主时钟400m,4095
reg[31:0]               cnt_test_time;
reg[2:0]                fms_start;
reg						test_flag_r;
reg						test_flag_r1;
reg[1:0]				fms_test;
 (*Mark_debug="TRUE"*)reg[31:0]				cnt_acc_time;
reg[11:0]				cnt_10us;
 (*Mark_debug="TRUE"*)reg						acc_time_done;


reg[11:0]               ram_index;
reg                     ram_index_valid;
reg[31:0]                     test_time_r;//测量时间
 (*Mark_debug="TRUE"*)reg[31:0]                     acc_time_r; //tcspc累积时间 

 (*Mark_debug="TRUE"*)reg                    acc_time_flag;
 (*Mark_debug="TRUE"*)reg                    acc_time_flag_done; 
 (*Mark_debug="TRUE"*)reg                    test_time_flag;
 (*Mark_debug="TRUE"*)reg                    test_time_flag_done;
 (*Mark_debug="TRUE"*)reg                     us_10_pluse;
reg                     us_10_pluse1;
reg                     tscpc_mode_r;
reg                     tscpc_mode_r1;
reg                     Conforms_Counting_mode_r1;
reg                     Conforms_Counting_mode_r;
reg                     tscpc_Conforms_Counting_mode;
//按激光器频率为1mhz,
always@(posedge clk_sys_400m or negedge Reset)
    if(Reset == 1'b1)
        begin
            Start_r1            <= 1'b0;
            Start_r2            <= 1'b0;
        
            cnt_10_24us         <= 12'd0;
            cnt_test_time       <= 32'd0;
            fms_start           <= 3'd0;
			test_flag_r			<= 1'b0;
			test_flag_r1		<= 1'b0;
			fms_test			<= 2'd0;
			cnt_acc_time		<= 32'd0;
			cnt_10us			<= 12'd0;
	
			acc_time_done		<= 1'b0;

			
	        ram_index                   <= 12'd0;
            ram_index_valid             <= 1'b0;	
            test_time_r         <= 32'd0;	
			acc_time_r          <= 32'd0;
			acc_time_flag		<= 1'b0;
			acc_time_flag_done  <= 1'b0;
			test_time_flag_done <= 1'b0;
			test_time_flag      <= 1'b0;
			us_10_pluse          <= 1'b0;
			us_10_pluse1         <= 1'b0;
			tscpc_mode_r         <= 1'b0;
			tscpc_mode_r1        <= 1'b0;
			Conforms_Counting_mode_r1<= 1'b0;
			Conforms_Counting_mode_r <= 1'b0;
			tscpc_Conforms_Counting_mode <= 1'b0;
        end
     else
        begin
            Conforms_Counting_mode_r    <= Conforms_Counting_mode;
            Conforms_Counting_mode_r1   <= Conforms_Counting_mode_r;
            tscpc_mode_r        <= tscpc_mode;
            tscpc_mode_r1       <= tscpc_mode_r;
            tscpc_Conforms_Counting_mode    <= tscpc_mode_r1 || Conforms_Counting_mode_r1;
            test_time_r             <= test_time;
            acc_time_r              <= acc_time;
			test_flag_r				<= test_flag;
			test_flag_r1			<= test_flag_r;
			Start_r1              	<= Start;
			Start_r2              	<= Start_r1;
//单次测量累积
    if(test_time_flag == 1'b1)
        begin
             if(cnt_10_24us == 12'd3999)
				begin
				    cnt_10_24us        		   <= 12'd0;
			  	    us_10_pluse1              <= 1'b1; 
                   end
			else
				begin
				    cnt_10_24us        		 <= cnt_10_24us + 12'd1;
				    us_10_pluse1             <= 1'b0;
				end
				
             if(us_10_pluse1 == 1'b1)
				begin
			  	      if(cnt_test_time == test_time_r)//完成单次测量，等待
						  begin
						      cnt_test_time    <= 32'd0;
						      test_time_flag_done<= 1'b1;
						  end
				    else
						 begin
							cnt_test_time    <= cnt_test_time + 32'd1;    
							test_time_flag_done  <= 1'b0;                               
                          end
                   end
			else
				begin
				    test_time_flag_done     <= 1'b0;
				end				
				
				
        end
      else
        begin
           cnt_10_24us                      <= 12'd0;
           cnt_test_time                    <= 32'd0; 
           test_time_flag_done                <= 1'b0;
           	us_10_pluse1                    <= 1'b0; 
        end


//多次累积
          if(acc_time_flag == 1'b1)
			     begin
			         if(cnt_10us == 12'd3999)
			              begin
						     us_10_pluse          <= 1'b1;
							 cnt_10us		      <= 12'd0;
					       end
	  			    else	
					   begin
						   cnt_10us		         <= cnt_10us + 12'd1;
						   us_10_pluse               <= 1'b0;
					   end	
					
	         if(us_10_pluse == 1'b1)
					 begin
						  if(cnt_acc_time == acc_time_r)
							 begin
								cnt_acc_time	       <= cnt_acc_time;
								acc_time_flag_done     <= 1'b1;
							end
						  else
							begin
								cnt_acc_time	       <= cnt_acc_time + 32'd1;
							   acc_time_flag_done     <= 1'b0;
							end
					   end
	  			  else	
				    	begin
						   acc_time_flag_done     <= 1'b0;
					   end					
			     end
			else
			      begin
			 			cnt_acc_time	       <= 32'd0;
						cnt_10us		       <= 12'd0;
					 acc_time_flag_done     <= 1'b0;
					  us_10_pluse              <= 1'b0; 
			     end

 //如果激光器重复频率比统计的时间长度短，那按激光器的长度来
		if(test_flag_r == 1'b0)
			begin
				fms_test			<= 2'd0;
				fms_start			<= 3'd0;
				acc_time_done		<= 1'b0;
		    	acc_time_flag        <= 1'b0;	
			     test_time_flag      <= 1'b0;
			end
		else
			begin
				case(fms_test)
			2'd0:
				begin				
					if(test_flag_r == 1'b1)
						fms_test			<= 2'd1;
					else
						fms_test			<= 2'd0;
				end
	       2'd1:
	           begin
	           		if((Start_r1 == 1'b1) &&(Start_r2 == 1'b0))
					   fms_test		      <= 2'd2;
                    else
                      fms_test			<= 2'd1;
	           end
			2'd2:
				begin	
					if((Start_r1 == 1'b1) &&(Start_r2 == 1'b0))
						begin
							fms_start		<= 3'd0;
						end
					else
						begin
							case(fms_start)                   
						3'd0:
							begin							
								fms_start					<= 3'd1;
								test_time_flag				<= 1'b0;
								acc_time_done				<= 1'b0;
							end
						3'd1:
							begin
		                        ram_index                   <= TDC_Data;
                                ram_index_valid             <= TDC_Data_Valid;					
								acc_time_flag               <= 1'b1;
								test_time_flag              <= 1'b1;		
//这个时单次测量的时间
			
							 if(test_time_flag_done == 1'b1)
							     fms_start        <= 3'd2; 
						     else
						       begin
						         if(acc_time_flag_done   == 1'b1)								
								    fms_start		<= 3'd3;
								else
								    fms_start       <= 3'd1;
								end
				    end
				3'd2:
					begin
						fms_start        					 <= 3'd2; //等待下次sync测量
						test_time_flag                     <= 1'b0;
					end
				3'd3:
					begin//完成本次测量

						acc_time_done						<= 1'b1 && tscpc_Conforms_Counting_mode;	
						acc_time_flag                       <= 1'b0;						
						fms_start                           <= 3'd4;	
					end		
		         3'd4:
		            begin	
		                  fms_start                       <= 3'd0;
		                  fms_test                        <= 2'd1;	              
		            end
                default:
                    begin
                    end
                endcase
				end
				end
		  default:
		      begin
		      end
		   endcase		   
		 end
        end

TCSPC_Module TCSPC_Module_inst(
.Sys_Clk(clk_sys_400m),
.Reset(Reset),
.Start_stop_flag(test_flag),
.tscpc_mode(tscpc_Conforms_Counting_mode),
.acc_time_done(acc_time_done),
.TDC_Data(ram_index),
.TDC_Data_Valid(ram_index_valid),
.data_tcspc(TCSPC_Data),
.data_tcspc_valid(TCSPC_Data_Valid),
.tcspc_acc_num(tcspc_acc_num)
    );    
endmodule
