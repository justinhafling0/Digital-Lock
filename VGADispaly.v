module vga_display(
  input rst,
  input clk,

  input [27:0] ssdLINES,
  output reg [2:0]R,
  output reg [2:0]G,
  output reg [1:0]B,
  output HS,
  output VS,
  output reg light
);
  
   
  wire [10:0] hcount, vcount;
  wire blank;
  wire clk_25Mhz;
  
  clk_divider2 clk_div_25 (
   .clock_in(clk),
   .reset(rst),
   .clock_out(clk_25Mhz)
  );

  vga_controller_640_60 vc(
    .rst(rst),
	 .pixel_clk(clk_25Mhz),
	 .HS(HS),
	 .VS(VS),
	 .hcounter(hcount),
	 .vcounter(vcount),
	 .blank(blank)
  );
  
  /*
  		 R = {3{hcount[5]}};
		 G = {3{hcount[6]}};
		 B = {2{vcount[5]}};
  */
  parameter horizontalSpacing = horizontalIndex + length + 2 * thickness + 2 * spacer;
  parameter spacer = 5;
  parameter thickness = 20;
  parameter length = 75;
  parameter horizontalIndex = 40;
  parameter verticalIndex = (480 - length * 2 + spacer) / 2;

  always @(posedge clk_25Mhz) begin
    light <= ~blank;
	 
	 //ANODE 0
