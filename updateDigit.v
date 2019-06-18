`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:54:58 04/13/2019 
// Design Name: 
// Module Name:    updateDigit 
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
module updateDigit(displayElement, ssdLINES);

	input [3:0] displayElement;
	output reg [6:0] ssdLINES;
	
	initial ssdLINES = 7'b1101100;

//GETS THE SSDLINES BASED ON THE HEXADECIMAL NUMBER ENTERED
	always@(*) begin
		case(displayElement)
			4'h0:
				ssdLINES = 7'b0000001;
			4'h1:
				ssdLINES = 7'b1001111;
			4'h2:
				ssdLINES = 7'b0010010;
			4'h3:
				ssdLINES = ~(7'b1111001);
			4'h4:
				ssdLINES = ~(7'b0110011);
			4'h5:
				ssdLINES = ~(7'b1011011);
			4'h6:
				ssdLINES = ~(7'b1011111);
			4'h7:
				ssdLINES = ~(7'b1110000);
			4'h8:
				ssdLINES = ~(7'b1111111);
			4'h9:
				ssdLINES = ~(7'b1111011);
			4'hA:
				ssdLINES = ~(7'b1110111);
			4'hB:
				ssdLINES = ~(7'b0011111);
			4'hC:
				ssdLINES = ~(7'b1001110);
			4'hD:
				ssdLINES = ~(7'b0111101);
			4'hE:
				ssdLINES = ~(7'b1001111);
			4'hF:
				ssdLINES = ~(7'b1000111);
		endcase
	end
	

endmodule
