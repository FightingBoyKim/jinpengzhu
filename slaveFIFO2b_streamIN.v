`timescale 1ns / 1ps

module slaveFIFO2b_streamIN(resetn,  clk_100,fdata,faddr,slrd,slwr,flaga,flagb,flagc,flagd,sloe, slcs, pktend,Fifo_Rd_En,Fifo_Rd_Data,Fifo_Empty,rd_data_count
);

input                           resetn;          	//input reset active low
input                           clk_100;                 //input clk 50 Mhz
inout[31:0]                     fdata;         //data bus
output [1:0]                    faddr;         //output fifo address  
output                          slrd;                 //output read select
output reg                      slwr;               //output write select
input                           flaga;               //full flag
input                           flagb;                //partial full flag
input                           flagc;               //empty flag
input                           flagd;                //empty partial flag
output                          sloe;                 //output output enable select
output                          slcs;                 //output chip select
output reg                      pktend;               //output pkt end
output reg                      Fifo_Rd_En;
input [31:0]                    Fifo_Rd_Data;
input                           Fifo_Empty;
input [13 : 0]                   rd_data_count;


reg [2:0]current_stream_in_state;
reg [2:0]next_stream_in_state;

//parameters for StreamIN mode state machine
parameter [2:0] stream_in_idle                    = 3'd0;
parameter [2:0] stream_in_wait_flagb              = 3'd1;
parameter [2:0] stream_in_write                   = 3'd2;
parameter [2:0] stream_in_write_wr_delay          = 3'd3;
parameter [2:0] stream_in_write_wr_delay1          = 3'd4;

reg  flaga_d;
reg  flagb_d;
reg  flagc_d;
reg  flagd_d;

// reg slwr_streamIN_d1_;

//output signal assignment 
assign slrd   = 1'b1;
// assign slwr   = slwr_streamIN_d1_;
assign faddr  = 2'd0;
assign sloe   = 1'b1;
assign fdata  = (slwr) ? 32'dz : Fifo_Rd_Data;
assign PMODE  = 2'b11;
// assign RESET  = 1'b1;
assign slcs   = 1'b0;
// assign pktend = 1'b1;


///flopping the INPUTs flags
always @(posedge clk_100, negedge resetn)
	if(resetn)
	   begin 
		  flaga_d             <=  1'd0;
		  flagb_d             <= 1'd0;
		  flagc_d             <= 1'd0;
		  flagd_d             <= 1'd0;
	   end 
	 else
	    begin
		  flaga_d             <=  flaga;
		  flagb_d             <=  flagb;
		  flagc_d             <=  flagc;
		  flagd_d             <= flagd;
	   end	


// assign slwr_streamIN_ = ((current_stream_in_state == stream_in_write)) ? 1'b0 : 1'b1;

// always @(posedge clk_100, negedge resetn)begin
// 	if(!resetn)begin 
// 		slwr_streamIN_d1_ <= 1'b1;
// 	end else begin
// 		slwr_streamIN_d1_ <= slwr_streamIN_;
// 	end	
// end


//streamIN mode state machine
always @(posedge clk_100, negedge resetn)
	if(resetn)
		current_stream_in_state       <= stream_in_idle;
	else
		current_stream_in_state       <=  next_stream_in_state;


reg [13:0]Wr_Cnt;
reg [2:0]Delay_Cnt;
//StreamIN mode state machine combo
//每次写256个32bits数据（1024Bytes一包）之后，回到空闲态，而不是根据标志信号决定什么时候回到空闲态
always @(*)begin
	next_stream_in_state = current_stream_in_state;
	case(current_stream_in_state)
	stream_in_idle:begin
		if(flaga_d == 1'b1)begin
			next_stream_in_state = stream_in_wait_flagb;
		end else begin
			next_stream_in_state = stream_in_idle;
		end	
	end
	stream_in_wait_flagb :begin

	//if (rd_data_count >= 14'd4096)begin
	if (rd_data_count >= 14'd1024)begin	
			next_stream_in_state = stream_in_write; 
		end else begin
			next_stream_in_state = stream_in_wait_flagb; 
		end
	end
	stream_in_write:begin
		if(Wr_Cnt >= 14'd1023)begin
	//		if(Wr_Cnt >= 14'd4095)begin
	//	if(Wr_Cnt >= USB_fifo_len-1)begin
			next_stream_in_state = stream_in_write_wr_delay;
		end else begin
		 	next_stream_in_state = stream_in_write;
		end
	end
	stream_in_write_wr_delay:begin
		if(Delay_Cnt >= 4'd5)
			next_stream_in_state = stream_in_idle;
		else
			next_stream_in_state = stream_in_write_wr_delay;
	end
	endcase
end

always @(posedge clk_100 or negedge resetn) 
	if(resetn)
		Delay_Cnt                     <= 4'd0;
	else if(current_stream_in_state == stream_in_write_wr_delay)
	    begin
		  if(Delay_Cnt >= 4'd5)
			 Delay_Cnt               <= Delay_Cnt;
		  else
			Delay_Cnt                <= Delay_Cnt + 1'b1;
	   end
	else
		Delay_Cnt                     <= 4'd0;


//pktend控制
always @(posedge clk_100 or negedge resetn) 
	if(resetn)
		pktend                        <= 1'b1;
	else if(Wr_Cnt == 14'd1023) 
	//else if(Wr_Cnt == 14'd4095) 
 //   else if(Wr_Cnt == USB_fifo_len-1) 
		pktend                         <= 1'b1;
	else
		pktend                        <= 1'b1;


//在进入stream_in_write之后，说明可以随意写入数据，此时从fifo中读取有效数据
always @(posedge clk_100, negedge resetn)
	if(resetn)
	   begin 
		  Fifo_Rd_En                  <= 1'b0;
		  slwr                        <=  1'b1;
		  Wr_Cnt                      <= 14'd0;
	end 
	else if(current_stream_in_state == stream_in_write) 
	   begin
		  if(Fifo_Empty == 1'b0) 
		      begin
			     Fifo_Rd_En            <=  1'b1;
			     slwr                  <=  1'b0;
			     Wr_Cnt                <= Wr_Cnt + 1'b1;
		      end
		else 
		      begin
			     Fifo_Rd_En            <= 1'b0;
			     slwr                  <= 1'b1;
			     Wr_Cnt                <= Wr_Cnt;
		      end
	   end
	else 
	   begin
		  Fifo_Rd_En                   <= 1'b0;
		  slwr                         <= 1'b1;
		  Wr_Cnt                       <= 14'd0;
	end
endmodule

