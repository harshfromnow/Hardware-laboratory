module subtractor_tb;
	reg [7:0]a;
	reg [7:0]b;
	wire [7:0]diff;
	wire borrow;
	
	subtractor uut(.a(a),.b(b),.diff(diff),.borrow(borrow));
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
  