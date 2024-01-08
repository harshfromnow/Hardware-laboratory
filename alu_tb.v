module alu_tb;
	reg [7:0]a;
	reg [7:0]b;
	reg [1:0]choice;
	wire [7:0]c;
	wire cout;
	wire borrow;
	
	alu uut(.a(a),.b(b),.choice(choice),.c(c),.cout(cout),.borrow(borrow));
	integer i,j,k;
	
	 initial begin
    for(i=0;i<256;i=i+1)
      begin
		for (j=0;j<256;j=j+1)
		 begin
		 for (k=0;k<4;k=k+1)
		  begin
		  choice=k;
        a=i;
		  b=j;
        #20;
		  end
      end
		end
  end
  endmodule
  