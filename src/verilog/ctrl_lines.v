/***********************************************************
 * @author		Jon Hourany
 * @date		2/24/12
 * @class		EECE 344
 *
 * @file		ctrl_lines.v
 * @proj		Video Card
 * @class		EECE 444
 ************************************************************/
 module CtrlLines(H_SYNC, V_SYNC);
	output wire		H_SYNC;
	output wire		V_SYNC;
	
	OSCC oscc_0(.OSC(clk));
	
	reg [10:0]	h_sync_counter, v_sync_counter;
	
	always @(posedge clk) begin
		h_sync_counter = h_sync_counter + 1;
		v_sync_counter = v_sync_counter + 1;
		
		case (h_sync_counter)
	
		