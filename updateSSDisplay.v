`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:40 04/13/2019 
// Design Name: 
// Module Name:    updateSSDisplay 
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
module updateSSDisplay(displayElements, clk, gateStatus, currentIndex, finishedScrolling, AN, ssdLINES, moreSSDLINES);

	input [15:0] displayElements;
	input [2:0] gateStatus;
	input [1:0] currentIndex;
		
	input clk;

	reg [1:0] counter;

	wire [6:0] linesOne;
	wire [6:0] linesTwo;
	wire [6:0] linesThree;
	wire [6:0] linesFour;
	
	output reg finishedScrolling;

	output reg [3:0] AN;
	output reg [6:0] ssdLINES;
	
	parameter scrollingRate = 4'b1101;
	
	reg [4:0] scrollingIndex;
		
	reg [3:0] scrollingCounter;
	
	wire [6:0] scrollingLinesOne;
	wire [6:0] scrollingLinesTwo;
	wire [6:0] scrollingLinesThree;
	wire [6:0] scrollingLinesFour;
	
	output reg [27:0] moreSSDLINES;
	
	
	initial scrollingIndex = 0;
	initial scrollingCounter = 4'b0000;
	

	//GETS WHICH LINES SHOULD BE ON BASED ON DIGITS
	updateDigit updateDigit1(displayElements[15:12], linesOne);
	updateDigit updateDigit2(displayElements[11:8], linesTwo);
	updateDigit updateDigit3(displayElements[7:4], linesThree);
	updateDigit updateDigit4(displayElements[3:0], linesFour);
	
	//GETS WHICH LINES SHOULD BE ON BASED ON HARD CODED LIST
	scrollingLines scrollingLines1(scrollingIndex + 2'b00, clk, scrollingLinesOne);
	scrollingLines scrollingLines2(scrollingIndex + 2'b01, clk, scrollingLinesTwo);
	scrollingLines scrollingLines3(scrollingIndex + 2'b10, clk, scrollingLinesThree);
	scrollingLines scrollingLines4(scrollingIndex + 2'b11, clk, scrollingLinesFour);

	
	/*

	0 - gate is CLOSED
	1 - gate is OPEN
	2 - gate is IDLE
	3 - gate is ENTER_PASSWORD
	4 - gate is CHANGE_PASSWORD
	5 - gate is LOCKING
	6 - gate is SCROLLING TEXT

	*/
/*

	C L S d ->
		     ->
	1       ->
	- 1     ->
	- - 2   ->
	- - - 3 -> OPEN or CLSD



*/

	initial counter = 2'b00;
	initial AN = 4'b1110;
	initial ssdLINES <= 7'b1110000;


	always@(posedge clk) begin			
		/*
		if(scrollingCounter == 9'b111111111)
			scrollingCounter <= 0;
		*/
		finishedScrolling = 0;
		if(counter > 2'd3)
			counter <= 0;
		case(counter)
		
			2'd0: begin
				
				AN = 4'b0111;			
				//DISPLAYED IN FIRST ANODE
			
				//IF GATE IS OPEN (DISPLAYS OPEN)			
				if(gateStatus == 3'd1) begin
					ssdLINES <= 7'b0000001;

				//IF GATE IS IDLE (DISPLAYS CLOSED)					
				end else if(gateStatus == 3'd2) begin
					ssdLINES <= 7'b0110001;
					
				//IF GATE IS ENTER_PASSWORD
				end else if(gateStatus == 3'd3) begin
					if(currentIndex > 2'd0)
						ssdLINES <= 7'b1111110;
					else if(currentIndex == 0)
						ssdLINES <= linesOne;
					else
						ssdLINES <= 7'b1111111;
						
				//IF GATE IS CHANGE_PASSWORD						
				end else if(gateStatus == 3'd4) begin
					if(currentIndex >= 2'd0)
						ssdLINES <= linesOne;
					else
						ssdLINES <= 7'b1111111;
						
				//IF GATE IS RE-ENTER_PASSWORD				
				end else if(gateStatus == 3'd5) begin
					if(currentIndex >= 2'd0)
						ssdLINES <= linesOne;
					else
						ssdLINES <= 7'b1111111;
				
				
				//IF GATE IS SCROLLING SCROLLING SCROLLING
				end else if(gateStatus == 3'd6) begin
					ssdLINES <= scrollingLinesOne;
					if(scrollingCounter == scrollingRate) begin
						scrollingCounter = 0;
						scrollingIndex <= scrollingIndex + 1'b1;
					end else begin
						scrollingCounter = scrollingCounter + 1'b1;
					end
					if(scrollingIndex >= 17) begin
						finishedScrolling = 1;
						scrollingIndex <= 0;
					end
					
				end else
					ssdLINES <= linesOne;
			end
			
			
			2'd1: begin
				AN = 4'b1011;
				
				//IF GATE IS OPEN
				if(gateStatus == 3'd1) begin
					ssdLINES <= 7'b0011000;
					
				//IF GATE IS IDLE
				end else if(gateStatus == 3'd2) begin
					ssdLINES <= 7'b1110001;
					
				//IF GATE IS ENTER_PASSWORD
				end else if(gateStatus == 3'd3) begin
					if(currentIndex > 2'd1)
						ssdLINES <= 7'b1111110;
					else if(currentIndex == 1)
						ssdLINES <= linesTwo;
					else
						ssdLINES <= 7'b1111111;
						
				//IF GATE IS CHANGE_PASSWORD
				end else if(gateStatus == 3'd4) begin
					if(currentIndex >= 2'd1)
						ssdLINES <= linesTwo;
					else
						ssdLINES <= 7'b1111111;				
				
				//IF GATE IS RE-ENTER_PASSWORD
				end else if(gateStatus == 3'd5) begin
					if(currentIndex >= 2'd1)
						ssdLINES <= linesTwo;
					else
						ssdLINES <= 7'b1111111;
				
				
				//IF GATE IS SCROLLING SCROLLING SCROLLING
				end else if(gateStatus == 3'd6) begin
					ssdLINES <= scrollingLinesTwo;
					
					
				end else
					ssdLINES <= linesTwo;
			end
			
			
			2'd2: begin
				AN = 4'b1101;
				
				
				//IF GATE IS OPEN
				if(gateStatus == 3'd1) begin
					ssdLINES <= 7'b0110000;
					
				//IF GATE IS IDLE
				end else if(gateStatus == 3'd2) begin
					ssdLINES <= 7'b0100100;
					
				//IF GATE IS ENTER_PASSWORD
				end else if(gateStatus == 3'd3) begin
					if(currentIndex > 2'd2)
						ssdLINES <= 7'b1111110;
					else if(currentIndex == 2'd2)
						ssdLINES <= linesThree;
					else
						ssdLINES <= 7'b1111111;
				//IF GATE IS CHANGE_PASSWORD
				end else if(gateStatus == 3'd4) begin
					if(currentIndex >= 2'd2)
						ssdLINES <= linesThree;
					else
						ssdLINES <= 7'b1111111;				
				
				//IF GATE IS RE-ENTER_PASSWORD
				end else if(gateStatus == 3'd5) begin
					if(currentIndex >= 2'd2)
						ssdLINES <= linesThree;
					else
						ssdLINES <= 7'b1111111;
				
				//IF GATE IS SCROLLING SCROLLING SCROLLING
				end else if(gateStatus == 3'd6) begin
					ssdLINES <= scrollingLinesThree;
			
				end else
					ssdLINES <= linesThree;	
			end
			
			

			2'd3: begin
				AN = 4'b1110;	
				
				
				
				//IF GATE IS OPEN
				if(gateStatus == 3'd1) begin
					ssdLINES <= 7'b0001001;
					
				//IF GATE IS IDLE
				end else if(gateStatus == 3'd2) begin
					ssdLINES <= 7'b1000010;
					
				//IF GATE IS ENTER_PASSWORD
				end else if(gateStatus == 3'd3) begin
					if(currentIndex > 2'd3)
						ssdLINES <= 7'b1111110;
					else if(currentIndex == 2'd3)
						ssdLINES <= linesFour;
					else
						ssdLINES <= 7'b1111111;
						
				//IF GATE IS CHANGE_PASSWORD
				end else if(gateStatus == 3'd4) begin
					if(currentIndex >= 2'd3)
						ssdLINES <= linesFour;
					else
						ssdLINES <= 7'b1111111;
						
				//IF GATE IS RE-ENTER_PASSWORD
				end else if(gateStatus == 3'd5) begin
					if(currentIndex >= 2'd3)
						ssdLINES <= linesFour;
					else
						ssdLINES <= 7'b1111111;
				
				//IF GATE IS SCROLLING SCROLLING SCROLLING
				end else if(gateStatus == 3'd6) begin
					ssdLINES <= scrollingLinesFour;


				end else
					ssdLINES <= linesFour;

					
			end
		endcase	
		counter <= counter + 1'b1;
		if(AN[2] == 0) moreSSDLINES[27:21] <= ssdLINES;
		else if(AN[1] == 0) moreSSDLINES[20:14] <= ssdLINES;
		else if(AN[0] == 0) moreSSDLINES[13:7] <= ssdLINES;
		else if(AN[3] == 0) moreSSDLINES[6:0] <= ssdLINES;

		

	end

		
		

endmodule
