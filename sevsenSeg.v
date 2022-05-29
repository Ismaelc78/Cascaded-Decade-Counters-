/* Author: Ismael Contreras
*  Date: 12/10/2021
*
*  Purpose:
* 	Mux 2:1 used to limit/select the number of outputs 
*
*/
module DownCount(Clock, Reset, Preset, Overflow, Count);

	input wire Clock, Reset, Preset;
	output wire Overflow;
	output wire [3:0] Count;
	wire [3:0] Q, resetWire, Din;
	assign Din = { (Q[3] ~^ Q[0]) & ~Q[2] & ~Q[1]  , 
					(~Q[3] & Q[2] & (Q[1]|Q[0])) | (Q[3] & ~Q[2] & ~Q[1] & ~Q[0]), 
					(~Q[3]& Q[1] & Q[0]) | (~Q[3] & Q[2] & ~Q[1] & ~Q[0]) | (Q[3] & ~Q[2] & ~Q[1] & ~Q[0]), 
					~Q[0]};
					
	assign Count = {Q[3], Q[2], Q[1], Q[0]};
	wire count10;
	assign Overflow = count10;
	assign resetWire = {Reset, Reset | Preset, Reset | Preset, Reset};
	
	
	DFlipFlop m[3:0] (.c(Clock), .r(resetWire), .p(Preset), .d(Din), .q(Q) );
	DFlipFlop m1 (.c(Clock), .r(Reset), .d(~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]), .q(count10));
	
endmodule

