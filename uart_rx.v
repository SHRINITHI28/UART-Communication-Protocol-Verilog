`timescale 1ns / 1ps

module uart_rx(

input clk,
input reset,
input rx,
input clk_enable,
input rdy_clr,

output reg rdy,
output reg [7:0] data_out

);

parameter start_state = 2'b00;
parameter data_state  = 2'b01;
parameter stop_state  = 2'b10;

reg [1:0] state;
reg [3:0] sample;
reg [2:0] index;
reg [7:0] temp_register;

always @(posedge clk)
begin

    if(reset)
    begin
        state <= start_state;
        rdy <= 1'b0;
        data_out <= 8'd0;
        sample <= 4'd0;
        index <= 3'd0;
        temp_register <= 8'd0;
    end

    else
    begin

        if(rdy_clr)
            rdy <= 1'b0;

        if(clk_enable)
        begin

            case(state)
            start_state:
            begin
                if(rx == 1'b0)          
                begin
                    sample <= sample + 1'b1;

                    if(sample == 4'd15)
                    begin
                        state <= data_state;
                        sample <= 4'd0;
                        index <= 3'd0;
                        temp_register <= 8'd0;
                    end
                end

                else
                    sample <= 4'd0;
            end

            data_state:
            begin

                sample <= sample + 1'b1;

                if(sample == 4'd8)
                begin
                    temp_register[index] <= rx;
                end

                if(sample == 4'd15)
                begin
                    sample <= 4'd0;

                    if(index == 3'd7)
                        state <= stop_state;
                    else
                        index <= index + 1'b1;
                end

            end
            
            stop_state:
            begin

                sample <= sample + 1'b1;

                if(sample == 4'd15)
                begin
                    state <= start_state;
                    sample <= 4'd0;

                    data_out <= temp_register;
                    rdy <= 1'b1;
                end

            end

        
            default:
                state <= start_state;

            endcase

        end

    end

end

endmodule