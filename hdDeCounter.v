/* Author: Ismael Contreras
*  Date: 12/10/2021
*
*  Purpose:
*
*	Hardware level module to demonstrate a bidirectional 
*  counter that ranges from 00.0 to 99.9
*
*	Uses 3 Cascaded BiDirectional counters with overflow.
*
*	Input:
*	CLOCK_50	=	Clock
*	KEY[0]	=	Reset
*	KEY[1]	= 	Preset
*	SW[0]		= 	Mode
*	
*	Output:
*	HEX2		=	Tens Count
*	HEX1		=	Ones Count
*	HEX0 		= 	Tenth's Count
*
*/


module hdDeCounter(CLOCK_50, KEY, HEX2, HEX1, HEX0, SW);

	input wire CLOCK_50;
	input wire [1:0] KEY;
	input wire [0:0] SW;
	output wire [6:0]HEX2, HEX1, HEX0;
	wire clock10;
	wire [11:0]flow;
	wire [2:0]overflow, cloks;
	
	
	

	
	assign cloks = {overflow[1] | (KEY[0] & clock10), overflow[0] | (KEY[0] & clock10) ,clock10};
	
	clockEnable inst0( .clockIn(CLOCK_50), .reset(KEY[0]), .clockPulse(clock10) );
	sevsenSeg h0( .IWire(flow[11:8]), .segment(HEX2) );
	sevsenSeg h1( .IWire(flow[7:4]), .segment(HEX1) );
	sevsenSeg h2( .IWire(flow[3:0]), .segment(HEX0) );
	BiCount i[2:0]( .Clock(cloks ), .Reset(KEY[0]), .Preset(KEY[1]), .Select(SW), .Count(flow), .Overflow(overflow) );
	
	
	
	
endmodule 
