module B220031CS_HARSHINI_1(
	input clk,
	input reset,
	input [15:0]in,
	input read_write,
	output reg [15:0]out
);

	reg [15:0]data;
	
	always @(posedge clk) 
	if (reset)
		data <= 0;
	else begin
	if (read_write==0)
		out <= data;
	else begin
		out <= 0;
		data <= in;
	end
	end
	
endmodule

//TESTBENCH

module B220031CS_HARSHINI_tb_1();
	reg clk;
	reg reset;
	reg [15:0]in;
	reg read_write;
	wire [15:0]out;
	
	B220031CS_HARSHINI_1 uut(
		.clk(clk),
		.reset(reset),
		.in(in),
		.read_write(read_write),
		.out(out)
	);
	
	integer count;
	
	initial clk=1;
   always #10 clk=~clk;
	
	initial begin
	reset=0;
	for (count=0;count<100;count=count+1) begin
		in = $random;
		read_write= $random;
		#10;
		end
	end
endmodule
