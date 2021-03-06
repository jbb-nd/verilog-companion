module muxed_vga_adapters (
   input       s,
   input       resetn,	
   input       CLOCK_50,
	
   input [2:0] colour_0,	
   input [7:0] x_0,			
   input [6:0] y_0,			
   input       plot_0,
   
   input [2:0] colour_1,	
   input [7:0] x_1,			
   input [6:0] y_1,			
   input       plot_1,
   
   output reg  VGA_R,		
   output reg  VGA_G,		
   output reg  VGA_B,		
   output reg  VGA_HS,		
   output reg  VGA_VS,		
   output reg  VGA_BLANK,	
   output reg  VGA_SYNC,	
   output reg  VGA_CLK		
   );
   
   wire  VGA_R_0;		
   wire  VGA_G_0;		
   wire  VGA_B_0;		
   wire  VGA_HS_0;		
   wire  VGA_VS_0;		
   wire  VGA_BLANK_0;	
   wire  VGA_SYNC_0;	
   wire  VGA_CLK_0;	

   wire  VGA_R_1;		
   wire  VGA_G_1;		
   wire  VGA_B_1;		
   wire  VGA_HS_1;		
   wire  VGA_VS_1;		
   wire  VGA_BLANK_1;	
   wire  VGA_SYNC_1;	
   wire  VGA_CLK_1;	
   
   vga_adapter VGA_0 (
		.resetn		(resetn),
		.clock		(CLOCK_50),
		.colour		(colour_0),
		.x				(x_0),
		.y				(y_0),
		.plot			(plot_0),
		/* Signals for the DAC to drive the monitor. */
		.VGA_R		(VGA_R_0),
		.VGA_G		(VGA_G_0),
		.VGA_B		(VGA_B_0),
		.VGA_HS		(VGA_HS_0),
		.VGA_VS		(VGA_VS_0),
		.VGA_BLANK	(VGA_BLANK_0),
		.VGA_SYNC	(VGA_SYNC_0),
		.VGA_CLK		(VGA_CLK_0)
	);
	defparam VGA_0.RESOLUTION = "160x120";
	defparam VGA_0.MONOCHROME = "FALSE";
	defparam VGA_0.BITS_PER_COLOUR_CHANNEL = 1;
	defparam VGA_0.BACKGROUND_IMAGE = "background_image.mif";
   
   vga_adapter VGA_1 (
		.resetn		(resetn),
		.clock		(CLOCK_50),
		.colour		(colour_1),
		.x				(x_1),
		.y				(y_1),
		.plot			(plot_1),
		/* Signals for the DAC to drive the monitor. */
		.VGA_R		(VGA_R_1),
		.VGA_G		(VGA_G_1),
		.VGA_B		(VGA_B_1),
		.VGA_HS		(VGA_HS_1),
		.VGA_VS		(VGA_VS_1),
		.VGA_BLANK	(VGA_BLANK_1),
		.VGA_SYNC	(VGA_SYNC_1),
		.VGA_CLK		(VGA_CLK_1)
	);
	defparam VGA_1.RESOLUTION = "160x120";
	defparam VGA_1.MONOCHROME = "FALSE";
	defparam VGA_1.BITS_PER_COLOUR_CHANNEL = 1;
	defparam VGA_1.BACKGROUND_IMAGE = "background_image.mif";
   
   always @(*)
      if (s) begin
         VGA_R     = VGA_R_1;		   		
         VGA_G     = VGA_G_1;		   		
         VGA_B     = VGA_B_1;		      		
         VGA_HS    = VGA_HS_1;		   
         VGA_VS    = VGA_VS_1;		   
         VGA_BLANK = VGA_BLANK_1;	   
         VGA_SYNC  = VGA_SYNC_1;	   
         VGA_CLK   = VGA_CLK_1;		   
      end
      else begin
         VGA_R     = VGA_R_0;		   		
         VGA_G     = VGA_G_0;		   		
         VGA_B     = VGA_B_0;		      		
         VGA_HS    = VGA_HS_0;		   
         VGA_VS    = VGA_VS_0;		   
         VGA_BLANK = VGA_BLANK_0;	   
         VGA_SYNC  = VGA_SYNC_0;	   
         VGA_CLK   = VGA_CLK_0;		   
      end  
   
endmodule
   