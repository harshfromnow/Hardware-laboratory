module subtractor(
	input [7:0]a,
	input [7:0]b,
	output reg [7:0]diff,
	output reg borrow
);

	always@(a,b)
	begin
	diff=a-b;
	if (a<b) borrow=1'b1;
	else borrow=1'b0;
	end
endmodule
