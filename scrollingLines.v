`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:41:49 04/16/2019 
// Design Name: 
// Module Name:    scrollingLines 
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
module scrollingLines(scrollingIndex, clk, scrollingLines);


	input clk;
	input [4:0] scrollingIndex;
	output reg [6:0] scrollingLines;
	
	// 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
	// _ _ _ _ I _ L O V E _  E  C  3  1  1  _   _ _ 
	always@(posedge clk) begin
	
	
	//YEAH THIS IS BAD CODING PRACTICES, BUT I JUST KNEW IT WOULD BE EASIER TO INDEX THROUGH THE LIST TO ARTIFICIALLY SCROLL
		case(scrollingIndex)
			5'b00000:
				scrollingLines <= 7'b1111111;
			5'b00001:
				scrollingLines <= 7'b1111111;
			5'b00010:
				scrollingLines <= 7'b1111111;
			5'b00011:
				scrollingLines <= 7'b1111111;
			5'b00100:
				scrollingLines <= 7'b1001111;
			5'b00101:
				scrollingLines <= 7'b1111111;
			5'b00110:
				scrollingLines <= 7'b1110001;
			5'b00111:
				scrollingLines <= 7'b0000001;
			5'b01000:
				scrollingLines <= 7'b1000001;
			5'b01001:
				scrollingLines <= 7'b0110000;
			5'b01010:
				scrollingLines <= 7'b1111111;
			5'b01011:
				scrollingLines <= 7'b0110000;
			5'b01100:
				scrollingLines <= 7'b0110001;
			5'b01101:
				scrollingLines <= 7'b0000110;
			5'b01110:
				scrollingLines <= 7'b1001111;
			5'b01111:
				scrollingLines <= 7'b1001111;
			5'b10000:
				scrollingLines <= 7'b1111111;
			5'b10001:
				scrollingLines <= 7'b1111111;
			5'b10010:
				scrollingLines <= 7'b1111111;	
			5'b10011:
				scrollingLines <= 7'b1111111;					
		endcase
	
	
	end


endmodule
