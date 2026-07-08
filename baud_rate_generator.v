`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2026 18:26:44
// Design Name: 
// Module Name: baud_rate_generator
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


module baud_rate_generator #(

parameter CLOCK_FREQ = 50000000,
parameter BAUD_RATE  = 9600,

parameter TX_DIV = CLOCK_FREQ / BAUD_RATE,
parameter RX_DIV = CLOCK_FREQ / (BAUD_RATE * 16)

)
(

input clk,
input reset,

output tx_enable,
output rx_enable

);

reg [12:0] tx_counter;
reg [8:0]  rx_counter;

always @(posedge clk)
begin
    if(reset)
        tx_counter <= 0;

    else if(tx_counter == TX_DIV-1)
        tx_counter <= 0;

    else
        tx_counter <= tx_counter + 1'b1;
end


always @(posedge clk)
begin
    if(reset)
        rx_counter <= 0;

    else if(rx_counter == RX_DIV-1)
        rx_counter <= 0;

    else
        rx_counter <= rx_counter + 1'b1;
end


assign tx_enable = (tx_counter == 0);
assign rx_enable = (rx_counter == 0);

endmodule
