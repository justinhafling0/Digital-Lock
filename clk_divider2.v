`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:05:13 04/18/2019 
// Design Name: 
// Module Name:    clk_divider2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_divider2 (
  input clock_in,
  input reset,
  output reg clock_out
);

reg [1:0] count;

always@(posedge clock_in or posedge reset) begin
  if(reset) begin
    count <= 2'b00;
  end else begin
    count <= count + 1'b1;
  end
end

always@(posedge clock_in or posedge reset) begin
  if(reset) begin
    clock_out <= 1'b0;
  end else begin
    clock_out <= count[1];
  end
end

endmodule

