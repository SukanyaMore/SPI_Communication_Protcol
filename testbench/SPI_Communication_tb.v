`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2022 19:13:59
// Design Name: 
// Module Name: SPI_Communication_tb
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


module SPI_Communication_tb();
// declaration of parameter
parameter n = 8;

//Initializing input
reg clk,rst, load,s0,s1,s2;
reg [n-1:0]data_in;
reg [n-1:0]data_in_slave0,data_in_slave1,data_in_slave2;

//Initializing output
wire enOut;
wire [n-1:0]data_out_slave0,data_out_slave1,data_out_slave2,data_out_master;
wire enOut0,enOut1,enOut2;

//top_master_3slave module is connecting master and slave module
//connecting to  top module
top_master_3slave m3s(clk, load, rst, data_in,s0,s1,s2,enOut,enOut0,enOut1,enOut2,data_in_slave0,data_in_slave1,data_in_slave2,data_out_slave0,data_out_slave1,data_out_slave2,data_out_master);


initial 
begin
clk =0; 
rst =1;

// input data for all modules
data_in <= 8'b0011_1101;
data_in_slave0 <= 8'b1101_1011;
data_in_slave1 <= 8'b0100_1010;
data_in_slave2 <= 8'b0001_1010;
#1;

//selecting slave01
s0 = 1;
rst =0;
load=1;

#1;
rst = 1;

#5;
load = 0;
s0 =1;
s1=0;
s2=0;

#40;
load = 1;

#5;
load = 0;
s0=0;
s1=1; //selecting slave02
s2=0;

#40;
load = 1;

#5;
load = 0;
s0=0;
s1=0;
s2=1; //selecting slave03

end
//generating clock cycle
always #1 clk = ~clk;


endmodule

