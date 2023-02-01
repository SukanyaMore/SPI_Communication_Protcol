`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2022 19:04:06
// Design Name: 
// Module Name: master
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


module master(clk, load, rst, data_in, MISO,MOSI,data_out_master,enOut,sck);


parameter n = 8; //declaration of parameters to specify the size of the input and output data 
parameter m = 3; //declaration of parameters for the counter

//initializing input and output
input clk,rst, load, MISO;
input [n-1:0]data_in; //  input for master
output reg MOSI,enOut,sck; //enOut is signal which goes high when we get output data
output [n-1:0]data_out_master;//output of master after loading slave data into it.

reg [n-1:0]masterinput; //register to save data in master
reg [m-1:0]count = 0; // to calculate the clock cycle

always @(posedge sck or negedge rst)
begin
    // reset the output
    if(!rst)
    begin
        enOut = 0;
        count = 0;
    end
    else if(load)
    begin
        count=0; // count starts when data gets loaded in register
    end  
    else  begin    
        if(count == 7) // calculation of clock cycle and enabling signal after 8 clock cycles
        begin
            enOut  =1;
        end
        else   begin enOut  =0; end
        count = count +1;   
    end
end


always@(posedge sck)
begin
MOSI = masterinput[7]; //output of master is MSB of master register
masterinput = {masterinput,MISO}; //eliminating MSB of masterinput register and assigning MISO to the LSB of the masterinput

if(load)
    // data is getting loaded in masterinput and MOSI
    begin
    MOSI = data_in[7];
    masterinput = data_in;
    
    end
end

// when enable is high we will get output 
assign data_out_master = enOut? masterinput :0;


always@(posedge clk or negedge rst) // new clock with half frequency
begin
    if (!rst)
    begin
          sck =0;
    end
    else 
    begin      
        sck = ~sck ;     
    end
end
endmodule