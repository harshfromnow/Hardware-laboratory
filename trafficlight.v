module trafficlight(
  input clk,
  output reg nsgreen,
  output reg nsred,
  output reg ewgreen,
  output reg ewred
);

  reg [1:0] current_state =2'b00;
  reg [1:0] next_state=2'b01;
  reg [1:0] counter=2'b00;

  always @(posedge clk) begin
    current_state = next_state;
	 
    case (current_state)
      2'b00: begin
        nsgreen <= 1;
        nsred <= 0;
        ewred <= 1;
        ewgreen <= 0;
		  counter <= (counter+1)%3;
        if (counter == 2) begin
          next_state <= 2'b01;
        end
        else begin
          next_state <= current_state;
        end
      end
      2'b01: begin
        nsgreen <= 0;
        nsred <= 1;
        ewgreen <= 1;
        ewred <= 0;
		  counter <= (counter+1)%3;
        if (counter == 2) begin
          next_state <= 2'b00;
        end
        else begin
          next_state <= current_state;
        end
      end
    endcase
  end
endmodule

//TESTBENCH


