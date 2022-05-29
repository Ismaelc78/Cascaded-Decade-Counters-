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

module sevsenSeg( input wire [3:0]IWire, output wire [6:0]segment);
	
		
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
