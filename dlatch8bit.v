module dlatch8bit (
    input [7:0] d,
    input en,
    input reset,
    output reg [7:0] out
);

always @(*)
begin
    if (reset == 0) begin
        out <= 8'b00000000;
    end
    else if (en == 0) begin
        out <= d;
    end
end

endmodule
