
module dlatch8bit_tb;
    reg [7:0] d;
    reg en, reset;
    wire [7:0] out;

    dlatch8bit uut (
        .d(d),
        .en(en),
        .reset(reset),
        .out(out)
    );

    initial begin
        d = $random; en = 0; reset = 1; #10;
        en = 1; #10;
        reset = 0; #10;
        reset = 1; en = 1; #10;
       
        d = $random;    
        en = 0; #10;
        reset = 0; #10;
        reset = 1; en = 1; #10;
       
        d = $random;    
        en = 0; #10;
        reset = 1; #10;
        reset = 1; en = 1; #10;
		  
		  d = $random; #10;    
        en = 0; #10;
        reset = 1; #10;
        reset = 1; en = 1; #10;
		  
		  d = $random; #10;    
        en = 0; #10;
        reset = 1; #10;
        reset = 1; en = 1; #10;
		  
		  d = $random;    
        en = 0; #10;
        reset = 0; #10;
        reset = 1; en = 1; #10;
		  
		  d = $random;    
        en = 0; #10;
        reset = 1; #10;
        reset = 1; en = 1; #10;
		  
		  d = $random;    
        en = 0; #10;
        reset = 0; #10;
        reset = 1; en = 1; #10;
       
        d = $random; #10;    
        en = 0; #10;
        reset = 0; #10;
        reset = 1; en = 1; #10; #150;
    end
endmodule
