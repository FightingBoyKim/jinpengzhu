`timescale 1ns / 1ps

module I2C_Slave_Ctrl(Clk, Rst_n, I2C_SCL,I2C_SDA, RW_Cmd,Reg_Addr,W_Data,R_Data,W_Valid
);

input                           Clk;
input                           Rst_n;
input                           I2C_SCL;
inout                           I2C_SDA;
output reg                     RW_Cmd;
output reg  [7:0]              Reg_Addr;
output reg  [7:0]              W_Data;
input[7:0]                           R_Data;
output reg                     W_Valid;



parameter LOCAL_DEV_ID = 7'h5A;

reg I2C_SDA_OE;
wire I2C_SDA_I;
reg I2C_SDA_O;

assign I2C_SDA = ((~I2C_SDA_O) && I2C_SDA_OE) ? 1'b0 : 1'bZ;
assign I2C_SDA_I = I2C_SDA;

reg I2C_SDA_I_R0,I2C_SDA_I_R1;
wire SDA_Pos,SDA_Neg;

assign SDA_Pos = I2C_SDA_I_R0 & (~I2C_SDA_I_R1);
assign SDA_Neg = (~I2C_SDA_I_R0) & I2C_SDA_I_R1;

always @(posedge Clk or negedge Rst_n) 
begin
    if(Rst_n) begin
        I2C_SDA_I_R0 <= 1'b1;
        I2C_SDA_I_R1 <= 1'b1;
    end
    else begin
        I2C_SDA_I_R0 <= I2C_SDA_I;
        I2C_SDA_I_R1 <= I2C_SDA_I_R0;
    end

end

reg I2C_SCL_R0,I2C_SCL_R1;
wire SCL_Pos,SCL_Neg;
assign SCL_Pos = I2C_SCL_R0 & (~I2C_SCL_R1);
assign SCL_Neg = (~I2C_SCL_R0) & I2C_SCL_R1;

always @(posedge Clk or negedge Rst_n) 
begin
    if(Rst_n) begin
        I2C_SCL_R0 <= 1'b1;
        I2C_SCL_R1 <= 1'b1;
    end
    else begin
        I2C_SCL_R0 <= I2C_SCL;
        I2C_SCL_R1 <= I2C_SCL_R0;
    end
end


reg I2C_Start;//在起始位产生的时候，I2C_Start产生一个周期的高脉冲

//检测START位，SCL高时SDA拉低
always @(posedge Clk or negedge Rst_n) 
begin
    if(Rst_n)
        I2C_Start <= 1'b0;
    else if(I2C_SCL_R0 & SDA_Neg )
        I2C_Start <= 1'b1;
    else
        I2C_Start <= 1'b0;
end

reg I2C_Stop;//在停止位产生的时候，I2C_Stop产生一个周期的高脉冲

//检测STOP位，SCL高时SDA拉高
always @(posedge Clk or negedge Rst_n) 
begin
    if(Rst_n)
        I2C_Stop <= 1'b0;
    else if(I2C_SCL_R0 & SDA_Pos)
        I2C_Stop <= 1'b1;
    else
        I2C_Stop <= 1'b0;
end


reg [5:0]State;
localparam S_Idle  = 6'b000001;
localparam S_DevId = 6'b000010;
localparam S_Addr  = 6'b000100;
localparam S_Write = 6'b001000;
localparam S_Read  = 6'b010000;
localparam S_Stop  = 6'b100000;

reg [3:0]Cnt;
reg [6:0]DevId;

// ila_2 ila_2 (
// 	.clk(Clk), // input wire clk


// 	.probe0(I2C_SCL), // input wire [0:0]  probe0  
// 	.probe1(I2C_SDA), // input wire [0:0]  probe1 
// 	.probe2(RW_Cmd), // input wire [0:0]  probe2 
// 	.probe3(Reg_Addr), // input wire [7:0]  probe3 
// 	.probe4(W_Data), // input wire [7:0]  probe4 
// 	.probe5(R_Data), // input wire [7:0]  probe5 
// 	.probe6(W_Valid) // input wire [0:0]  probe6
// );

//状态机，暂时只支持单字节读写
//空闲态，器件ID，写地址，写数据，读数据
always @(posedge Clk or negedge Rst_n)
begin
    if(Rst_n) begin
        State <= S_Idle;
        Cnt <= 0;
        I2C_SDA_OE <= 1'b0;
        DevId <= 8'h00;
        Reg_Addr <= 8'h00;
        W_Data <= 8'h00;
        W_Valid <= 1'b0;
        RW_Cmd <= 1'b0;
    end
    else begin
        case (State)
            S_Idle: 
            begin
                W_Valid <= 1'b0;
                if(I2C_Start) begin
                    State <= S_DevId;
                    I2C_SDA_OE <= 1'b0;
                end
                else begin
                    State <= S_Idle;
                end
            end

            S_DevId: 
            begin
                if(SCL_Pos)begin
                    if(Cnt <= 6)begin
                        DevId[6-Cnt] <= I2C_SDA_I_R0;
                        Cnt <= Cnt + 1'b1;
                        State <= S_DevId;
                    end
                    else if(Cnt == 7) begin
                        RW_Cmd <= I2C_SDA_I_R0;
                        Cnt <= Cnt + 1'b1;
                        State <= S_DevId;
                    end
                end

                if((SCL_Neg) && (Cnt == 8)) begin
                    if(DevId == LOCAL_DEV_ID) begin //ACK
                        I2C_SDA_O <= 1'b0;
                        I2C_SDA_OE <= 1'b1;
                        Cnt <= Cnt + 1'b1;
                        State <= S_DevId;
                    end
                    else begin  //NACK
                        State <= S_Idle;
                        Cnt <= 0;
                    end
                end

                if((SCL_Neg) && (Cnt == 9)) begin
                    I2C_SDA_OE <= 1'b0;
                    if(RW_Cmd) begin
                        Cnt <= 1;
                        I2C_SDA_OE <= 1'b1;
                        I2C_SDA_O <= R_Data[7];
                        State <= S_Read;
                    end
                    else begin
                        Cnt <= 0;
                        State <= S_Addr;
                    end
                end
            end

            S_Addr: 
            begin
                if(SCL_Pos)begin
                    if(Cnt <= 7)begin
                        Reg_Addr[7-Cnt] <= I2C_SDA_I_R0;
                        Cnt <= Cnt + 1'b1;
                        State <= S_Addr;
                    end
                end

                if((SCL_Neg) && (Cnt == 8)) begin
                    I2C_SDA_O <= 1'b0;
                    I2C_SDA_OE <= 1'b1;
                    Cnt <= Cnt + 1'b1;
                    State <= S_Addr;
                end

                if((SCL_Neg) && (Cnt == 9)) begin
                    Cnt <= 0;
                    I2C_SDA_OE <= 1'b0;
                    State <= S_Write;   //默认是写
                end
            end

            S_Write: 
            begin
                if(I2C_Start) begin
                    Cnt <= 1'b0;
                    State <= S_DevId;
                end
                else if(SCL_Pos)begin
                    if(Cnt <= 7)begin
                        W_Data[7-Cnt] <= I2C_SDA_I_R0;
                        Cnt <= Cnt + 1'b1;
                        State <= S_Write;
                    end
                end

                if((SCL_Neg) && (Cnt == 8)) begin
                    I2C_SDA_O <= 1'b0;
                    I2C_SDA_OE <= 1'b1;
                    Cnt <= Cnt + 1'b1;
                    State <= S_Write;
                end

                if((SCL_Neg) && (Cnt == 9)) begin
                    Cnt <= 0;
                    I2C_SDA_OE <= 1'b0;
                    W_Valid <= 1'b1;
                    State <= S_Idle;
                end
            end

            S_Read: 
            begin
                if(SCL_Neg) begin
                    if(Cnt <= 7)begin
                        I2C_SDA_OE <= 1'b1;
                        I2C_SDA_O <= R_Data[7-Cnt];
                        Cnt <= Cnt + 1'b1;
                        State <= S_Read;
                    end
                    else begin
                        I2C_SDA_OE <= 1'b0;
                        Cnt <= 1'b0;
                        State <= S_Idle;
                    end
                end
            end

            default: begin
                State <= State;
                Cnt <= Cnt;
                I2C_SDA_OE <= I2C_SDA_OE;
                DevId <= DevId;
                Reg_Addr <= Reg_Addr;
                W_Data <= W_Data;
                W_Valid <= W_Valid;
                RW_Cmd <= RW_Cmd;
            end
        endcase
        
    end
end



endmodule
