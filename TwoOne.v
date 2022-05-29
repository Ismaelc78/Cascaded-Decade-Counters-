/* Author: Ismael Contreras
*  Date: 12/10/2021
*
*  Purpose:
* 	Mux 2:1 used to limit/select the number of outputs 
*
*/

module TwoOne(D1, D0, S, Out);

	input wire D1, D0, S;
	output wire Out;
	assign Out = ( S & D1) | (~S & D0);
	
endmodule 
