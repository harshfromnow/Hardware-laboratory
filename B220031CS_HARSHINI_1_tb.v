module adder_tb;
	reg [7:0]a;
	reg [7:0]b;
	wire [7:0]sum;
	wire cout;
	
	adder uut(.a(a),.b(b),.sum(sum),.cout(cout));
	integer i,j;
	
	 initial begin
    for(i=0;i<256;i=i+1)
      begin
		for (j=0;j<256;j=j+1)
		 begin
        a=i;
		  b=j;
        #20;
      end
		end
  end
  endmodule
  