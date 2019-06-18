`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:01 04/15/2019 
// Design Name: 
// Module Name:    changeOverallStatus 
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
module changeOverallStatus(tempGateStatus, currentIndex, changeButton, passwordUnlockAttempt, currentPasswordRequiredToUnlock, newGateStatus, newIndex, changeUpdatePassword);

	input [2:0] tempGateStatus;
	input [1:0] currentIndex;
	
	input changeButton;
	
	input [15:0] passwordUnlockAttempt;
	input [15:0] currentPasswordRequiredToUnlock;
	
	output reg [15:0] changeUpdatePassword;
	
	output reg [2:0] newGateStatus;
	output reg [1:0] newIndex;
	
/*

	0 - gate is CLOSED
	1 - gate is OPEN
	2 - gate is IDLE
	3 - gate is ENTER_PASSWORD
	4 - gate is CHANGE_PASSWORD
	5 - gate is LOCKING
	6 - gate is SCROLLING

	*/
	
	always@(posedge changeButton) begin
		changeUpdatePassword <= currentPasswordRequiredToUnlock;
		case(tempGateStatus)
		//IF GATE IS OPEN, WE CAN GO TO CHANGE PASSWORD STATE
			3'd1: begin
				newGateStatus <= 3'd4;
				newIndex <= 2'd0;
			end
			//IF USER IS TRYING TO LOCK IT, THEY CAN DECIDE TO CHANGE PASSWORD
			3'd5: begin
				newGateStatus <= 3'd4;
				newIndex <= 2'd0;
			end
			//OTHERWISE THE CHANGEBUTTON DOES NOTHING
			default: begin
				newGateStatus <= tempGateStatus;
				newIndex <= currentIndex;
			end
		endcase
	end


endmodule
