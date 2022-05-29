/* Author: Provided by instrucotr
*	ClockDivider Purpose:
*	Reduce 50Hz signal down to a 10Hz signal.
*
*/

module clockEnable(input wire clockIn, input wire reset, output wire clockPulse);
	
	localparam divisor = 9;
	reg[31:0] count;
	reg clockOut;
	always @(posedge clockIn, posedge reset)
	begin
		if(reset)begin
			count <= 32'b0;
			clockOut <= 1'b0;
		end
		else if(count == divisor) begin
			count <= 32'b0;
			clockOut <= 1'b1;
		end
		else begin
			count <= count +1;
			clockOut <= 1'b0;
		end
	end
	
	assign clockPulse = clockOut;
endmodule 
