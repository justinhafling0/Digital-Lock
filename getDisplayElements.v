`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:40 04/13/2019 
// Design Name: 
// Module Name:    getDisplayElements 
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
module getDisplayElements(clk, displayElements, gateStatus, currentIndex, currentDigit, displayElementsOut);

	input clk;
	input [15:0] displayElements;
	input [2:0] gateStatus;
	input [1:0] currentIndex;
	input [3:0] currentDigit;
	
	output reg [15:0] displayElementsOut;

	initial displayElementsOut <= 16'hC15D;


	always@(posedge clk) begin
		if(gateStatus == 3'd2)
			displayElementsOut <= 16'hC15D;
		if(gateStatus == 3'd3 || gateStatus == 3'd5 || gateStatus == 3'd4) begin
			case(currentIndex)
			
			//UPDATES DIGIT IN SLOTS BASED ON STATUS OF SWITCHES. WE NEED THIS FOR WHEN WE DISPLAY USER INPUTS
				2'd0:
					displayElementsOut[15:12] <= currentDigit;
				2'd1:
					displayElementsOut[11:8] <= currentDigit;
				2'd2:
					displayElementsOut[7:4] <= currentDigit;
				2'd3:
					displayElementsOut[3:0] <= currentDigit;
			endcase
		end
	end
	

endmodule
