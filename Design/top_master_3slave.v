`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2022 19:03:16
// Design Name: 
// Module Name: top_master_3slave
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


module top_master_3slave(clk, load, rst, data_in,s0,s1,s2,enOut,enOut0,enOut1,enOut2,data_in_slave0,data_in_slave1,data_in_slave2,data_out_slave0,data_out_slave1,data_out_slave2,data_out_master);
// declaration of parameter
parameter n = 8;

//initializing input and output
input clk,rst, load,s0,s1,s2; //s0, s1, s2 are select lines for 3 different slaves
input [n-1:0]data_in;
input [n-1:0]data_in_slave0,data_in_slave1,data_in_slave2; //input for 3 different slave
output enOut;
reg MISO ;
output [n-1:0]data_out_slave0,data_out_slave1,data_out_slave2,data_out_master;
wire MISO0, MISO1,MISO2,MOSI,sck;
output enOut0,enOut1,enOut2;
master master(clk, load, rst, data_in, MISO,MOSI,data_out_master,enOut,sck);

//if we give same input to all the slaves then we will get multidriver error
slave slave1(sck, rst,load, MOSI,data_in_slave0,s0,enOut0, MISO0, data_out_slave0);
slave slave2(sck, rst,load, MOSI,data_in_slave1,s1,enOut1, MISO1, data_out_slave1);
slave slave3(sck, rst,load, MOSI,data_in_slave2,s2,enOut2, MISO2, data_out_slave2);

//selection of slave
always@* begin
    if(s0)
    begin
         MISO = MISO0;
    end
    else if(s1)
    begin
        MISO = MISO1;
    end
    else if(s2)
    begin
        MISO = MISO2;
    end
end
endmodule


