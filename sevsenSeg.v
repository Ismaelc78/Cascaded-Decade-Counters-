/* Author: Ismael Contreras
*  Date: 10/3/2021
*  module: sevenSeg
*
*  Purpose: Set the segments of an active low seven segment display
*
*  Input: Four bits that represent a hexadecimal number 0 - F
*  Output: Seven-bit pattern that is a symbolic representation of input
*  Examples: 
*      __       Input    Hex Value    Output   
*     | 0|      0000       0         1000000    turn on all segments except 6
*    5|__|1     0001       1         1111001    turn on segments 1, 2
*		| 6|      1010       A         0001000    turn on all segments, except 3
*	  4|__|2     1111       F         0001110    turn on 6, 5, 4, 0
*		  3     
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
