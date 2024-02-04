module locksystem_tb;
    reg clk, reset;
    reg [2:0] in;
    wire locked, alarm, entimer;
    wire [1:0] selsw;

    locksystem uut(
        .clk(clk),
        .in(in),
        .locked(locked),
        .alarm(alarm),
        .reset(reset),
        .selsw(selsw),
        .entimer(entimer)
    );

    initial begin
        clk = 0;
        forever #5 clk=~clk;
	 end
	 initial #400 $stop;
	 
	 initial begin
	 reset=0;
	 
	 #5 reset=1;
	 #5 reset=0;
	 in=0;
	 #10 in =1;
	 #10 in=2;
	 #10 in=3;
	 #10 in=5;
	 #110 in=6;
	 #5 reset=1;
	 #5 reset=0;
	 in=0;
	 #10 in=1;
	 #10 in=2;
	 #10 in=3;
	 #10 in=5;
	 #110 in=6;
	 #10 in=7;
	 #10 in=8;
	 #10 reset=1;
	 #10 reset=0; in=5;
	end
endmodule
