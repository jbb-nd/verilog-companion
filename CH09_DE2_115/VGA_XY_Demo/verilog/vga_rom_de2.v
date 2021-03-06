module vga_rom_de2 (
	input				CLOCK_50,				//	50 MHz
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK,				//	VGA BLANK
	output			VGA_SYNC,				//	VGA SYNC
	output [9:0]	VGA_R,   				//	VGA Red[9:0]
	output [9:0]	VGA_G,	 				//	VGA Green[9:0]
	output [9:0]	VGA_B	   				//	VGA Blue[9:0]
	);
   
   wire   [7:0]   x_vga;
   wire   [6:0]   y_vga;
   wire   [2:0]   color_vga;
   
   background_rom rom ( 
      .clk        (VGA_CLK),
      .x          (x_vga),
      .y          (y_vga),  
      .dout       (color_vga)
   );
   defparam rom.IMAGE_FILE = "testpattern.mem";
	
	vga_xy_controller vga_xy_controller (
      .CLOCK_50      (CLOCK_50),
      .resetn        (1'b1),
      .color         (color_vga),
      .x             (x_vga),
      .y             (y_vga),
      .VGA_R         (VGA_R),
      .VGA_G         (VGA_G),
      .VGA_B         (VGA_B),
      .VGA_HS        (VGA_HS),
      .VGA_VS        (VGA_VS),
      .VGA_BLANK     (VGA_BLANK),
      .VGA_SYNC      (VGA_SYNC),
      .VGA_CLK       (VGA_CLK)				
   );
	
endmodule
