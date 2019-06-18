`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:06 04/15/2019 
// Design Name: 
// Module Name:    getPassword 
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
module getPassword(clk, oldPasswordUnlockAttempt, currentIndex, currentDigit, enterButton, gateStatus, passwordUnlockAttempt);

	input clk;
	input [15:0] oldPasswordUnlockAttempt;
	input [1:0] currentIndex;
	input [3:0] currentDigit;
	input [2:0] gateStatus;
	
	input enterButton;
	
	output reg [15:0] passwordUnlockAttempt;
	
	initial passwordUnlockAttempt = 16'hffff;
	
	always@(posedge clk) begin
		
		if(gateStatus == 3'd3 || gateStatus == 3'd5 || gateStatus == 3'd4) begin
			//WE WANT TO CHECK WHAT THE USER HAS CURRENTLY ENTERED AS AN ATTEMPT TO UNLOCK THE LOCK
			case(currentIndex)
				2'd0: 
					passwordUnlockAttempt[15:12] = currentDigit;
				2'd1:
					passwordUnlockAttempt[11:8] = currentDigit;
				2'd2:
					passwordUnlockAttempt[7:4] = currentDigit;
				2'd3:
					passwordUnlockAttempt[3:0] = currentDigit;
			endcase
		
		end else if(gateStatus == 3'd1) begin
			passwordUnlockAttempt = 16'hffff;
		end else begin
			passwordUnlockAttempt = 16'hffff;
		end
		
	end


endmodule
