module locksystem(
    input clk,
    input reset,
    input [2:0] in,
    output reg locked, alarm, entimer,
    output reg [1:0] selsw
);

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, WRONG = 3'b100, UNLOCK = 3'b101;

    reg [2:0] current_state = S0, next_state = S0;
    reg [31:0] timeout = 'd0;

  always @(posedge clk) begin
    if (reset) begin  
      current_state <= S0;
    end else begin
      current_state <= next_state;
      if (current_state == UNLOCK) begin
        if (timeout == 9) begin  
          timeout <= 'd0;
        end else begin
          timeout <= timeout + 1;
        end
      end
    end
  end

    always @(in, current_state, timeout) begin
        case(current_state)
            S0: begin
                locked <= 1;
                alarm <= 0;
                entimer <= 1'b0;
                selsw <= 2'b00;
                if (in == 0) next_state <= S1;
                else next_state <= WRONG;
            end
            S1: begin
                locked <= 1;
                alarm <= 0;
                entimer <= 1'b0;
                selsw <= 2'b01;
                if (in == 1) next_state <= S2;
                else next_state <= WRONG;
            end
            S2: begin
                locked <= 1;
                alarm <= 0;
                entimer <= 1'b0;
                selsw <= 2'b10;
                if (in == 2) next_state <= S3;
                else next_state <= WRONG;
            end
            S3: begin
                locked <= 1;
                alarm <= 0;
                entimer <= 1'b0;
                selsw <= 2'b11;
                if (in == 3) next_state <= UNLOCK;
                else next_state <= WRONG;
            end
            WRONG: begin
                locked <= 1;
                alarm <= 0;
                entimer <= 1'b0;
                selsw <= 2'b00;
                next_state <= WRONG;
            end
            UNLOCK: begin
                locked <= 0;
                alarm <= 1;
                entimer <= 1'b1;
                selsw <= 2'b00;
                if (timeout == 9) next_state <= S0;
                else next_state <= UNLOCK;
            end
        endcase
    end
endmodule
