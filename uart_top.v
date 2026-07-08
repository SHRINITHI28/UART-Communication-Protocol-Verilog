
`timescale 1ns / 1ps

module uart_top(

input clk,
input reset,
input write_enable,
input [7:0] data_in,
input rdy_clr,

output tx,
output busy,
output tx_rdy,
output rdy,
output [7:0] data_out

);

wire tx_enable;
wire rx_enable;


baud_rate_generator bg(

    .clk(clk),
    .reset(reset),
    .tx_enable(tx_enable),
    .rx_enable(rx_enable)

);

uart_tx tx_unit(

    .clk(clk),
    .write_enable(write_enable),
    .reset(reset),
    .tx_enable(tx_enable),
    .data_in(data_in),

    .tx(tx),
    .busy(busy),
    .tx_rdy(tx_rdy)

);

uart_rx rx_unit(

    .clk(clk),
    .reset(reset),
    .rx(tx),       //loopback testbench          
    .clk_enable(rx_enable),
    .rdy_clr(rdy_clr),
    .rdy(rdy),
    .data_out(data_out)

);

endmodule