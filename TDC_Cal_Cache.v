`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/10 12:31:40
// Design Name: 
// Module Name: TDC_Cal_Cache
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


module TDC_Cal_Cache(
Sys_Clk,Reset,Conforms_Counting_mode_1
,T3_DATA_A,T3_DATA_A_Valid,T3_DATA_B,T3_DATA_B_Valid,Conforms_Counting_data_1,Conforms_Counting_data_Valid_1,
TDC_test_flag,TDC_Bin,TDC_DATA_BIN_A,TDC_DATA_BIN_A_Valid,TDC_DATA_BIN_B,TDC_DATA_BIN_B_Valid,
Sync_data,Sync_data_Valid,Spd1_Stop_data,Spd1_Stop_data_Valid,Spd2_Stop_data,Spd2_Stop_data_Valid,Sync_data_fine,Spd1_Stop_data_fine,Spd2_Stop_data_fine
    );
input                                     Sys_Clk;
input                                     Reset; 
input                                     TDC_test_flag;
input[4:0]                                TDC_Bin;  

  
  
input[31:0]                              Conforms_Counting_data_1;
input                                    Conforms_Counting_data_Valid_1;

(*Mark_debug="TRUE"*)input[5:0]                            Sync_data_fine;
(*Mark_debug="TRUE"*)input[5:0]                            Spd1_Stop_data_fine;
(*Mark_debug="TRUE"*)input[5:0]                            Spd2_Stop_data_fine;


input                                     Conforms_Counting_mode_1;

(*Mark_debug="TRUE"*)input[27:0]                            Sync_data;
(*Mark_debug="TRUE"*)input                                  Sync_data_Valid;
(*Mark_debug="TRUE"*)input[27:0]                            Spd1_Stop_data;
(*Mark_debug="TRUE"*)input                                  Spd1_Stop_data_Valid;
(*Mark_debug="TRUE"*)input[27:0]                            Spd2_Stop_data;
(*Mark_debug="TRUE"*)input                                  Spd2_Stop_data_Valid;



    
output[30:0]                              T3_DATA_A;
output                                    T3_DATA_A_Valid;
output[30:0]                              T3_DATA_B;
output                                    T3_DATA_B_Valid;
 
 


 
output[11:0]                              TDC_DATA_BIN_A;
output                                    TDC_DATA_BIN_A_Valid;
output[11:0]                              TDC_DATA_BIN_B;
output                                    TDC_DATA_BIN_B_Valid;
    
(*Mark_debug="TRUE"*)reg[30:0]                                T3_DATA_A;
(*Mark_debug="TRUE"*)reg                                      T3_DATA_A_Valid;
(*Mark_debug="TRUE"*)reg[30:0]                                T3_DATA_B;
(*Mark_debug="TRUE"*)reg                                      T3_DATA_B_Valid; 





reg[30:0]                                T3_DATA_A_r;
reg                                      T3_DATA_A_Valid_r;
reg[30:0]                                T3_DATA_B_r;
reg                                      T3_DATA_B_Valid_r; 




reg[30:0]                                TDC_DATA_A_1;
reg                                      TDC_DATA_A_Valid_1;
reg[30:0]                                TDC_DATA_A_2;

reg[30:0]                                TDC_DATA_A_1_r;
reg                                      TDC_DATA_A_Valid_1_r;
reg[30:0]                                TDC_DATA_A_2_r;






reg[30:0]                                TDC_DATA_B_1;
reg[30:0]                                TDC_DATA_B_2;
reg                                      TDC_DATA_B_Valid_1; 

reg[30:0]                                TDC_DATA_B_1_r;
reg[30:0]                                TDC_DATA_B_2_r;
reg                                      TDC_DATA_B_Valid_1_r; 





(*Mark_debug="TRUE"*)reg[11:0]                              TDC_DATA_BIN_A;
(*Mark_debug="TRUE"*)reg                                    TDC_DATA_BIN_A_Valid;
(*Mark_debug="TRUE"*)reg[11:0]                              TDC_DATA_BIN_B;
(*Mark_debug="TRUE"*)reg                                    TDC_DATA_BIN_B_Valid;


reg[11:0]                              TDC_DATA_BIN_A_r;
reg                                    TDC_DATA_BIN_A_Valid_r;
reg[11:0]                              TDC_DATA_BIN_B_r;
reg                                    TDC_DATA_BIN_B_Valid_r;



reg[29:0]                                TDC_DATA_A;
reg                                      TDC_DATA_A_Valid;

reg[29:0]                                TDC_DATA_B;
reg                                      TDC_DATA_B_Valid; 

reg                                      TDC_test_flag_r;
reg                                      TDC_test_flag_r1;




reg[30:0]                               Conforms_Counting_1_1_dout_r;
reg[30:0]                               Conforms_Counting_1_2_dout_r;
reg[30:0]                               Conforms_Counting_1_3_dout_r;
reg[30:0]                               Conforms_Counting_1_4_dout_r;
reg                                     Conforms_Counting_1_1_valid_r;



reg[11:0]                               TDC_DATA_A1;
reg                                     TDC_DATA_A_Valid1;                  
reg[11:0]                               TDC_DATA_B1;
reg                                      TDC_DATA_B_Valid1;  

reg[11:0]                               TDC_DATA_A2;
reg                                     TDC_DATA_A_Valid2;                  
reg[11:0]                               TDC_DATA_B2;
reg                                      TDC_DATA_B_Valid2;  

reg[11:0]                               TDC_DATA_A3;
reg                                     TDC_DATA_A_Valid3;                  
reg[11:0]                               TDC_DATA_B3;
reg                                      TDC_DATA_B_Valid3;  


reg[11:0]                               TDC_DATA_A4;
reg                                     TDC_DATA_A_Valid4;                  
reg[11:0]                               TDC_DATA_B4;
reg                                      TDC_DATA_B_Valid4;  

reg[11:0]                               TDC_DATA_A5;
reg                                     TDC_DATA_A_Valid5;                  
reg[11:0]                               TDC_DATA_B5;
reg                                      TDC_DATA_B_Valid5;  

reg[11:0]                               TDC_DATA_A6;
reg                                     TDC_DATA_A_Valid6;                  
reg[11:0]                               TDC_DATA_B6;
reg                                      TDC_DATA_B_Valid6;  

reg[11:0]                               TDC_DATA_A7;
reg                                     TDC_DATA_A_Valid7;                  
reg[11:0]                               TDC_DATA_B7;
reg                                      TDC_DATA_B_Valid7;  

reg[11:0]                               TDC_DATA_A8;
reg                                     TDC_DATA_A_Valid8;                  
reg[11:0]                               TDC_DATA_B8;
reg                                      TDC_DATA_B_Valid8;  

reg[11:0]                               TDC_DATA_A9;
reg                                     TDC_DATA_A_Valid9;                  
reg[11:0]                               TDC_DATA_B9;
reg                                      TDC_DATA_B_Valid9;  

reg[11:0]                               TDC_DATA_A10;
reg                                     TDC_DATA_A_Valid10;                  
reg[11:0]                               TDC_DATA_B10;
reg                                      TDC_DATA_B_Valid10; 

reg[11:0]                               TDC_DATA_A11;
reg                                     TDC_DATA_A_Valid11;                  
reg[11:0]                               TDC_DATA_B11;
reg                                      TDC_DATA_B_Valid11;  

reg[11:0]                               TDC_DATA_A12;
reg                                     TDC_DATA_A_Valid12;                  
reg[11:0]                               TDC_DATA_B12;
reg                                      TDC_DATA_B_Valid12;  

reg[11:0]                               TDC_DATA_A13;
reg                                     TDC_DATA_A_Valid13;                  
reg[11:0]                               TDC_DATA_B13;
reg                                      TDC_DATA_B_Valid13;  


reg[11:0]                               TDC_DATA_A14;
reg                                     TDC_DATA_A_Valid14;                  
reg[11:0]                               TDC_DATA_B14;
reg                                      TDC_DATA_B_Valid14;  

reg[11:0]                               TDC_DATA_A15;
reg                                     TDC_DATA_A_Valid15;                  
reg[11:0]                               TDC_DATA_B15;
reg                                      TDC_DATA_B_Valid15;  

reg[11:0]                               TDC_DATA_A16;
reg                                     TDC_DATA_A_Valid16;                  
reg[11:0]                               TDC_DATA_B16;
reg                                      TDC_DATA_B_Valid16;  

reg[11:0]                               TDC_DATA_A17;
reg                                     TDC_DATA_A_Valid17;                  
reg[11:0]                               TDC_DATA_B17;
reg                                      TDC_DATA_B_Valid17;  

reg[11:0]                               TDC_DATA_A18;
reg                                     TDC_DATA_A_Valid18;                  
reg[11:0]                               TDC_DATA_B18;
reg                                      TDC_DATA_B_Valid18;  

reg[11:0]                               TDC_DATA_A19;
reg                                     TDC_DATA_A_Valid19;                  
reg[11:0]                               TDC_DATA_B19;
reg                                      TDC_DATA_B_Valid19;  


reg[11:0]                               TDC_DATA_A1_r;
reg                                     TDC_DATA_A_Valid1_r;                  
reg[11:0]                               TDC_DATA_B1_r;
reg                                      TDC_DATA_B_Valid1_r;  

reg[11:0]                               TDC_DATA_A2_r;
reg                                     TDC_DATA_A_Valid2_r;                  
reg[11:0]                               TDC_DATA_B2_r;
reg                                      TDC_DATA_B_Valid2_r;  

reg[11:0]                               TDC_DATA_A3_r;
reg                                     TDC_DATA_A_Valid3_r;                  
reg[11:0]                               TDC_DATA_B3_r;
reg                                      TDC_DATA_B_Valid3_r;  


reg[11:0]                               TDC_DATA_A4_r;
reg                                     TDC_DATA_A_Valid4_r;                  
reg[11:0]                               TDC_DATA_B4_r;
reg                                      TDC_DATA_B_Valid4_r;  

reg[11:0]                               TDC_DATA_A5_r;
reg                                     TDC_DATA_A_Valid5_r;                  
reg[11:0]                               TDC_DATA_B5_r;
reg                                      TDC_DATA_B_Valid5_r;  

reg[11:0]                               TDC_DATA_A6_r;
reg                                     TDC_DATA_A_Valid6_r;                  
reg[11:0]                               TDC_DATA_B6_r;
reg                                      TDC_DATA_B_Valid6_r;  

reg[11:0]                               TDC_DATA_A7_r;
reg                                     TDC_DATA_A_Valid7_r;                  
reg[11:0]                               TDC_DATA_B7_r;
reg                                      TDC_DATA_B_Valid7_r;  

reg[11:0]                               TDC_DATA_A8_r;
reg                                     TDC_DATA_A_Valid8_r;                  
reg[11:0]                               TDC_DATA_B8_r;
reg                                      TDC_DATA_B_Valid8_r;  

reg[11:0]                               TDC_DATA_A9_r;
reg                                     TDC_DATA_A_Valid9_r;                  
reg[11:0]                               TDC_DATA_B9_r;
reg                                      TDC_DATA_B_Valid9_r;  

reg[11:0]                               TDC_DATA_A10_r;
reg                                     TDC_DATA_A_Valid10_r;                  
reg[11:0]                               TDC_DATA_B10_r;
reg                                      TDC_DATA_B_Valid10_r; 

reg[11:0]                               TDC_DATA_A11_r;
reg                                     TDC_DATA_A_Valid11_r;                  
reg[11:0]                               TDC_DATA_B11_r;
reg                                      TDC_DATA_B_Valid11_r;  

reg[11:0]                               TDC_DATA_A12_r;
reg                                     TDC_DATA_A_Valid12_r;                  
reg[11:0]                               TDC_DATA_B12_r;
reg                                      TDC_DATA_B_Valid12_r;  

reg[11:0]                               TDC_DATA_A13_r;
reg                                     TDC_DATA_A_Valid13_r;                  
reg[11:0]                               TDC_DATA_B13_r;
reg                                      TDC_DATA_B_Valid13_r;  


reg[11:0]                               TDC_DATA_A14_r;
reg                                     TDC_DATA_A_Valid14_r;                  
reg[11:0]                               TDC_DATA_B14_r;
reg                                      TDC_DATA_B_Valid14_r;  

reg[11:0]                               TDC_DATA_A15_r;
reg                                     TDC_DATA_A_Valid15_r;                  
reg[11:0]                               TDC_DATA_B15_r;
reg                                      TDC_DATA_B_Valid15_r;  

reg[11:0]                               TDC_DATA_A16_r;
reg                                     TDC_DATA_A_Valid16_r;                  
reg[11:0]                               TDC_DATA_B16_r;
reg                                      TDC_DATA_B_Valid16_r;  

reg[11:0]                               TDC_DATA_A17_r;
reg                                     TDC_DATA_A_Valid17_r;                  
reg[11:0]                               TDC_DATA_B17_r;
reg                                      TDC_DATA_B_Valid17_r;  

reg[11:0]                               TDC_DATA_A18_r;
reg                                     TDC_DATA_A_Valid18_r;                  
reg[11:0]                               TDC_DATA_B18_r;
reg                                      TDC_DATA_B_Valid18_r;  

reg[11:0]                               TDC_DATA_A19_r;
reg                                     TDC_DATA_A_Valid19_r;                  
reg[11:0]                               TDC_DATA_B19_r;
reg                                      TDC_DATA_B_Valid19_r;  


reg                                     Conforms_Counting_mode_1_r;
reg                                     Conforms_Counting_mode_1_r1;

reg[4:0]                                TDC_Bin_r; 
reg[4:0]                                TDC_Bin_r1;   






reg[1:0]                             fms_data1;
reg[1:0]                             fms_data2;
/*
always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1)
        begin
            Sync_data_r               <= 30'd0;
            Sync_data_Valid_r         <= 1'b0;
            Spd1_Stop_data_r          <= 30'd0;
            Spd1_Stop_data_Valid_r    <= 1'b0;
            Spd2_Stop_data_r          <= 30'd0;
            Spd2_Stop_data_Valid_r    <= 1'b0;        
        end
    else
        begin
            Sync_data_r               <= Sync_data;
            Sync_data_Valid_r         <= Sync_data_Valid;
            Spd1_Stop_data_r          <= Spd1_Stop_data;
            Spd1_Stop_data_Valid_r    <= Spd1_Stop_data_Valid;
            Spd2_Stop_data_r          <= Spd2_Stop_data;
            Spd2_Stop_data_Valid_r    <= Spd2_Stop_data_Valid;              
        end
*/
reg[27:0]               T3_DATA_A_x1;
reg[27:0]               T3_DATA_B_x1;
reg                     Spd1_Stop_data_Valid_x;


always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1)
        begin       
            T3_DATA_A_x1                <= 29'd0;
            TDC_test_flag_r              <= 1'b0;
            TDC_test_flag_r1             <= 1'b0;        
            T3_DATA_A                   <= 31'd0;
            T3_DATA_A_Valid             <= 1'b0;  
            T3_DATA_A_r                   <= 31'd0;
            T3_DATA_A_Valid_r             <= 1'b0;  

  
            TDC_DATA_A_1                 <= 31'd0;
            TDC_DATA_A_Valid_1           <= 1'b0;
            TDC_DATA_A_2                 <= 31'd0;          
   
            TDC_DATA_A_1_r                 <= 31'd0;
            TDC_DATA_A_Valid_1_r           <= 1'b0;
            TDC_DATA_A_2_r                 <= 31'd0;   
            
                                     
            Conforms_Counting_mode_1_r          <= 1'b0;
            Conforms_Counting_mode_1_r1         <= 1'b0;
        
            fms_data1                      <= 2'd0;
                                     
        end
    else
        begin          
            Conforms_Counting_mode_1_r          <= Conforms_Counting_mode_1;
            Conforms_Counting_mode_1_r1         <= Conforms_Counting_mode_1_r;                    
            TDC_test_flag_r                     <= TDC_test_flag;
            TDC_test_flag_r1                    <= TDC_test_flag_r;
  

   
            if(TDC_test_flag_r == 1'b0)
                begin
                    fms_data1                      <= 2'd0;
                end
            else
                begin
                    case(fms_data1)
                  2'd0:
                    begin
                        if(Sync_data_Valid == 1'b1)
                            fms_data1              <= 2'd1;
                        else
                            fms_data1              <= 2'd0;
                    end
                  2'd1:
                    begin
                       if(Spd1_Stop_data_Valid == 1'b1)
                            begin
                                   T3_DATA_A_Valid         <= 1'b1;              
                             if(Spd1_Stop_data <= Sync_data) 
                                 T3_DATA_A               <= {1'd0,2'd0,(Spd1_Stop_data-Sync_data+29'h1fffffff + Sync_data_fine - Spd1_Stop_data_fine)};
                             else  
                                T3_DATA_A               <= {1'd0,2'd0,(Spd1_Stop_data-Sync_data+ Sync_data_fine - Spd1_Stop_data_fine)};
                                                              
                            end
                        else
                            begin
                               T3_DATA_A_Valid         <= 1'b0;   
                            end
                       if(Sync_data_Valid == 1'b1)
                            fms_data1              <= 2'd2;
                        else
                            fms_data1              <= 2'd1; 
                    end
                  2'd2:
                    begin
                        if(Spd1_Stop_data_Valid == 1'b1)
                            begin

                                T3_DATA_A_Valid         <= 1'b1;      
                             if(Spd1_Stop_data <= Sync_data) 
                                 T3_DATA_A               <= {1'd1,2'd0,(Spd1_Stop_data-Sync_data+29'h1fffffff+ Sync_data_fine - Spd1_Stop_data_fine)};
                             else  
                                T3_DATA_A               <= {1'd1,2'd0,(Spd1_Stop_data-Sync_data+ Sync_data_fine - Spd1_Stop_data_fine)};                               
                            end
                        else
                            begin
                               T3_DATA_A_Valid         <= 1'b0;   
                            end
                       if(Sync_data_Valid == 1'b1)
                            fms_data1              <= 2'd1;
                        else
                            fms_data1              <= 2'd2;                    
                    end
                  default:
                    begin
                    end
                  endcase
                end

                
      
                T3_DATA_A_r             <= T3_DATA_A;
                T3_DATA_A_Valid_r       <= T3_DATA_A_Valid;            
   
        end


always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1)
        begin                  
            T3_DATA_B                   <= 31'd0;
            T3_DATA_B_Valid             <= 1'b0;  
            T3_DATA_B_r                   <= 31'd0;
            T3_DATA_B_Valid_r             <= 1'b0;                 
            TDC_DATA_B_1                 <= 31'd0;
            TDC_DATA_B_Valid_1           <= 1'b0;
            TDC_DATA_B_2                 <= 31'd0;                     
             TDC_DATA_B_1_r                 <= 31'd0;
            TDC_DATA_B_Valid_1_r           <= 1'b0;
            TDC_DATA_B_2_r                 <= 31'd0; 
            fms_data2                     <= 2'd0;                                  
        end
    else
        begin
              if(TDC_test_flag_r == 1'b0)
                begin
                    fms_data2                      <= 2'd0;
                end
            else
                begin
                    case(fms_data2)
                  2'd0:
                    begin
                        if(Sync_data_Valid == 1'b1)
                            fms_data2              <= 2'd1;
                        else
                            fms_data2              <= 2'd0;
                    end
                  2'd1:
                    begin
                       if(Spd2_Stop_data_Valid == 1'b1)
                            begin                           
                             if(Spd2_Stop_data <= Sync_data) 
                                 T3_DATA_B               <= {1'd0,2'd0,(Spd2_Stop_data-Sync_data+29'h1fffffff+ Sync_data_fine - Spd2_Stop_data_fine)};
                             else  
                                T3_DATA_B               <= {1'd0,2'd0,(Spd2_Stop_data-Sync_data+ Sync_data_fine - Spd2_Stop_data_fine)};                                 
                                
                                
                                T3_DATA_B_Valid         <= 1'b1;                                     
                            end
                        else
                            begin
                               T3_DATA_B_Valid         <= 1'b0;   
                            end
                       if(Sync_data_Valid == 1'b1)
                            fms_data2              <= 2'd2;
                        else
                            fms_data2              <= 2'd1; 
                    end
                  2'd2:
                    begin
                        if(Spd2_Stop_data_Valid == 1'b1)
                            begin
                                            T3_DATA_B_Valid         <= 1'b1;  
                             if(Spd2_Stop_data <= Sync_data) 
                                 T3_DATA_B               <= {1'd1,2'd0,(Spd2_Stop_data-Sync_data+29'h1fffffff+ Sync_data_fine - Spd2_Stop_data_fine)};
                             else  
                                T3_DATA_B               <= {1'd1,2'd0,(Spd2_Stop_data-Sync_data+ Sync_data_fine - Spd2_Stop_data_fine)};       
                                                   
                            end
                        else
                            begin
                               T3_DATA_B_Valid         <= 1'b0;   
                            end
                       if(Sync_data_Valid == 1'b1)
                            fms_data2              <= 2'd1;
                        else
                            fms_data2              <= 2'd2;                    
                    end
                  default:
                    begin
                    end
                  endcase
                end
    
                T3_DATA_B_r                 <= T3_DATA_B;
                T3_DATA_B_Valid_r           <= T3_DATA_B_Valid;        
        end
        
 //TDC_BIN   
 always@(posedge Sys_Clk or negedge Reset)
    if(Reset == 1'b1)
        begin       
            TDC_DATA_BIN_A              <= 12'd0;
            TDC_DATA_BIN_A_Valid        <= 1'b0;
            TDC_DATA_BIN_B              <= 12'd0;
            TDC_DATA_BIN_B_Valid        <= 1'b0;   
            
             TDC_DATA_BIN_A_r              <= 12'd0;
            TDC_DATA_BIN_A_Valid_r        <= 1'b0;
            TDC_DATA_BIN_B_r              <= 12'd0;
            TDC_DATA_BIN_B_Valid_r        <= 1'b0;            
                        
            TDC_DATA_A                  <= 30'd0;
            TDC_DATA_A_Valid            <= 1'b0;
            TDC_DATA_B                  <= 30'd0;
            TDC_DATA_B_Valid            <= 1'b0; 
           TDC_Bin_r                            <= 4'd0;
            TDC_Bin_r1                          <= 4'd0;                
            
            TDC_DATA_A1_r                   <= 12'd0;
            TDC_DATA_A_Valid1_r             <= 1'b0;
            TDC_DATA_B1_r                   <= 12'd0;
            TDC_DATA_B_Valid1_r             <= 1'b0; 
            
            TDC_DATA_A2_r                   <= 12'd0;
            TDC_DATA_A_Valid2_r             <= 1'b0;
            TDC_DATA_B2_r                   <= 12'd0;
            TDC_DATA_B_Valid2_r             <= 1'b0;
 
            TDC_DATA_A3_r                   <= 12'd0;
            TDC_DATA_A_Valid3_r             <= 1'b0;
            TDC_DATA_B3_r                   <= 12'd0;
            TDC_DATA_B_Valid3_r             <= 1'b0;
            
            TDC_DATA_A4_r                   <= 12'd0;
            TDC_DATA_A_Valid4_r             <= 1'b0;
            TDC_DATA_B4_r                   <= 12'd0;
            TDC_DATA_B_Valid4_r             <= 1'b0;           
            
            TDC_DATA_A5_r                   <= 12'd0;
            TDC_DATA_A_Valid5_r             <= 1'b0;
            TDC_DATA_B5_r                   <= 12'd0;
            TDC_DATA_B_Valid5_r             <= 1'b0;
            
            TDC_DATA_A6_r                   <= 12'd0;
            TDC_DATA_A_Valid6_r             <= 1'b0;
            TDC_DATA_B6_r                   <= 12'd0;
            TDC_DATA_B_Valid6_r             <= 1'b0;           
                       
            TDC_DATA_A7_r                   <= 12'd0;
            TDC_DATA_A_Valid7_r             <= 1'b0;
            TDC_DATA_B7_r                   <= 12'd0;
            TDC_DATA_B_Valid7_r             <= 1'b0;
            
            TDC_DATA_A8_r                   <= 12'd0;
            TDC_DATA_A_Valid8_r             <= 1'b0;
            TDC_DATA_B8_r                   <= 12'd0;
            TDC_DATA_B_Valid8_r             <= 1'b0;          
            
            TDC_DATA_A9_r                   <= 12'd0;
            TDC_DATA_A_Valid9_r             <= 1'b0;
            TDC_DATA_B9_r                   <= 12'd0;
            TDC_DATA_B_Valid9_r             <= 1'b0;
            
            TDC_DATA_A10_r                   <= 12'd0;
            TDC_DATA_A_Valid10_r             <= 1'b0;
            TDC_DATA_B10_r                   <= 12'd0;
            TDC_DATA_B_Valid10_r             <= 1'b0;         
                      
          
            TDC_DATA_A11_r                   <= 12'd0;
            TDC_DATA_A_Valid11_r             <= 1'b0;
            TDC_DATA_B11_r                   <= 12'd0;
            TDC_DATA_B_Valid11_r             <= 1'b0; 
            
            TDC_DATA_A12_r                   <= 12'd0;
            TDC_DATA_A_Valid12_r             <= 1'b0;
            TDC_DATA_B12_r                   <= 12'd0;
            TDC_DATA_B_Valid12_r             <= 1'b0;
 
            TDC_DATA_A13_r                   <= 12'd0;
            TDC_DATA_A_Valid13_r             <= 1'b0;
            TDC_DATA_B13_r                   <= 12'd0;
            TDC_DATA_B_Valid13_r             <= 1'b0;
            
            TDC_DATA_A14_r                   <= 12'd0;
            TDC_DATA_A_Valid14_r             <= 1'b0;
            TDC_DATA_B14_r                   <= 12'd0;
            TDC_DATA_B_Valid14_r             <= 1'b0;           
            
            TDC_DATA_A15_r                   <= 12'd0;
            TDC_DATA_A_Valid15_r             <= 1'b0;
            TDC_DATA_B15_r                   <= 12'd0;
            TDC_DATA_B_Valid15_r             <= 1'b0;
            
            TDC_DATA_A16_r                   <= 12'd0;
            TDC_DATA_A_Valid16_r             <= 1'b0;
            TDC_DATA_B16_r                   <= 12'd0;
            TDC_DATA_B_Valid16_r             <= 1'b0;           
                       
            TDC_DATA_A17_r                   <= 12'd0;
            TDC_DATA_A_Valid17_r             <= 1'b0;
            TDC_DATA_B17_r                   <= 12'd0;
            TDC_DATA_B_Valid17_r             <= 1'b0;
            
            TDC_DATA_A18_r                   <= 12'd0;
            TDC_DATA_A_Valid18_r             <= 1'b0;
            TDC_DATA_B18_r                   <= 12'd0;
            TDC_DATA_B_Valid18_r             <= 1'b0;          
            
            TDC_DATA_A19_r                   <= 12'd0;
            TDC_DATA_A_Valid19_r             <= 1'b0;
            TDC_DATA_B19_r                   <= 12'd0;
            TDC_DATA_B_Valid19_r             <= 1'b0;
            
      
          
                               
        end  
    else
        begin
           if(Conforms_Counting_mode_1_r1 == 1'b1)
                begin
                    TDC_DATA_A                  <= Conforms_Counting_data_1[29:0];
                    TDC_DATA_A_Valid            <= Conforms_Counting_data_Valid_1;
                    TDC_DATA_B                  <= 30'd0;
                    TDC_DATA_B_Valid            <= 1'b0;  
                    
                    TDC_DATA_BIN_A              <= TDC_DATA_A;
                    TDC_DATA_BIN_A_Valid        <= TDC_DATA_A_Valid;
                    TDC_DATA_BIN_B              <= 32'd0;
                    TDC_DATA_BIN_B_Valid        <= TDC_DATA_BIN_B_Valid_r;   
                    
                    
//                     TDC_DATA_BIN_A             <= TDC_DATA_A[15:4];
//                     if(TDC_DATA_A<30'd65536)
//                         TDC_DATA_BIN_A_Valid        <= TDC_DATA_A_Valid;  
//                     else
//                        TDC_DATA_BIN_A_Valid        <= 1'b0;              
                                    
                                  
                end
           else
                begin
                    TDC_DATA_A                  <= T3_DATA_A_r[29:0];
                    TDC_DATA_A_Valid            <= T3_DATA_A_Valid_r;
                    TDC_DATA_B                  <= T3_DATA_B_r[29:0];
                    TDC_DATA_B_Valid            <= T3_DATA_B_Valid_r; 
                    
//                    TDC_DATA_BIN_A              <= TDC_DATA_BIN_A_r;
//                    TDC_DATA_BIN_A_Valid        <= TDC_DATA_BIN_A_Valid_r;
//                    TDC_DATA_BIN_B              <= TDC_DATA_BIN_B_r;
//                    TDC_DATA_BIN_B_Valid        <= TDC_DATA_BIN_B_Valid_r;        
                end

   

                      TDC_DATA_BIN_A              <= TDC_DATA_BIN_A_r;
                    TDC_DATA_BIN_A_Valid        <= TDC_DATA_BIN_A_Valid_r;
                    TDC_DATA_BIN_B              <= TDC_DATA_BIN_B_r;
                    TDC_DATA_BIN_B_Valid        <= TDC_DATA_BIN_B_Valid_r;   
 
    
    
    
            TDC_Bin_r                           <= TDC_Bin;
            TDC_Bin_r1                          <= TDC_Bin_r;   
             
            TDC_DATA_A1_r                   <= TDC_DATA_A1;
            TDC_DATA_A_Valid1_r             <= TDC_DATA_A_Valid1;
            TDC_DATA_B1_r                   <= TDC_DATA_B1;
            TDC_DATA_B_Valid1_r             <= TDC_DATA_B_Valid1;              
             
                               
            TDC_DATA_A2_r                   <= TDC_DATA_A2;
            TDC_DATA_A_Valid2_r             <= TDC_DATA_A_Valid2;
            TDC_DATA_B2_r                   <= TDC_DATA_B2;
            TDC_DATA_B_Valid2_r             <= TDC_DATA_B_Valid2;                 

            TDC_DATA_A3_r                   <= TDC_DATA_A3;
            TDC_DATA_A_Valid3_r             <= TDC_DATA_A_Valid3;
            TDC_DATA_B3_r                   <= TDC_DATA_B3;
            TDC_DATA_B_Valid3_r             <= TDC_DATA_B_Valid3;  

            TDC_DATA_A4_r                   <= TDC_DATA_A4;
            TDC_DATA_A_Valid4_r             <= TDC_DATA_A_Valid4;
            TDC_DATA_B4_r                   <= TDC_DATA_B4;
            TDC_DATA_B_Valid4_r             <= TDC_DATA_B_Valid4;  
            
            TDC_DATA_A5_r                   <= TDC_DATA_A5;
            TDC_DATA_A_Valid5_r             <= TDC_DATA_A_Valid5;
            TDC_DATA_B5_r                   <= TDC_DATA_B5;
            TDC_DATA_B_Valid5_r             <= TDC_DATA_B_Valid5;              
            
            TDC_DATA_A6_r                   <= TDC_DATA_A6;
            TDC_DATA_A_Valid6_r             <= TDC_DATA_A_Valid6;
            TDC_DATA_B6_r                   <= TDC_DATA_B6;
            TDC_DATA_B_Valid6_r             <= TDC_DATA_B_Valid6;              

            TDC_DATA_A7_r                   <= TDC_DATA_A7;
            TDC_DATA_A_Valid7_r             <= TDC_DATA_A_Valid7;
            TDC_DATA_B7_r                   <= TDC_DATA_B7;
            TDC_DATA_B_Valid7_r             <= TDC_DATA_B_Valid7;  
            
            TDC_DATA_A8_r                   <= TDC_DATA_A8;
            TDC_DATA_A_Valid8_r             <= TDC_DATA_A_Valid8;
            TDC_DATA_B8_r                   <= TDC_DATA_B8;
            TDC_DATA_B_Valid8_r             <= TDC_DATA_B_Valid8;              
            
            TDC_DATA_A9_r                   <= TDC_DATA_A9;
            TDC_DATA_A_Valid9_r             <= TDC_DATA_A_Valid9;
            TDC_DATA_B9_r                   <= TDC_DATA_B9;
            TDC_DATA_B_Valid9_r             <= TDC_DATA_B_Valid9;            
            
            TDC_DATA_A10_r                   <= TDC_DATA_A10;
            TDC_DATA_A_Valid10_r             <= TDC_DATA_A_Valid10;
            TDC_DATA_B10_r                   <= TDC_DATA_B10;
            TDC_DATA_B_Valid10_r             <= TDC_DATA_B_Valid10;  
            
            TDC_DATA_A11_r                   <= TDC_DATA_A11;
            TDC_DATA_A_Valid11_r             <= TDC_DATA_A_Valid11;
            TDC_DATA_B11_r                   <= TDC_DATA_B11;
            TDC_DATA_B_Valid11_r             <= TDC_DATA_B_Valid11;              
             
                               
            TDC_DATA_A12_r                   <= TDC_DATA_A12;
            TDC_DATA_A_Valid12_r             <= TDC_DATA_A_Valid12;
            TDC_DATA_B12_r                   <= TDC_DATA_B12;
            TDC_DATA_B_Valid12_r             <= TDC_DATA_B_Valid12;                 

            TDC_DATA_A13_r                   <= TDC_DATA_A13;
            TDC_DATA_A_Valid13_r             <= TDC_DATA_A_Valid13;
            TDC_DATA_B13_r                   <= TDC_DATA_B13;
            TDC_DATA_B_Valid13_r             <= TDC_DATA_B_Valid13;  

            TDC_DATA_A14_r                   <= TDC_DATA_A14;
            TDC_DATA_A_Valid14_r             <= TDC_DATA_A_Valid14;
            TDC_DATA_B14_r                   <= TDC_DATA_B14;
            TDC_DATA_B_Valid14_r             <= TDC_DATA_B_Valid14;  
            
            TDC_DATA_A15_r                   <= TDC_DATA_A15;
            TDC_DATA_A_Valid15_r             <= TDC_DATA_A_Valid15;
            TDC_DATA_B15_r                   <= TDC_DATA_B15;
            TDC_DATA_B_Valid15_r             <= TDC_DATA_B_Valid15;              
            
            TDC_DATA_A16_r                   <= TDC_DATA_A16;
            TDC_DATA_A_Valid16_r             <= TDC_DATA_A_Valid16;
            TDC_DATA_B16_r                   <= TDC_DATA_B16;
            TDC_DATA_B_Valid16_r             <= TDC_DATA_B_Valid16;              

            TDC_DATA_A17_r                   <= TDC_DATA_A17;
            TDC_DATA_A_Valid17_r             <= TDC_DATA_A_Valid17;
            TDC_DATA_B17_r                   <= TDC_DATA_B17;
            TDC_DATA_B_Valid17_r             <= TDC_DATA_B_Valid17;  
            
            TDC_DATA_A18_r                   <= TDC_DATA_A18;
            TDC_DATA_A_Valid18_r             <= TDC_DATA_A_Valid18;
            TDC_DATA_B18_r                   <= TDC_DATA_B18;
            TDC_DATA_B_Valid18_r             <= TDC_DATA_B_Valid18;              
            
            TDC_DATA_A19_r                   <= TDC_DATA_A19;
            TDC_DATA_A_Valid19_r             <= TDC_DATA_A_Valid19;
            TDC_DATA_B19_r                   <= TDC_DATA_B19;
            TDC_DATA_B_Valid19_r             <= TDC_DATA_B_Valid19;            
            

            
                       
            

                TDC_DATA_A1              <= TDC_DATA_A[11:0];
                   if(TDC_DATA_A<30'd4096)
                      TDC_DATA_A_Valid1        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid1        <= 1'b0;    

                TDC_DATA_B1              <= TDC_DATA_B[11:0];
                  if(TDC_DATA_B<30'd4096)
                      TDC_DATA_B_Valid1        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid1        <= 1'b0;    


                 TDC_DATA_A2              <= TDC_DATA_A[12:1];        
                   if(TDC_DATA_A<30'd8192)
                      TDC_DATA_A_Valid2        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid2        <= 1'b0;    

                 TDC_DATA_B2              <= TDC_DATA_B[12:1];
                 if(TDC_DATA_B<30'd8192)
                      TDC_DATA_B_Valid2        <= TDC_DATA_B_Valid;  
                 else
                      TDC_DATA_B_Valid2        <= 1'b0;    
           
            
                TDC_DATA_A3              <= TDC_DATA_A[13:2];

                   if(TDC_DATA_A<30'd16384)
             
                      TDC_DATA_A_Valid3        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid3        <= 1'b0;    

            TDC_DATA_B3              <= TDC_DATA_B[13:2];
                  if(TDC_DATA_B<30'd16384)
                      TDC_DATA_B_Valid3        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid3        <= 1'b0;    
                
            TDC_DATA_A4              <= TDC_DATA_A[14:3];
               if(TDC_DATA_A<30'd32768)
                      TDC_DATA_A_Valid4        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid4        <= 1'b0;    

            TDC_DATA_B4              <= TDC_DATA_B[14:3];
              if(TDC_DATA_B<30'd32768)
                      TDC_DATA_B_Valid4        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid4        <= 1'b0;    
                 
             TDC_DATA_A5             <= TDC_DATA_A[15:4];
                 if(TDC_DATA_A<30'd65536)
                      TDC_DATA_A_Valid5        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid5        <= 1'b0;    

            TDC_DATA_B5              <= TDC_DATA_B[15:4];
                 if(TDC_DATA_B<30'd65536)
                      TDC_DATA_B_Valid5        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid5        <= 1'b0;                  
            TDC_DATA_A6              <= TDC_DATA_A[16:5];
                 if(TDC_DATA_A<30'd131072)
                      TDC_DATA_A_Valid6        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid6        <= 1'b0;    

            TDC_DATA_B6             <= TDC_DATA_B[16:5];
                 if(TDC_DATA_B<30'd131072)
                      TDC_DATA_B_Valid6        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid6        <= 1'b0;    
               
                TDC_DATA_A7              <= TDC_DATA_A[17:6];
                 if(TDC_DATA_A<30'd262144)
                      TDC_DATA_A_Valid7        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid7        <= 1'b0;    

             TDC_DATA_B7              <= TDC_DATA_B[17:6];
                 if(TDC_DATA_B<30'd262144)
                      TDC_DATA_B_Valid7        <= TDC_DATA_B_Valid;  
                 else

                        TDC_DATA_B_Valid7        <= 1'b0;    
                  TDC_DATA_A8              <= TDC_DATA_A[18:7];                          
  
                    if(TDC_DATA_A<30'd524288)   
                      TDC_DATA_A_Valid8        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid8        <= 1'b0;    

                 TDC_DATA_B8              <= TDC_DATA_B[18:7];
                if(TDC_DATA_B<30'd524288)                
                      TDC_DATA_B_Valid8        <= TDC_DATA_B_Valid;  
                 else

                        TDC_DATA_B_Valid8        <= 1'b0;    
          
              TDC_DATA_A9             <= TDC_DATA_A[19:8];
                  if(TDC_DATA_A<30'd1048576)
                      TDC_DATA_A_Valid9        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid9        <= 1'b0;    
             TDC_DATA_B9              <= TDC_DATA_B[19:8];
 
                 if(TDC_DATA_B<30'd1048576)
                      TDC_DATA_B_Valid9        <= TDC_DATA_B_Valid;  
                 else

                        TDC_DATA_B_Valid9        <= 1'b0;    
                            
                 TDC_DATA_A10              <= TDC_DATA_A[20:9];
                  if(TDC_DATA_A<30'd2097152)
                      TDC_DATA_A_Valid10        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid10        <= 1'b0;    
          
             TDC_DATA_B10              <= TDC_DATA_B[20:9];
                 if(TDC_DATA_B<30'd2097152)
                      TDC_DATA_B_Valid10        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid10        <= 1'b0;                    
                 TDC_DATA_A11              <= TDC_DATA_A[21:10];
                  if(TDC_DATA_A<30'd4194304)
                      TDC_DATA_A_Valid11        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid11        <= 1'b0;    

                 TDC_DATA_B11              <= TDC_DATA_B[21:10];
                 if(TDC_DATA_B<30'd4194304)
                      TDC_DATA_B_Valid11        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid11        <= 1'b0;    
      
                TDC_DATA_A12              <= TDC_DATA_A[22:11];
                  if(TDC_DATA_A<30'd8388608)
                      TDC_DATA_A_Valid12        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid12        <= 1'b0;    

                TDC_DATA_B12              <= TDC_DATA_B[22:11];
                 if(TDC_DATA_B<30'd8388608)
                      TDC_DATA_B_Valid12        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid12        <= 1'b0;    
          
                 TDC_DATA_A13              <= TDC_DATA_A[23:12];
                  if(TDC_DATA_A<30'd16777216)   
                      TDC_DATA_A_Valid13        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid13        <= 1'b0;    
                TDC_DATA_B13             <= TDC_DATA_B[23:12];
 
                 if(TDC_DATA_B<30'd16777216)
                      TDC_DATA_B_Valid13        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid13        <= 1'b0;    
               TDC_DATA_A14              <= TDC_DATA_A[24:13];

                if(TDC_DATA_A<30'd33554432)
                      TDC_DATA_A_Valid14        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid14        <= 1'b0;    
                 TDC_DATA_B14             <= TDC_DATA_B[24:13];
 
                 if(TDC_DATA_B<30'd33554432)
                      TDC_DATA_B_Valid14        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid14        <= 1'b0;    
                      
                TDC_DATA_A15              <= TDC_DATA_A[25:14];
                if(TDC_DATA_A<30'd67108864)
                      TDC_DATA_A_Valid15        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid15        <= 1'b0;    
                TDC_DATA_B15              <= TDC_DATA_B[25:14];
                 if(TDC_DATA_B<30'd67108864)
                      TDC_DATA_B_Valid15        <= TDC_DATA_B_Valid;  
                 else

                        TDC_DATA_B_Valid15        <= 1'b0;    
                
                    TDC_DATA_A16             <= TDC_DATA_A[26:15];
                if(TDC_DATA_A<30'd134217728)                 
                      TDC_DATA_A_Valid16        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid16        <= 1'b0;    
                TDC_DATA_B16              <= TDC_DATA_B[26:15];
                 if(TDC_DATA_B<30'd134217728)
                      TDC_DATA_B_Valid16        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid16        <= 1'b0;    
        
  
                TDC_DATA_A17              <= TDC_DATA_A[27:16];
                if(TDC_DATA_A<30'd268435456)
                      TDC_DATA_A_Valid17        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid17        <= 1'b0;    
 
                TDC_DATA_B17              <= TDC_DATA_B[27:16];
                 if(TDC_DATA_B<30'd268435456)
                      TDC_DATA_B_Valid17        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid17        <= 1'b0;    
          
                     TDC_DATA_A18             <= TDC_DATA_A[28:17];
                if(TDC_DATA_A<30'd536870912)
                      TDC_DATA_A_Valid18        <= TDC_DATA_A_Valid;  
                 else
                        TDC_DATA_A_Valid18        <= 1'b0;    
             TDC_DATA_B18              <= TDC_DATA_B[28:17];
 
                 if(TDC_DATA_B<30'd536870912)
                      TDC_DATA_B_Valid18        <= TDC_DATA_B_Valid;  
                 else
  
                        TDC_DATA_B_Valid18        <= 1'b0;    
                        
     
                    TDC_DATA_A19              <= TDC_DATA_A[29:18];         
                if(TDC_DATA_A<31'd1073741824)
                      TDC_DATA_A_Valid19        <= TDC_DATA_A_Valid;  
                 else

                        TDC_DATA_A_Valid19        <= 1'b0;    

                TDC_DATA_B19              <= TDC_DATA_B[29:18];
                 if(TDC_DATA_B<31'd1073741824)
                      TDC_DATA_B_Valid19        <= TDC_DATA_B_Valid;  
                 else
                        TDC_DATA_B_Valid19        <= 1'b0;    
                         
   

                          
         case(TDC_Bin_r1)
        5'd0:
            begin             
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A1_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid1_r;  
                
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B1_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid1_r;  
            end
        5'd1:
            begin           
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A2_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid2_r;  

                      TDC_DATA_BIN_B_r              <= TDC_DATA_B2_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid2_r;  
            end
         5'd2:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A3_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid3_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B3_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid3_r;                 
            end
         5'd3:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A4_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid4_r;                 
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B4_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid4_r;                
            end
          5'd4:
            begin
        
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A5_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid5_r;               
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B5_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid5_r;  
                
            end
          5'd5:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A6_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid6_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B6_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid6_r;  
              
            end
          5'd6:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A7_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid7_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B7_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid7_r;  
                                   
            end
           5'd7:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A8_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid8_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B8_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid8_r;              
            end
           5'd8:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A9_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid9_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B9_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid9_r;                       
            end
           5'd9:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A10_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid10_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B10_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid10_r;                 
            end
           5'd10:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A11_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid11_r;               
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B11_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid11_r;         
            end
           5'd11:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A12_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid12_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B12_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid12_r;           
            end
           5'd12:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A13_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid13_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B13_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid13_r;         
            end
           5'd13:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A14_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid14_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B14_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid14_r;                  
            end
           5'd14:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A15_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid15_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B15_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid15_r;                 
            end
           5'd15:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A16_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid16_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B16_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid16_r;           
            end
           5'd16:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A17_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid17_r;  
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B17_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid17_r;            
            end
           5'd17:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A18_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid18_r;                 
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B18_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid18_r;          
            end
           5'd18:
            begin
                      TDC_DATA_BIN_A_r              <= TDC_DATA_A19_r;
                      TDC_DATA_BIN_A_Valid_r        <= TDC_DATA_A_Valid19_r;                   
                      TDC_DATA_BIN_B_r              <= TDC_DATA_B19_r;
                      TDC_DATA_BIN_B_Valid_r        <= TDC_DATA_B_Valid19_r;                 
            end

           default:
            begin
            end
            endcase           
            
   
            
        end  
      
        
 
endmodule
