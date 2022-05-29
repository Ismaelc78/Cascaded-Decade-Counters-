/* Author: Ismael Contreras
*  Date: 12/10/2021
*
*  Purpose:
* 	Decimal synchronous counter circuit with overflow.
*	Counts from 0 - 9 then resets to 0.
*  Uses instances of D-FlipFLops to produce results
*
*/

module UpCount(Clock, Reset, Preset, Overflow, Count);

	input wire Clock, Reset, Preset;
	output wire Overflow;
	output wire [3:0] Count;
	wire [3:0]Q, Din, preset, resetWire;
	wire  count10;
	
	
	assign Din = {Q[3] ^ (Q[2] & Q[1] & Q[0]), Q[2] ^ (Q[1] & Q[0]), Q[1] ^ Q[0], ~Q[0]};
	assign Count = {Q[3], Q[2], Q[1], Q[0]};
	
	assign Overflow = count10;
	assign resetWire = {Reset | (Q[3] & Q[0]), Reset | (Q[3] & Q[0]) | Preset, Reset | (Q[3] & Q[0]) | Preset, Reset | (Q[3] & Q[0])} ;
	
	
	
	DFlipFlop m[3:0] (.c(Clock), .r(resetWire), .p(Preset), .d(Din), .q(Q) );
	
	DFlipFlop m1 (.c(Clock),  .d(Q[3] & Q[0]), .q(count10));
	
endmodule
