module character_and_location_de2 (
	input 				CLOCK_50,
	input 	[12:0] 	SW,
	output 	[6:0]		HEX4,HEX5,HEX6,HEX7,
	output 	[8:0] 	LEDG,
	output 	[17:0] 	LEDR,

	//LCD Module 16X2
	output            LCD_ON,	
	output            LCD_BLON,
	output            LCD_RW,	
	output            LCD_EN,	
	output            LCD_RS,	
	inout [7:0]       LCD_DATA	
	);
   
   // Send used switches to red leds 
	assign LEDR[12:0] = SW[12:0];
	
	wire [4:0]	lcd_index;
	wire [4:0]	location = SW[12:8];
	wire [7:0]	lcd_char;
	wire [7:0]	character = SW[7:0];
   
   character_and_location c_and_l (
		.lcd_index  (lcd_index),
		.character  (character),
		.location   (location),
		.dout       (lcd_char)
	);
   
	LCD_Controller LCD_Controller_0 (
      .lcd_char   (lcd_char),
      .lcd_index  (lcd_index),
      .CLOCK_50   (CLOCK_50 ),
      .LCD_ON     (LCD_ON   ),	
      .LCD_BLON   (LCD_BLON ),
      .LCD_RW     (LCD_RW   ),	
      .LCD_EN     (LCD_EN   ),	
      .LCD_RS     (LCD_RS   ),	
      .LCD_DATA   (LCD_DATA )	
	);
  
   hexdigit addr1(
      .in         ({3'b0, location[4]}),
      .out        (HEX7)
   );
   
   hexdigit addr0(
      .in         (location[3:0]),
      .out        (HEX6)
   );
   
   hexdigit data1(
      .in         (character[7:4]),
      .out        (HEX5)
   );
   
   hexdigit data0(
      .in         (character[3:0]),
      .out        (HEX4)
   );
   
   // blank unused LEDs and 7-segment digits
   assign LEDR[17:13] = 5'h0;
   assign LEDG[8:0]   = 9'h0;
   
endmodule
