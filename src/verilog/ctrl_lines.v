/***********************************************************
 * @author		Jon Hourany
 * @date		3/09/13
 * @class		EECE 444
 *
 * @file		ctrl_lines.v
 * @proj		Video Card
 ************************************************************/
 module CtrlLines(CLK, H_SYNC, V_SYNC);
	input  wire CLK;
	
	output reg	H_SYNC;
	output reg	V_SYNC;
	
	`define H_FRONT_PORCH	10'd95
	`define H_BACK_PORCH	10'd720
	`define H_COUNT_MAX		10'd800
	
	`define V_FRONT_PORCH	10'd2
	`define V_BACK_PORCH	10'd514
	`define V_COUNT_MAX		10'd528
	
	reg [10:0]	h_counter, v_counter;
	
	always @(posedge CLK) begin
		h_counter <= h_counter + 1;
		
		case (h_counter)
			`H_FRONT_PORCH: H_SYNC = 1;
			`H_BACK_PORCH : H_SYNC = 0;
			`H_COUNT_MAX  : h_counter <= 0;
			default		  : H_SYNC = 0;
		endcase
	end
	
	always @(negedge h_counter) begin
		v_counter <= v_counter +1;
		
		case (v_counter)
			`V_FRONT_PORCH	: V_SYNC = 1;
			`V_BACK_PORCH	: V_SYNC = 0;
			`V_COUNT_MAX	: v_counter <= 0;
			default			: V_SYNC = 0;
		endcase
	end
endmodule