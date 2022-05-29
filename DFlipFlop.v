/* Author: Ismael Contreras
*  Date: 11/5/2021
*
*  Purpose:
*  D- Flip Flop with a positive edge clock
*	Assign 0 if reset is 1
*	Assign 1 if preset is 1
* 	Assign q = d otherwise
*
*/

module DFlipFlop(c,r, p, d, q);

	input wire c,r,d, p;
	output  q;
	
	
	//Positive clock edge. 
	reg q;
	
	always @(posedge c) 
		if (r)
			q <= 0;
		else if (p)
			q <= 1;
		else 
			q <=d;
			

		
endmodule 
