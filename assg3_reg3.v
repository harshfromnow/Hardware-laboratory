module B220031CS_HARSHINI_3 (
    input clk,              
    input reset,            
    input read_enable,    
    output reg [15:0] data_out, 
    input write_enable,     
    input [15:0] data_in 
);

    reg [15:0] reg_data;

    always @(posedge clk) begin
        if (reset) begin
            reg_data <= 16'h0000; 
            data_out <= 16'h0000; 
        end
        else begin
			  if (write_enable) begin
							reg_data <= data_in; 
							data_out <= 0;
				end
            else if (read_enable) 
                data_out <= reg_data; 
			end
		end
endmodule

//TESTBENCH

module B220031CS_HARSHINI_tb_3;
    reg clk;
    reg reset;
    reg read_enable;
    reg write_enable;
    reg [15:0] data_in;
    wire [15:0] data_out;
    
		B220031CS_HARSHINI_3 uut (
        .clk(clk),
        .reset(reset),
        .read_enable(read_enable),
        .data_out(data_out),
        .write_enable(write_enable),
        .data_in(data_in)
    );
    integer count;
	 
    initial clk=1;
	 initial reset=0;
    always #5 clk=~clk;

    initial begin
		  for(count=0;count<50;count=count+1) begin
				read_enable=$random;
				write_enable=$random;
				data_in=$random;
				#10;
			end
        #10 $finish;
    end
    
endmodule
