module locksystem(
  input clk,
  input reset,
  input [3:0] in,
  output reg locked, alarm, entimer, selsw
);
  
  parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, WRONG = 3'b100, UNLOCK = 3'b101;
  
  reg [2:0] current_state = S0, next_state = S0;
  reg [31:0] counter = 0; 

  always @(posedge clk or posedge reset) begin
    if (reset) 
      current_state <= S0;
    else begin
      current_state <= next_state;
      if (current_state == UNLOCK) begin
        if (counter == 9) begin
          counter <= 0; 
        end
        else begin
          counter <= counter + 1;
        end
      end
    end
  end

  always @(current_state or in or counter) begin
    case(current_state)
      S0: begin
        locked <= 1'b1;
        alarm <= 1'b1;
        entimer <= 1'b0;
        selsw <= 2'b00;
        if (in == 0) next_state <= S1;
        else next_state <= WRONG;
      end
      S1: begin
        locked <= 1'b1;
        alarm <= 1'b1;
        entimer <= 1'b0;
        selsw <= 2'b01;
        if (in == 1) next_state <= S2;
        else next_state <= WRONG;
      end
      S2: begin
        locked <= 1'b1;
        alarm <= 1'b1;
        entimer <= 1'b0;
        selsw <= 2'b10;
        if (in == 2) next_state <= S3;
        else next_state <= WRONG;
      end
      S3: begin
        locked <= 1'b1;
        alarm <= 1'b1;
        entimer <= 1'b0;
        selsw <= 2'b11;
        if (in == 3) next_state <= UNLOCK;
        else next_state <= WRONG;
      end
      WRONG: begin
        locked <= 1'b1;
        alarm <= 1'b1;
        entimer <= 1'b0;
        selsw <= 2'b00;
        next_state <= S0;
      end
      UNLOCK: begin
        locked <= 1'b0;
        alarm <= 1'b0;
        entimer <= 1'b1;
        selsw <= 2'b00;
        if (counter == 9) next_state <= S0;
        else next_state <= UNLOCK;
      end
    endcase
  end
endmodule

//TESTBENCH

module locksystem_tb;
  reg clk, reset;
  reg [3:0] in;
  wire locked, alarm, entimer, selsw;
  
  locksystem uut (
    .clk(clk),
    .in(in),
    .locked(locked),
    .alarm(alarm),
    .reset(reset),
    .selsw(selsw),
    .entimer(entimer)
  );
  
  initial begin
    clk = 1;
    reset = 1;
    #30 reset = 0;
  end
  
  always #5 clk =~clk;
  
  initial begin
    #10 in = 0;
    #10 in = 1;
    #10 in = 2;
    #10 in = 3;
    #10 in = 4;
    #10 in = 0;
    #10 in = 3;
    #10 in = 0;
    #10 in = 1;
    #10 in = 2;
    #10 in = 8;
    #40 reset = 1;
  end
endmodule
