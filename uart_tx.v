`timescale 1ns / 1ps

module uart_tx(
input clk,
input write_enable,
input reset,
input tx_enable,
input [7:0]data_in,

output reg tx,
output busy,
output tx_rdy

    );
 parameter idle_state=2'd0;
 parameter start_state =2'd1;
 parameter data_state=2'd2;
 parameter stop_state=2'd3;
 
 
 reg [7:0]data;
 reg [2:0]index;
 reg [1:0]state; 
 
 
 always @(posedge clk)
 begin
 
 if (reset)
 begin
    tx<=1'b1;
    state<=idle_state;
    index<=3'd0;
    data<=8'd0;
    
 end
 else begin
        case(state)
            idle_state:
             begin
                tx<=1'b1;
                if(write_enable&&tx_rdy)
                  begin
                    state<=start_state;
                    data<=data_in;
                    index<=3'b0;
                  end
             end
             
            start_state:
            begin
                if(tx_enable)
                begin
                    tx<=1'b0;
                    state<=data_state;
                end
             end
             
             data_state:
             begin
                if(tx_enable)
                begin
                    tx<=data[index];
                    if(index==3'd7)
                        state<=stop_state;
                    else
                        index<=index+3'd1;
                    end
                 end
             
             stop_state:
             begin
                if(tx_enable) 
                begin
                    tx<=1'b1;
                    state<=idle_state;
                end
             end
                
              default:
                begin
                    tx<=1'b1;
                    state<=idle_state;
                end
          endcase
          
       end
  end
  
assign busy =(state !=idle_state);
assign tx_rdy=~(busy);
endmodule