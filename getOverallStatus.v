`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:08:14 04/15/2019 
// Design Name: 
// Module Name:    getOverallStatus 
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
module getOverallStatus(tempGateStatus, currentIndex, buttonINPUTS, backdoorCounter, currentDigit, finishedScrolling, clk, passwordUnlockAttempt, currentPasswordRequiredToUnlock, newGateStatus, newIndex, returnBackdoorCounter, updatedUnlockPassword);

	input [2:0] tempGateStatus;
	input [1:0] currentIndex;
	
	input [2:0] backdoorCounter;
	input [3:0] currentDigit;
	
	input [3:0] buttonINPUTS;
	input clk;
	
	input [15:0] passwordUnlockAttempt;
	input [15:0] currentPasswordRequiredToUnlock;
	
	input finishedScrolling;
	
	output reg [15:0] updatedUnlockPassword;
	
	//UPDATES PASSWORD IF WE NEED TO BASED ON BUTTON PUSHED
	wire [15:0] enterUpdatedUnlockPassword;
	wire [15:0] changeUpdatedUnlockPassword;
	wire [15:0] finishedScrollingUnlockPassword;
	
	//RETURN VALUES FROM MODULE THAT UPDATE VALUES FOR TOP MODULE TO SEE
	output reg [2:0] newGateStatus;
	output reg [1:0] newIndex;
	output reg [2:0] returnBackdoorCounter;
	
	//UPDATES GATE STATUS IF WE NEED TO BASED ON BUTTON PUSHED
	wire [2:0] enterButtonGateStatus;
	wire [2:0] changeButtonGateStatus;
	wire [2:0] finishedScrollingGateStatus;
	wire [2:0] clearButtonGateStatus;
	
	//UPDATES CURRENT INDEX IF WE NEED TO BASED ON BUTTON PUSHED
	wire [1:0] enterButtonIndex;
	wire [1:0] changeButtonIndex;
	wire [1:0] finishedScrollingIndex;
	
	//INCREMENTS BACKDOOR COUNTER IF WE NEED TO BASED ON BUTTON PUSHED
	wire [2:0] enterReturnBackdoorCounter;
		
/*

	0 - gate is CLOSED
	1 - gate is OPEN
	2 - gate is IDLE
	3 - gate is ENTER_PASSWORD
	4 - gate is CHANGE_PASSWORD
	5 - gate is LOCKING

*/
	
	//INITIALIZE VALUES
	initial newGateStatus <= 3'd2;
	initial newIndex <= 3'd0;
	
	//EACH FUNCTION HANDLES AN INSTANCE WHEN THE OVERALL STATE OF THE MACHINE CHANGES
	//OUR STATE MACHINE ONLY CHANGES WHEN A BUTTON IS PUSHED, AND OR WHEN SCROLLING TEXT IS FINISHED
	finishedScrollingStatus finishedScrollingStatus(tempGateStatus, finishedScrollingGateStatus); 
	enterOverallStatus enterOverallStatus(tempGateStatus, currentIndex, buttonINPUTS[1], backdoorCounter, currentDigit, passwordUnlockAttempt, currentPasswordRequiredToUnlock, enterButtonGateStatus, enterButtonIndex, enterReturnBackdoorCounter, enterUpdatedUnlockPassword);
	changeOverallStatus changeOverallStatus(tempGateStatus, currentIndex, buttonINPUTS[0], passwordUnlockAttempt, currentPasswordRequiredToUnlock, changeButtonGateStatus, changeButtonIndex, changeUpdatedUnlockPassword);
	
	always@(posedge clk) begin
	
		//IF THE ENTER BUTTON WAS PUSHED, WE UPDATE IT TO THE NEXT STATE BASED ON ENTER BUTTON CALCULATIONS IN SEPERATE MODULE
		if(buttonINPUTS[1] == 1'b1) begin
			newGateStatus <= enterButtonGateStatus;
			newIndex <= enterButtonIndex;
			returnBackdoorCounter <= enterReturnBackdoorCounter;
			updatedUnlockPassword <= enterUpdatedUnlockPassword;
			
		//IF THE CHANGE BUTTON WAS PUSHED, WE UPDATE IT TO THE NEXT STATE BASED ON CHANGE BUTTON CALCULATIONS IN SEPERATE MODULE			
		end else if(buttonINPUTS[0] == 1'b1) begin
			newGateStatus <= changeButtonGateStatus;
			newIndex <= changeButtonIndex;
			returnBackdoorCounter <= 0;
			updatedUnlockPassword <= changeUpdatedUnlockPassword;
			
		//IF THE RESET BUTTON WAS PUSHED, WE UPDATE IT TO THE NEXT STATE BASED ON RESET BUTTON CALCULATIONS IN SEPERATE MODULE
		end else if(buttonINPUTS[2] == 1'b1) begin
			newGateStatus <= 3'd2;
			newIndex <= 0;
			returnBackdoorCounter <= 0;
			updatedUnlockPassword <= 16'h0000;
			
		//IF THE FINISHED FLAG WAS TRIGGERED WE UPDATE IT TO THE NEXT STATE BASED ON FLAG CALCULATIONS IN SEPERATE MODULE			
		end else if(finishedScrolling) begin
			newGateStatus <= finishedScrollingGateStatus;
			newIndex <= 0;
			returnBackdoorCounter <= backdoorCounter;
			updatedUnlockPassword <= currentPasswordRequiredToUnlock;

		//IF THE CLEAR BUTTON WAS PUSHED, WE UPDATE IT TO THE NEXT STATE BASED ON CLEAR BUTTON CALCULATIONS IN SEPERATE MODULE
		end else if (buttonINPUTS[3] == 1) begin
			newGateStatus <= tempGateStatus;
			newIndex <= 0;
			returnBackdoorCounter <= backdoorCounter;
			updatedUnlockPassword <= currentPasswordRequiredToUnlock;
			
		//IF WE MISS ANYTHING, DO NOTHING
		end else begin
			newGateStatus <= tempGateStatus;
			newIndex <= currentIndex;
			returnBackdoorCounter <= backdoorCounter;
			updatedUnlockPassword <= currentPasswordRequiredToUnlock;

		end
	end
	
/*
	always @(*) begin
	
		//$display("Enter Button: '%b'", buttonINPUTS[1]);
		case(tempGateStatus)
		
			//gate is CLOSED
			3'd0: begin
				if(buttonINPUTS[1] && !previousINPUTS[1]) begin
					newGateStatus <= 3'd2;
				end
			end
			
			
			
			//gate is OPEN
			3'd1: begin
				if(buttonINPUTS[1] && !previousINPUTS[1]) begin
					newGateStatus <= 3'd5;
				end
			end
			
			
			
			//gate is IDLE
			3'd2: begin
				if(buttonINPUTS[1] && !previousINPUTS[1]) begin
					newIndex <= 0;
					newGateStatus <= 3'd3;
				end
			end
			
			
			
			//gate is ENTER_PASSWORD
			3'd3: begin
				if(buttonINPUTS[1] && !previousINPUTS[1]) begin
					newIndex <= currentIndex + 1;
					if(currentIndex == 2'd3)
						if(currentPasswordRequiredToUnlock == passwordUnlockAttempt)
							newGateStatus <= 3'd1;
				end
			end
			
			
			
			//gate is CHANGE_PASSWORD
			3'd4: begin
				if(buttonINPUTS[1] && !previousINPUTS[1]) begin
					newGateStatus <= 3'd4;
				end
			end
			
			
			//gate is LOCKING
			3'd5: begin
				if(buttonINPUTS[1] && !previousINPUTS[1]) begin
					newIndex <= currentIndex + 1;
					if(currentIndex == 2'd3)
						if(currentPasswordRequiredToUnlock == passwordUnlockAttempt)
							newGateStatus <= 3'd2;
						else
							newGateStatus <= 3'd1;
				end
			end
		endcase	
		
	end

	wire [1:0] pos = {buttonINPUTS[1], buttonINPUTS[0]};
	
	always@(pos) begin// or posedge changeButtonFIXED) begin
		
		previousINPUTS[1] <= buttonINPUTS[1];
		previousINPUTS[0] <= buttonINPUTS[0];
		
	end
	
*/

endmodule

/*

		$display("Enter Button: '%h'", enterButtonFIXED);
		case(tempGateStatus)
		
		
		
			//gate is CLOSED
			3'd0: begin
				if(enterButtonFIXED == 1'b1) begin
					newGateStatus <= 3'd2;
				end
			end
			
			
			
			//gate is OPEN
			3'd1: begin
				if(enterButtonFIXED) begin
					newGateStatus <= 3'd5;
				end
			end
			
			
			
			//gate is IDLE
			3'd2: begin
				if(enterButtonFIXED == 1'b1) begin
					newIndex <= 0;
					newGateStatus <= 3'd3;
				end
			end
			
			
			
			//gate is ENTER_PASSWORD
			3'd3: begin
				if(enterButtonFIXED == 1'b1) begin
					newIndex <= currentIndex + 1;
					if(currentIndex == 2'd3)
						if(currentPasswordRequiredToUnlock == passwordUnlockAttempt)
							newGateStatus <= 3'd1;
				end
			end
			
			
			
			//gate is CHANGE_PASSWORD
			3'd4: begin
				if(enterButtonFIXED) begin
					newGateStatus <= 3'd4;
				end
			end
			
			
			//gate is LOCKING
			3'd5: begin
				if(enterButtonFIXED) begin
					newIndex <= currentIndex + 1;
					if(currentIndex == 2'd3)
						if(currentPasswordRequiredToUnlock == passwordUnlockAttempt)
							newGateStatus <= 3'd2;
						else
							newGateStatus <= 3'd1;
				end
			end
	
	*/
	
	
	
	
	
	
	
	/*
	
	
	
			case(tempGateStatus)
		
		
		
			//gate is CLOSED
			3'd0: begin
				newGateStatus <= 3'd2;
			end
			
			
			
			//gate is OPEN
			3'd1: begin
				newGateStatus <= 3'd5;
			end
			
			
			
			//gate is IDLE
			3'd2: begin
				newIndex <= 0;
				newGateStatus <= 3'd3;
			end
			
			
			
			//gate is ENTER_PASSWORD
			3'd3: begin
				newIndex <= currentIndex + 1;
				if(currentIndex == 2'd3)
					if(currentPasswordRequiredToUnlock == passwordUnlockAttempt)
						newGateStatus <= 3'd1;
			end
			
			
			
			//gate is CHANGE_PASSWORD
			3'd4: begin
				newGateStatus <= 3'd4;
			end
			
			
			//gate is LOCKING
			3'd5: begin
				newIndex <= currentIndex + 1;
				if(currentIndex == 2'd3)
					if(currentPasswordRequiredToUnlock == passwordUnlockAttempt)
						newGateStatus <= 3'd2;
					else
						newGateStatus <= 3'd1;
			end
		endcase	
		
		
		*/
