/***********************************************************
 * @author		Jon Hourany
 * @date		3/09/13
 * @class		EECE 444
 *
 * @file		ctrl_lines.v
 * @proj		Video Card
 ************************************************************/
module Top(RESET, H_SYNC, V_SYNC, RED, BLUE, GREEN);
	input  wire RESET;
	output wire H_SYNC;
	output wire V_SYNC;
	output reg RED, BLUE, GREEN;
	
	`define COLOR_DEPTH 1
	
	OSCC oscc_0(.OSC(clk));
	
	CtrlLines CONTORLLINES(.CLK(clk), .H_SYNC(H_SYNC), .V_SYNC(V_SYNC));
	
	always begin
		RED		<= 1'b1;
		BLUE	<= 0;
		GREEN	<= 0;
	end
	
endmodule 