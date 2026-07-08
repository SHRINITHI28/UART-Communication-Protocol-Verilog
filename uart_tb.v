`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2026 18:28:56
// Design Name: 
// Module Name: uart_tb
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

module uart_tb;

reg clk;
reg reset;
reg write_enable;
reg [7:0] data_in;
reg rdy_clr;

wire tx;
wire busy;
wire tx_rdy;
wire rdy;
wire [7:0] data_out;

uart_top uut(

    .clk(clk),
    .reset(reset),
    .write_enable(write_enable),
    .data_in(data_in),
    .rdy_clr(rdy_clr),

    .tx(tx),
    .busy(busy),
    .tx_rdy(tx_rdy),
    .rdy(rdy),
    .data_out(data_out)

);


always #10 clk = ~clk;


initial
begin

$monitor("Time=%0t | DATA_IN=%h | TX=%b | BUSY=%b | READY=%b | DATA_OUT=%h",

$time,
data_in,
tx,
busy,
rdy,
data_out);

end

//-------------------------------
// Test Sequence
//-------------------------------

initial
begin

    clk = 0;
    reset = 1;
    write_enable = 0;
    data_in = 8'h00;
    rdy_clr = 0;

    // Reset
    #20;
    reset = 0;

    // Send First Data
    data_in = 8'h0E;
    write_enable = 1;
    #20;
    write_enable = 0;

    // Wait for Reception
    #1200000;

    // Clear Ready
    rdy_clr = 1;
    #20;
    rdy_clr = 0;

    // Send Second Data
    data_in = 8'hA1;
    write_enable = 1;
    #20;
    write_enable = 0;

    // Wait
    #1200000;

    $finish;

end

endmodule
