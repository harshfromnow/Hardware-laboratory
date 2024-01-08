module alu(
	input [7:0]a,b,
	input [1:0]choice,
	output reg borrow,cout,
	output reg [7:0]c
);
	always@(*)
	 begin
	 if (choice==2'b00) begin
		c=a+b;
		borrow=1'b0;
		if (a+b>255) cout=1'b1;
		else cout=1'b0;
	 end
	 else if (choice==2'b01) begin
		c=a-b;
		cout=1'b0;
		if (a<b) borrow=1'b1;
		else borrow=1'b0;
	 end
	 else if (choice==2'b10) begin
		borrow=1'b0;
		cout=1'b0;
		c=a^b;
	 end
	 else begin
		c=a<<1;
		borrow=1'b0;
		if (a<<1 > 255) cout=1'b1;
		else cout=1'b0;
	end
	end
endmodule

	