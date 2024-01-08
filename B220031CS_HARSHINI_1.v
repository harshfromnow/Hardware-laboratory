//8 bit adder using behavioural modelling
module adder(
	input [7:0]a,
	input [7:0]b,
	output reg [7:0]sum,
	output reg cout
);

	always@(a,b)
	begin
	sum=a+b;
	if (a+b>255) cout=1'b1;
	else cout=1'b0;
	end
endmodule