/*

DIGIT 1

*/

	 R = 3'b101;
	 G = 3'b000;
	 B = 2'b00;


	 if(hcount > horizontalIndex && hcount < horizontalIndex + length)begin
		if(vcount > verticalIndex && vcount < verticalIndex + thickness) begin
		  
		  //LINE A from Seven Segment Display
		  
			if(ssdLINES[27] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + length + spacer - thickness && vcount < verticalIndex + length + length + spacer)begin
		  
		  //LINE D from Seven Segment Display
		  
			if(ssdLINES[24] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end

		end else if(vcount > verticalIndex + length - (thickness / 2) + spacer && vcount < verticalIndex + length + (thickness / 2) + spacer) begin
		  
		  //LINE G from Seven Segment Display
		  
			if(ssdLINES[21] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else begin
			 R = 3'b101;
			 G = 3'b000;
			 B = 2'b00;
		end
	end else if(hcount > horizontalIndex + length + spacer && hcount < horizontalIndex + length + spacer + thickness)begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
		  
		  //LINE B from Seven Segment Display
		  
			if(ssdLINES[26] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end

		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		  
		  //LINE C from Seven Segment Display
		  
			if(ssdLINES[25] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end

		end
	end else if(hcount > horizontalIndex - spacer - thickness && hcount < horizontalIndex - spacer) begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
			  
			  //LINE F from Seven Segment Display
			  
			if(ssdLINES[22] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		  
		  //LINE E from Seven Segment Display
		  
			if(ssdLINES[23] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end





/*



DIGIT 2


*/



  end else if(hcount > horizontalIndex + horizontalSpacing * 1 && hcount < horizontalIndex + length + horizontalSpacing * 1)begin
		if(vcount > verticalIndex && vcount < verticalIndex + thickness) begin
		
		//LINE A
			if(ssdLINES[20] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
			
		end else if(vcount > verticalIndex + length + length + spacer - thickness && vcount < verticalIndex + length + length + spacer)begin
		// LINE D
			if(ssdLINES[17] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length - (thickness / 2) + spacer && vcount < verticalIndex + length + (thickness / 2) + spacer) begin
		//LINE G
			if(ssdLINES[14] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else begin
			 R = 3'b101;
			 G = 3'b000;
			 B = 2'b00;
		end
	end else if(hcount > horizontalIndex + length + spacer + horizontalSpacing * 1 && hcount < horizontalIndex + length + spacer + thickness + horizontalSpacing * 1)begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
		//LINE B
			if(ssdLINES[19] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		//LINE C
			if(ssdLINES[18] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end
	end else if(hcount > horizontalIndex - spacer - thickness  + horizontalSpacing * 1 && hcount < horizontalIndex - spacer + horizontalSpacing * 1) begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
		//LINE F
			if(ssdLINES[15] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		//LINE E
			if(ssdLINES[16] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end

/*


DIGIT 3


*/

   end else if(hcount > horizontalIndex + horizontalSpacing * 2 && hcount < horizontalIndex + length + horizontalSpacing * 2)begin
		if(vcount > verticalIndex && vcount < verticalIndex + thickness) begin
		
		//LINE A
			if(ssdLINES[13] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + length + spacer - thickness && vcount < verticalIndex + length + length + spacer)begin
		// LINE D
			if(ssdLINES[10] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length - (thickness / 2) + spacer && vcount < verticalIndex + length + (thickness / 2) + spacer) begin
		//LINE G
			if(ssdLINES[7] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else begin
			 R = 3'b101;
			 G = 3'b000;
			 B = 2'b00;
		end
	end else if(hcount > horizontalIndex + length + spacer + horizontalSpacing * 2 && hcount < horizontalIndex + length + spacer + thickness + horizontalSpacing * 2)begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
		// LINE B
			if(ssdLINES[12] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		//LINE C
			if(ssdLINES[11] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end
	end else if(hcount > horizontalIndex - spacer - thickness  + horizontalSpacing * 2 && hcount < horizontalIndex - spacer + horizontalSpacing * 2) begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
		//LINE F
			if(ssdLINES[8] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		//LINE E
			if(ssdLINES[9] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end
		
		
/*



DIGIT 4


*/		
		
	end else if(hcount > horizontalIndex + horizontalSpacing * 3 && hcount < horizontalIndex + length + horizontalSpacing * 3)begin
		if(vcount > verticalIndex && vcount < verticalIndex + thickness) begin
		
		//LINE A
			if(ssdLINES[6] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + length + spacer - thickness && vcount < verticalIndex + length + length + spacer)begin
		// LINE D
			if(ssdLINES[3] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length - (thickness / 2) + spacer && vcount < verticalIndex + length + (thickness / 2) + spacer) begin
		//LINE G
			if(ssdLINES[0] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else begin
			 R = 3'b101;
			 G = 3'b000;
			 B = 2'b00;
		end
	end else if(hcount > horizontalIndex + length + spacer + horizontalSpacing * 3 && hcount < horizontalIndex + length + spacer + thickness + horizontalSpacing * 3)begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
		//LINE B
			if(ssdLINES[5] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		//LINE C
			if(ssdLINES[4] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end
	end else if(hcount > horizontalIndex - spacer - thickness  + horizontalSpacing * 3 && hcount < horizontalIndex - spacer + horizontalSpacing * 3) begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
		//LINE F
			if(ssdLINES[1] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		//LINE E
			if(ssdLINES[2] == 0) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			end
		end
   end else if((hcount >= 0 && hcount <= horizontalIndex - spacer - thickness) 
	|| (hcount >= horizontalIndex - thickness && hcount <= horizontalIndex - thickness + spacer)
	|| (hcount >= horizontalIndex + length && hcount <= horizontalIndex + length + spacer)
	|| (hcount >= horizontalIndex + length + spacer + thickness && hcount <= horizontalIndex + horizontalSpacing)
	|| (hcount >= horizontalIndex + horizontalSpacing + length + spacer + thickness && hcount <= horizontalIndex + 2 * horizontalSpacing)
	|| (hcount >= horizontalIndex + 2 * horizontalSpacing + length + spacer + thickness && hcount <= horizontalIndex + 3 * horizontalSpacing)
	|| (hcount >= horizontalIndex + horizontalSpacing - spacer && hcount <= horizontalIndex + horizontalSpacing)
	|| (hcount >= horizontalIndex - spacer && hcount <= horizontalIndex)
	|| (hcount >= horizontalIndex + 3 * horizontalSpacing + length + spacer + thickness && hcount <= horizontalIndex + 4 * horizontalSpacing)
	|| (hcount >= horizontalIndex + horizontalSpacing + length && hcount <= horizontalIndex + horizontalSpacing + length + spacer)
	|| (hcount >= horizontalIndex + 2 * horizontalSpacing + length && hcount <= horizontalIndex + 2 * horizontalSpacing + length + spacer)
	|| (hcount >= horizontalIndex + 3 * horizontalSpacing + length && hcount <= horizontalIndex + 3 * horizontalSpacing + length + spacer)
	|| (hcount <= spacer)

	)begin

			 R = 3'b101;
			 G = 3'b000;
			 B = 2'b00;
	
	
	end else begin
		 R = 3'b111;
		 G = 3'b111;
		 B = 2'b11;
  end
end
		  

 
endmodule



/*


	 if(hcount > horizontalIndex && hcount < horizontalIndex + length)begin
		if(vcount > verticalIndex && vcount < verticalIndex + thickness) begin
		  if(AN[3] == 0) begin
		  
		  //LINE A from Seven Segment Display
		  
		    if(ssdLINES[0] == 1) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			 end else begin
				 R = 3'b011;
				 G = 3'b000;
				 B = 2'b00;			 
			 end
		  end
		end else if(vcount > verticalIndex + length + length + spacer - thickness && vcount < verticalIndex + length + length + spacer)begin
		  if(AN[3] == 0) begin
		  
		  //LINE D from Seven Segment Display
		  
		    if(ssdLINES[3] == 1) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			 end else begin
				 R = 3'b011;
				 G = 3'b000;
				 B = 2'b00;			 
			 end
		  end
		end else if(vcount > verticalIndex + length - (thickness / 2) + spacer && vcount < verticalIndex + length + (thickness / 2) + spacer) begin
		  if(AN[3] == 0) begin
		  
		  //LINE G from Seven Segment Display
		  
		    if(ssdLINES[6] == 1) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			 end else begin
				 R = 3'b011;
				 G = 3'b000;
				 B = 2'b00;			 
			 end
		  end
		end else begin
			 R = 3'b011;
			 G = 3'b000;
			 B = 2'b00;
		end
	end else if(hcount > horizontalIndex + length + spacer && hcount < horizontalIndex + length + spacer + thickness)begin
		if(vcount > verticalIndex && vcount < verticalIndex + length)begin
		  if(AN[3] == 0) begin
		  
		  //LINE D from Seven Segment Display
		  
		    if(ssdLINES[1] == 1) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			 end else begin
				 R = 3'b011;
				 G = 3'b000;
				 B = 2'b00;			 
			 end
		  end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		  if(AN[3] == 0) begin
		  
		  //LINE D from Seven Segment Display
		  
		    if(ssdLINES[2] == 1) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			 end else begin
				 R = 3'b011;
				 G = 3'b000;
				 B = 2'b00;			 
			 end
		  end
		end
		end else if(hcount > horizontalIndex - spacer - thickness && hcount < horizontalIndex - spacer) begin
			if(vcount > verticalIndex && vcount < verticalIndex + length)begin
			  if(AN[3] == 0) begin
			  
			  //LINE D from Seven Segment Display
			  
				 if(ssdLINES[4] == 1) begin
					 R = 3'b111;
					 G = 3'b110;
					 B = 2'b00;
				 end else begin
					 R = 3'b011;
					 G = 3'b000;
					 B = 2'b00;			 
				 end
		      end
			 end
		end else if(vcount > verticalIndex + length + spacer && vcount < verticalIndex + length + length + spacer)begin
		  if(AN[3] == 0) begin
		  
		  //LINE D from Seven Segment Display
		  
		    if(ssdLINES[5] == 1) begin
				 R = 3'b111;
				 G = 3'b110;
				 B = 2'b00;
			 end else begin
				 R = 3'b011;
				 G = 3'b000;
				 B = 2'b00;			 
			 end
		end
*/
