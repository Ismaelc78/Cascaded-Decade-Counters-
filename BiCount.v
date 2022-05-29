/* Author: Ismael Contreras
*  Date: 12/10/2021
*
*  Purpose:
*
* 	Decimal synchronous bi-directional counter circuit.
*	DownCounts from 9 - 0 then resets to 9. 
*	UpCounts from 0-9 then resets to 0.
*  Uses instances of D-FlipFLops to produce results
*
*/

module BiCount(Clock, Reset, Preset, Select, Count, Overflow);

	input wire Clock, Reset, Preset, Select;
	output wire [3:0] Count;
	output wire Overflow;
	wire [2:0]DownIn, UpIn;
	wire [3:0]Q, Din, resetWire;
	wire overflow;
	
	assign DownIn = { (Q[3] ~^ Q[0]) & ~Q[2] & ~Q[1]  , 
					(~Q[3] & Q[2] & (Q[1]|Q[0])) | (Q[3] & ~Q[2] & ~Q[1] & ~Q[0]), 
					(~Q[3]& Q[1] & Q[0]) | (~Q[3] & Q[2] & ~Q[1] & ~Q[0]) | (Q[3] & ~Q[2] & ~Q[1] & ~Q[0])};
					
	assign UpIn = {Q[3] ^ (Q[2] & Q[1] & Q[0]), Q[2] ^ (Q[1] & Q[0]), Q[1] ^ Q[0]};		
	
	assign Count = {Q[3], Q[2], Q[1], Q[0]};
	assign Din[0] = ~Q[0];
	
	
	//should have probably used another mux here
	assign resetWire =  {(~Select & Q[3] & Q[0] ) | Reset,
								(~Select & Q[3] & Q[0] ) | Reset | Preset,
								(~Select & Q[3] & Q[0] ) | Reset | Preset,
								(~Select & Q[3] & Q[0] ) | Reset };
								
	//should have probably used another mux here
	assign overflow = (~Q[3] & ~Q[2] & ~Q[1] & ~Q[0] & Select) | ~ Select & Q[3] & Q[0];
	
	
	TwoOne  t[2:0]( .D1(DownIn), .D0(UpIn), .S(Select), .Out(Din[3:1]) );
	DFlipFlop m[3:0] (.c(Clock), .r(resetWire), .p(Preset), .d(Din), .q(Q) );
	DFlipFlop of (.c(Clock), .r(Reset), .d(overflow), .q(Overflow));
	
	
endmodule
