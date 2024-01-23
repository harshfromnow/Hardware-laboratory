module mealy(
  input clk,reset,inbits,
  output reg out
);
  reg [1:0] state,next_state;
  parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11 ;
  initial begin
    state = S0;
  end

  always@(posedge clk or posedge reset) 
  	if (reset==0) state <= S0;
	  else state<=next_state;
    always @ (state, inbits) 
    	case (state)
    		S0:
          if (inbits) next_state = S1; else next_state = S0;
    		S1:
          if (inbits) next_state = S1; else next_state = S2;
        S2:
          if (inbits) next_state = S3; else next_state = S0;
    		S3:
          if (inbits) next_state = S1; else next_state = S2;
    	endcase
always @ (state, x_in)
	case (state)
		S3:
			out = 1;
		S1, S2, S0: y_out = 0;
	endcase
endmodule
