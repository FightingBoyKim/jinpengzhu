`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 21:29:04
// Design Name: 
// Module Name: TDC_Counter_Phase
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


module TDC_Counter_Phase_Clk(Reset,Sys_Clk1,Sys_Clk2,Sys_Clk3,Sys_Clk4,Sys_Clk5,Sys_Clk6,Sys_Clk7,Sys_Clk8,
Counter_Value,Phase_Value,Valid_flag,Signal_TDC
    );
input                                      Reset;
input                                      Sys_Clk1; 
input                                      Sys_Clk2;
input                                      Sys_Clk3;
input                                      Sys_Clk4;
input                                      Sys_Clk5;
input                                      Sys_Clk6;
input                                      Sys_Clk7;
input                                      Sys_Clk8;      
input                                      Signal_TDC; 
output[21:0]                                Counter_Value;
output[3:0]                                Phase_Value;
output                                     Valid_flag; 

reg[21:0]                                   Counter_Value;
reg[3:0]                                   Phase_Value;
reg                                        Valid_flag; 
wire                                       Signal_TDC_bug;
   BUFG BUFG_inst (
      .O(Signal_TDC_bug), // 1-bit output: Clock output
      .I(Signal_TDC)  // 1-bit input: Clock input
  );


(*Mark_debug="TRUE"*)reg[15:0]                                  Data_Phase;
(*Mark_debug="TRUE"*)reg[15:0]                                  Data_Phase_rr;
(*Mark_debug="TRUE"*)reg[15:0]                                  Data_Phase_r;
(*Mark_debug="TRUE"*)reg[15:0]                                  Data_Phase_r1;
reg[21:0]                                                        cnt_1_pose;
reg[21:0]                                                        cnt_1_pose_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_1_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_1_r1;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_1_r2;

(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_2_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_2_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_3_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_3_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_4_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_4_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_5_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_5_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_6_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_6_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_7_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_7_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_8_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_pose_8_r1;




(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_1_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_1_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_2_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_2_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_3_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_3_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_4_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_4_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_5_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_5_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_6_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_6_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_7_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_7_r1;


(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_8_r;
(*Mark_debug="TRUE"*)reg                                        Signa_in_nege_8_r1;


//�?1路上升沿
always@(posedge Sys_Clk1 or negedge Reset)
    if(Reset == 1'b1)
        begin
            cnt_1_pose                              <= 22'd0;
    //        cnt_1_pose_r1                           <= 15'd0;
       //     fms_pose_1                              <= 1'b0;
             Signa_in_pose_1_r                       <= 1'b0;
            Signa_in_pose_1_r1                      <= 1'b0;
       //     Signa_in_pose_1_r2                      <= 1'b0;              
         
        end
    else
        begin
            Signa_in_pose_1_r                       <= Signal_TDC_bug;
            Signa_in_pose_1_r1                      <= Signa_in_pose_1_r;
       //     Signa_in_pose_1_r2                      <= Signa_in_pose_1_r1;  
            Data_Phase[15]                          <=  Signa_in_pose_1_r1;  
             Data_Phase_rr[15:12]                   <= Data_Phase[15:12];
            Data_Phase_r[15:8]                     <= Data_Phase_rr[15:8]; 
            Data_Phase_r1                           <= Data_Phase_r;    
            cnt_1_pose                              <= cnt_1_pose + 24'd1;        
            
              if((Signa_in_pose_1_r == 1'b1) && (Signa_in_pose_1_r1==1'b0))
                    cnt_1_pose_r1                   <= cnt_1_pose; 
               else
                    cnt_1_pose_r1                   <= cnt_1_pose_r1;
                   
              /*  case(fms_pose_1)
            1'd0:
                begin   
					
                    if((Signa_in_pose_1_r1 == 1'b1) && (Signa_in_pose_1_r2==1'b0))
						fms_pose_1                  <= 1'd1;      
                    else
						fms_pose_1                  <= 1'd0;
                end
            1'd1:
                begin
                    if((Signa_in_pose_1_r1 == 1'b0) &&(Signa_in_pose_1_r2==1'b1))
						fms_pose_1                  <= 1'd0;      
                    else
						fms_pose_1                  <= 1'd1;
                end
            default:
                begin
                end
            endcase*/
        end

//�?2路上升沿
always@(posedge Sys_Clk2 )
        begin
            Signa_in_pose_2_r                       <= Signal_TDC_bug;
            Signa_in_pose_2_r1                      <= Signa_in_pose_2_r; 
            Data_Phase[14]                          <= Signa_in_pose_2_r1;       
            
        end

//�?3路上升沿
always@(posedge Sys_Clk3 )

        begin
            Signa_in_pose_3_r                       <= Signal_TDC_bug;
            Signa_in_pose_3_r1                      <= Signa_in_pose_3_r;  
            Data_Phase[13]                          <= Signa_in_pose_3_r1;       
            
        end

 //�?4路上升沿
always@(posedge Sys_Clk4 )
        begin
            Signa_in_pose_4_r                       <= Signal_TDC_bug;
            Signa_in_pose_4_r1                      <= Signa_in_pose_4_r; 
            Data_Phase[12]                          <= Signa_in_pose_4_r1;       
 
        end
		
//�?5路上升沿
always@(posedge Sys_Clk5 )
        begin
            Signa_in_pose_5_r                       <= Signal_TDC_bug;
            Signa_in_pose_5_r1                      <= Signa_in_pose_5_r; 
            Data_Phase[11]                          <= Signa_in_pose_5_r1;       
           Data_Phase_rr[11:8]                    <=   Data_Phase[11:8]; 
        end		

//�?6路上升沿
always@(posedge Sys_Clk6 )
        begin
            Signa_in_pose_6_r                       <= Signal_TDC_bug;
            Signa_in_pose_6_r1                      <= Signa_in_pose_6_r; 
            Data_Phase[10]                          <= Signa_in_pose_6_r1;       
            
        end
		
//�?7路上升沿
always@(posedge Sys_Clk7 )
        begin
            Signa_in_pose_7_r                       <= Signal_TDC_bug;
            Signa_in_pose_7_r1                      <= Signa_in_pose_7_r; 
            Data_Phase[9]                          <= Signa_in_pose_7_r1;
		
		end
 	
//�?8路上升沿
always@(posedge Sys_Clk8 )
        begin
            Signa_in_pose_8_r                       <= Signal_TDC_bug;
            Signa_in_pose_8_r1                      <= Signa_in_pose_8_r;  
            Data_Phase[8]                          <= Signa_in_pose_8_r1;       
            
        end

 
always@(negedge Sys_Clk1 )
        begin
            Signa_in_nege_1_r                        <= Signal_TDC_bug;
            Signa_in_nege_1_r1                       <= Signa_in_nege_1_r;
            Data_Phase[7]                           <=  Signa_in_nege_1_r1;
             Data_Phase_rr[7:4]                     <= Data_Phase[7:4];
            Data_Phase_r[7:0]                        <= Data_Phase_rr[7:0];                                    
          
        end


always@(negedge Sys_Clk2 )

        begin
            Signa_in_nege_2_r                        <= Signal_TDC_bug;
            Signa_in_nege_2_r1                       <= Signa_in_nege_2_r;
            Data_Phase[6]                           <= Signa_in_nege_2_r1;               
        end


always@(negedge Sys_Clk3 )
        begin
            Signa_in_nege_3_r                        <= Signal_TDC_bug;
            Signa_in_nege_3_r1                       <= Signa_in_nege_3_r;
            Data_Phase[5]                           <= Signa_in_nege_3_r1;             
        end


always@(negedge Sys_Clk4 )
        begin
            Signa_in_nege_4_r                        <= Signal_TDC_bug;
            Signa_in_nege_4_r1                       <= Signa_in_nege_4_r;
            Data_Phase[4]                           <= Signa_in_nege_4_r1;       
            
        end
		

always@(negedge Sys_Clk5 )
        begin
            Signa_in_nege_5_r                        <= Signal_TDC_bug;
            Signa_in_nege_5_r1                       <= Signa_in_nege_5_r;
            Data_Phase[3]                           <= Signa_in_nege_5_r1;       
            Data_Phase_rr[3:0]                     <= Data_Phase[3:0];  
        end		
 

always@(negedge Sys_Clk6 )
        begin
            Signa_in_nege_6_r                        <= Signal_TDC_bug;
            Signa_in_nege_6_r1                       <= Signa_in_nege_6_r; 
            Data_Phase[2]                           <= Signa_in_nege_6_r1;       
            
        end
	

always@(negedge Sys_Clk7 )
        begin
            Signa_in_nege_7_r                        <= Signal_TDC_bug;
            Signa_in_nege_7_r1                       <= Signa_in_nege_7_r; 
            Data_Phase[1]                           <= Signa_in_nege_7_r1;
		
		end
		

always@(negedge Sys_Clk8 )
        begin
            Signa_in_nege_8_r                        <= Signal_TDC_bug;
            Signa_in_nege_8_r1                       <= Signa_in_nege_8_r;
            Data_Phase[0]                            <= Signa_in_nege_8_r1;       
            
        end

//�ж���λ
//�ж���λ   
reg          											fms_phase;
reg[15:0]           										Data_Phase_r2;
reg[15:0]           										Data_Phase_r3;
(*Mark_debug="TRUE"*)reg                											Phase_done;
(*Mark_debug="TRUE"*)reg                											Phase_done1;
(*Mark_debug="TRUE"*)reg                											Phase_done2;
(*Mark_debug="TRUE"*)reg                											Phase_done3;
reg[21:0]                                  					cnt_1_pose_r2;
reg[21:0]                                  					cnt_1_pose_r3;
reg[21:0]                                  					cnt_1_pose_r4;
reg[21:0]                                  					cnt_1_pose_r5;
reg[3:0]                                                   Phase_Value_1;
reg[3:0]                                                   Phase_Value_2; 
reg[3:0]            										Counter_phase;
reg[15:0]            										Data_Phase_r4;
  always@(posedge Sys_Clk1 or negedge Reset)
       if(Reset == 1'b1)
           begin
            fms_phase                   					<= 1'd0;
            Valid_flag                              		<= 1'b0;
            Data_Phase_r2                                   <= 16'd0;
            Data_Phase_r3                                   <= 16'd0;
 				Phase_done1                   				<= 1'd0;
				Phase_done2                   				<= 1'd0;
				Phase_done3                   				<= 1'd0;           
           end
       else
			begin
				Data_Phase_r2                				<= Data_Phase_r1;
				Data_Phase_r3               				<= Data_Phase_r2;
				cnt_1_pose_r2               				<= cnt_1_pose_r1;	
				cnt_1_pose_r4		                        <= cnt_1_pose_r2;	
				Phase_done1                   				<= Phase_done;
				Phase_done2                   				<= Phase_done1;
				Phase_done3                   				<= Phase_done2;
			
                if((Phase_done2 == 1'b1)&&(Phase_done3 == 1'b0))
					Valid_flag             						<= 1'b1;
			    else
			     Valid_flag             						<= 1'b0;
				if(Phase_done == 1'b1)
					begin
						cnt_1_pose_r3               		<= cnt_1_pose_r4;
						Data_Phase_r4   				 	<= Data_Phase_r3;
					end
		
	       	  if(Data_Phase_r1 == 16'hffff)
                    begin
                        Phase_done       					<= 1'b1;
                    end
			  else
			       Phase_done       					<= 1'b0; 		
   
       /*    case(fms_phase)
        1'd0:
            begin
                if(Data_Phase_r1 == 16'hffff)
                    begin
                        fms_phase       					<= 1'd1;
                        Phase_done       					<= 1'b1;
                    end
                else
                    begin
                        begin
                        fms_phase       					<= 1'd0;
                        Phase_done       					<= 1'b0;
                        end
                    end
            end
         1'd1:
            begin
					Phase_done               				<= 1'b0;
                if(Data_Phase_r1 == 16'h0000)
                    begin
                        fms_phase       					<= 1'd0;
                    end
                else
                    begin
                        begin
                        fms_phase       					<= 1'd1;
                        end
                    end
            end
        default:
            begin
            
            end
          endcase*/
			Phase_Value_1 <= {3'b000,Data_Phase_r4[0]}+ {3'b000,Data_Phase_r4[1]}+   {3'b000,Data_Phase_r4[2]}+   {3'b000,Data_Phase_r4[3]}+   {3'b000,Data_Phase_r4[4]}+   {3'b000,Data_Phase_r4[5]}+   {3'b000,Data_Phase_r4[6]}+   {3'b000,Data_Phase_r4[7]}; 
		  	Phase_Value_2 <= {3'b000,Data_Phase_r4[8]}+ {3'b000,Data_Phase_r4[9]}+   {3'b000,Data_Phase_r4[10]}+   {3'b000,Data_Phase_r4[11]}+   {3'b000,Data_Phase_r4[12]}+   {3'b000,Data_Phase_r4[13]}+   {3'b000,Data_Phase_r4[14]}+   {3'b000,Data_Phase_r4[15]};
            cnt_1_pose_r5                               <= cnt_1_pose_r3;
            Counter_Value    							<= cnt_1_pose_r5;
            Phase_Value                                 <= Phase_Value_1+ Phase_Value_2;
	//		Phase_Value									<= Counter_phase;			
           end   


 
endmodule
