`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:35:57 04/16/2019 
// Design Name: 
// Module Name:    finishedScrollingStatus 
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
module finishedScrollingStatus(tempGateStatus, finishedScrollingGateStatus);

	input [2:0] tempGateStatus;
	
	output reg [2:0] finishedScrollingGateStatus;

	always@(*) begin
		
		finishedScrollingGateStatus = 3'd2;
		
	end

endmodule
