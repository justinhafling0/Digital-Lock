`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:34 04/13/2019 
// Design Name: 
// Module Name:    getDigit 
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
module getDigit(SW0, SW1, SW2, SW3, digit);

	input SW0, SW1, SW2, SW3;
	
	output reg [3:0] digit;

	//BASED ON THE STATUS OF THE SWITCHES, RETURNS THE HEXADECIMAL EQUIVALENT (CONVERTS BINARY -> HEX)
	always@(*)begin
		case({SW3, SW2, SW1, SW0})
			4'b0000:
				digit <= 4'h0;
			4'b0001:
				digit <= 4'h1;
			4'b0010:
				digit <= 4'h2;
			4'b0011:
				digit <= 4'h3;
			4'b0100:
				digit <= 4'h4;
			4'b0101:
				digit <= 4'h5;
			4'b0110:
				digit <= 4'h6;
			4'b0111:
				digit <= 4'h7;
			4'b1000:
				digit <= 4'h8;
			4'b1001:
				digit <= 4'h9;
			4'b1010:
				digit <= 4'ha;
			4'b1011:
				digit <= 4'hb;
			4'b1100:
				digit <= 4'hc;
			4'b1101:
				digit <= 4'hd;
			4'b1110:
				digit <= 4'he;
			4'b1111:
				digit <= 4'hf;
		endcase
	end


endmodule
