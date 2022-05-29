/* Author: Ismael Contreras
*  Date: 12/10/2021
*
*  Purpose:
* 	Mux 2:1 used to limit/select the number of outputs 
*
*/
module DownCount(Clock, Reset, Preset, Overflow, Count);

	wire W, X, Y, Z;
		assign W = IWire[3];
		assign X = IWire[2];
		assign Y = IWire[1];
		assign Z = IWire[0];
		assign segment[0] = (~W &  ~X & ~Y & Z) | (~W & X & ~Y & ~Z) | (W & ~X & Y & Z) | (W & X & ~Y & Z);
		assign segment[1] = (~W &  X & ~Y & Z) | (W & Y & Z) | (X & Y & ~Z) | (W & X & ~Z);
		assign segment[2] = (~W & ~X & Y &  ~Z) | (W & X & ~Z) | (W & X & Y);
	   assign segment[3] = (~W & X & ~Y & ~Z) | (X & Y & Z) | (W & ~X & Y & ~Z) | (~W & ~X & ~Y & Z);
	   assign segment[4] = (~W & X & ~Y) | (~X & ~Y & Z) | (~W & Z) ;
		assign segment[5] = (~W & ~X & Z) | (~W & ~X & Y) |(~W & Y & Z) | (W & X & ~Y & Z) ;
		assign segment[6] = (~W & ~X & ~Y) | (~W & X & Y & Z) | (W & X & ~Y & ~Z);
	
	
endmodule

