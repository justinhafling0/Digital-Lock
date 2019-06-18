`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:42 04/09/2019 
// Design Name: 
// Module Name:    projectMAIN 
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
module projectTopMAIN(SW0, SW1, SW2, SW3, resetButton, changeButton, enterButton, clearButton, clk, LED, AN, ssdLINES, currentDigit,
 R, G, B, Light, HS, VS);

	input SW0, SW1, SW2, SW3;
	input resetButton, enterButton, changeButton, clearButton;
	input clk;
	
	//BUTTON SIGNALS AFTER THEY HAVE BEEN DEBOUNCED
	wire enterButtonFIXED;
	wire changeButtonFIXED;
	wire resetButtonFIXED;
	wire clearButtonFIXED;
	
	//PASSES ALL INPUT BUTTONS TO OUR STATE HANDLER
	wire [3:0] buttonINPUTS;
	
	assign buttonINPUTS[3] = clearButtonFIXED;
	assign buttonINPUTS[2] = resetButtonFIXED;
	assign buttonINPUTS[1] = enterButtonFIXED;
	assign buttonINPUTS[0] = changeButtonFIXED;
	
	//USED AS RESET BUTTON IN CLK
	reg randomZero = 1'b0;

	//CLK DIVIDER
	wire clk_divided;
	clk_divider clk_divider(clk, clk_divided);
			
	//STORES THE CURRENT STATUS OF THE GATE		
	reg [2:0] gateStatus;
	wire [2:0] tempGateStatus;
	
	//STORES THE CURRENT INDEX / DIGIT WE ARE DISPLAYING
	wire [1:0] currentIndex;
	wire [3:0] currentDigitWire;
	output reg [3:0] currentDigit;
	
	//OUTPUTS ON BOARD
	output reg [3:0] AN;
	output reg [6:0] ssdLINES;
	output reg [6:0] LED;
	wire [3:0] ANTemp;
	wire [6:0] ssdLINESTemp;
	
	//CHECKS WHAT WE SHOULD BE DISPLAYING BASED ON PASSWORD BEING ENTERED
	wire [15:0] displayElements;
	wire [15:0] passwordUnlockAttempt;
	
	//STORES WHAT THE CURRENT PASSWORD IS
	wire [15:0] currentPasswordRequiredToUnlock;

	//COUNTER FOR THE BACKDOOR
	wire [2:0] backdoorCounter;
	
	//INDEX USED TO SCROLL
	wire [4:0] scrollIndex;
	
	//SSD VALUES PASSED TO VGA BOARD
	wire [27:0] moreSSDLINES;
	
	
	//OUTPUTS USED IN VGA DISPLAY PRIMARILY UCF FILE
	output reg [2:0] R;
	output reg [2:0] G;
	output reg [1:0] B;
	
	//OUTPUTS FROM VGA DISPLAY
	wire [2:0] R_WIRE;
	wire [2:0] G_WIRE;
	wire [1:0] B_WIRE;
	
	//OUTPUTS FROM VGA DISPLAY
	output HS;
	output VS;
	output Light;

	getDigit getDigit(SW0, SW1, SW2, SW3, currentDigitWire);
	
	
	//DEBOUNCE ALL OF THE BUTTONS
	debouncer debouncerEnter(clk_divided, randomZero, enterButton, enterButtonFIXED);
	debouncer debouncerChange(clk_divided, randomZero, changeButton, changeButtonFIXED);
	debouncer debouncerReset(clk_divided, randomZero, resetButton, resetButtonFIXED);
	debouncer debouncerClear(clk_divided, randomZero, clearButton, clearButtonFIXED);

	//GETS THE STATUS OR STATE MACHINE
	getOverallStatus getOverallStatus(tempGateStatus, currentIndex, buttonINPUTS, backdoorCounter, currentDigit, finishedScrolling, clk_divided, passwordUnlockAttempt, currentPasswordRequiredToUnlock, tempGateStatus, currentIndex, backdoorCounter, currentPasswordRequiredToUnlock);
	
	// ORGANIZE PASSWORD AND DISPLAY ELEMENTS
	
	getDisplayElements getDisplayElements(clk_divided, displayElements, tempGateStatus, currentIndex, currentDigit, displayElements);	
	getPassword getPassword(clk, passwordUnlockAttempt, currentIndex, currentDigit, enterButtonFIXED, tempGateStatus, passwordUnlockAttempt);
	
	// UPDATES SSD DISPLAY
	updateSSDisplay updateSSDisplay(displayElements, clk_divided, tempGateStatus, currentIndex, finishedScrolling, ANTemp, ssdLINESTemp, moreSSDLINES);
	
	vga_display VGADisplay(resetButtonFIXED, clk, moreSSDLINES, R_WIRE, G_WIRE, B_WIRE, HS, VS, Light);
	
	

	always@(*) begin
	
		//ASSIGNING VALUES TO WIRES FROM VGA DISPLAY
		R <= R_WIRE;
		G <= G_WIRE;
		B <= B_WIRE;

		//SETTING LED TO CURRENT GATE STATUS
		LED[0] <= tempGateStatus[2] && tempGateStatus[1] && !tempGateStatus[0];
		LED[1] <= tempGateStatus[2] && !tempGateStatus[1] && tempGateStatus[0];
		LED[2] <= tempGateStatus[2] && !tempGateStatus[1] && !tempGateStatus[0];
		LED[3] <= !tempGateStatus[2] && tempGateStatus[1] && tempGateStatus[0];
		LED[4] <= !tempGateStatus[2] && tempGateStatus[1] && !tempGateStatus[0];
		LED[5] <= !tempGateStatus[2] && !tempGateStatus[1] && tempGateStatus[0];
	
	
		//THESE SIGNALS ARE SENT TO FPGA BOARD TO UPDATE IT
		AN <= ANTemp;
		ssdLINES <= ssdLINESTemp;
		
		//TRACKS WHERE IN THE SEQUENCE WE ARE
		currentDigit <= currentDigitWire;
	
	end


endmodule
