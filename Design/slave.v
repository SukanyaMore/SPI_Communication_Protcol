`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2022 19:11:49
// Design Name: 
// Module Name: slave
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


module slave(sck, rst,load, MOSI,data_in_slave,s,enOut, MISO, data_out_slave);

parameter n=8; //declaration of parameters to specify the size of the input and output data 
parameter m = 3; //declaration of parameters for the counter

//initializing input and output
input sck, rst, MOSI,s,load; // sck is master generated clock and s is playing the role of select line when it will be 1 then only slave will work
input [n-1:0]data_in_slave; //input for slave
output reg MISO,enOut; //enOut is signal which goes high when we get output data
output [n-1:0]data_out_slave; //output of slave after loading master data into it

reg [n-1:0]slaveinput; //register to save data in slave
reg [m-1:0]count =0; // to calculate the clock cycle

always @(posedge sck or negedge rst)
begin
    // reset the output
    if(!rst)
    begin
        enOut= 0;
        count=0;
    end
    else if(load) begin
            count =0; // count starts when data gets loaded in register
        end
    else if(s)
    begin
        if (count==7) // calculation of clock cycle and enabling signal after 8 clock cycles
        begin
            enOut  =1;
        end
        else   
        begin enOut  =0; 
        end
        count = count +1; 
    end    
end

always@(posedge sck)
begin
slaveinput  = {slaveinput, MOSI}; //eliminating MSB of slaveinput register and assigning MOSI to the LSB of the slaveinput
MISO = slaveinput[7]; //output of slave is MSB of master register
if(load)
    // data is getting loaded in slaveinput and MISO
    begin
    slaveinput = data_in_slave;
    MISO = data_in_slave[7];
    end
end

// when enable is high we will get output 
assign data_out_slave = enOut ? slaveinput:0;

endmodule


