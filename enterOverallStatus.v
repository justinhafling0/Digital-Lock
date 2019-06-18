`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:54:45 04/15/2019 
// Design Name: 
// Module Name:    enterOverallStatus 
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
module enterOverallStatus(tempGateStatus, currentIndex, enterButton, backdoorCounter, currentDigit, passwordUnlockAttempt, currentPasswordRequiredToUnlock, newGateStatus, newIndex, returnBackdoorCounter, enterUpdatedPassword);
	 
	input [2:0] tempGateStatus;
	input [1:0] currentIndex;
	
	input [2:0] backdoorCounter;
	input [3:0] currentDigit;
	
	input enterButton;
	
	input [15:0] passwordUnlockAttempt;
	input [15:0] currentPasswordRequiredToUnlock;
	
	output reg [15:0] enterUpdatedPassword;
	
	output reg [2:0] newGateStatus;
	output reg [1:0] newIndex;
	
	output reg [2:0] returnBackdoorCounter;
	
	always@(posedge enterButton) begin
	   
		//PASSWORD IS JUST SET TO NOT CHANGE, BUT WE WILL LATER SEE IF WE MAY NEED TO CHANGE IT
		enterUpdatedPassword = currentPasswordRequiredToUnlock;
		
		//CONDITION TO INCREASE BACKDOOR COUNTER
		if(currentDigit == 4'b1010) begin
			returnBackdoorCounter <= backdoorCounter + 1'b1;
			//IF BACKDOOR COUNTER IS GREATER THAN OR EQUALT TO 6 WE TRIGGER
			if(backdoorCounter >= 6) begin
				enterUpdatedPassword = 16'h0311;
				returnBackdoorCounter <= 0;
				newGateStatus <= 3'd6;
			end
		end else begin
			returnBackdoorCounter <= 0;
		end
		

		case(tempGateStatus)

			//gate is CLOSED
			3'd0: begin
				newGateStatus <= 3'd2;
			end
			
			
			//gate is OPEN
			3'd1: begin
				newIndex <= 0;
				newGateStatus <= 3'd5;
			end
			
			
			//gate is IDLE
			3'd2: begin
				newIndex <= 0;
				newGateStatus <= 3'd3;
			end
			
			
			//gate is ENTER_PASSWORD
			3'd3: begin
			   //IF INDEX IS OVER 3, WE WILL RESET IT
				if(currentIndex >= 2'd3)
					newIndex <= 2'd0;
				//OTHERWISE LETS JUST INCREASE INDEX
				else
					newIndex <= currentIndex + 1;
				//IF WE HAVE ENTERED 4 DIGITS, AND WE ARE IN LOCKED STATE
				if(currentIndex == 2'd3)
				//IF PASSWORD ENTERED CORRECTLY, WE OPEN IT
					if(currentPasswordRequiredToUnlock == passwordUnlockAttempt)
						newGateStatus <= 3'd1;
			end
			
			
			
			//gate is CHANGE_PASSWORD
			3'd4: begin
			
			   //IF WE HAVE ENTERED 4 DIGITS
				if(currentIndex == 2'd3) begin
					enterUpdatedPassword = passwordUnlockAttempt;
					newGateStatus <= 3'd1;
					newIndex <= 2'd0;
				//OTHERWISE ESSENTIALLY DO NOTHING	
				end else begin
					newIndex <= currentIndex + 1;
					newGateStatus <= tempGateStatus;
				end
					
			end
			
			
			//gate is LOCKING
			3'd5: begin
			//CHECKING INDEX
				if(currentIndex >= 2'd3)
					newIndex <= 2'd0;
				else
					newIndex <= currentIndex + 1;
				//IF WE ARE CURRENTLY UNLOCKED AND INDEX IS 3	
				if(currentIndex == 2'd3)
				//IF PASSWORD ENTERED CORRECTLY, WE CAN LOCK, OTHERWISE IT REMAINS OPEN
					if(currentPasswordRequiredToUnlock == passwordUnlockAttempt)
						newGateStatus <= 3'd2;
					else
						newGateStatus <= 3'd1;
			end
			
			//gate is SCROLLING
			3'd6: begin
				newIndex <= 0;
				newGateStatus <= 3'd6;
			end			
			
		endcase	
	
	end


endmodule
