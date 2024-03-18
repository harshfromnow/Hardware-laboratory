module B220031CS_HARSHINI_2 (
    input clk,              
    input reset,            
    input read_enable_1,    
    output reg [15:0] data_out_1, 
    input write_enable_1,   
    input write_enable_2,   
    input [15:0] data_in_1, 
    input [15:0] data_in_2  
);

    reg [15:0] reg_data;
    reg write_port_state; // Flip-flop to keep track of which write port to use

    always @(posedge clk or posedge reset)
    begin
        if (reset) begin
            reg_data <= 16'h0000; 
            data_out_1 <= 16'h0000; 
            write_port_state <= 1'b0; 
        end
        else begin
            if (read_enable_1) begin
                data_out_1 <= reg_data; 
            end else begin
                if (write_enable_1 || write_enable_2) begin
                    if (write_port_state == 1'b0) begin 
                        if (write_enable_1) begin
                            reg_data <= data_in_1; 
                        end
                        write_port_state <= 1'b1; 
                    end
                    else begin 
                        if (write_enable_2) begin
                            reg_data <= data_in_2; 
                        end
                        write_port_state <= 1'b0; 
                    end
                    data_out_1 <= 16'h0000; 
                end
            end
        end
    end

endmodule

//TESTBENCH

module B220031CS_HARSHINI_tb_2;
    reg clk;
    reg reset;
    reg read_enable_1;
    reg write_enable_1;
    reg write_enable_2;
    reg [15:0] data_in_1;
    reg [15:0] data_in_2;
    wire [15:0] data_out_1;
    
		B220031CS_HARSHINI_2 uut (
        .clk(clk),
        .reset(reset),
        .read_enable_1(read_enable_1),
        .data_out_1(data_out_1),
        .write_enable_1(write_enable_1),
        .write_enable_2(write_enable_2),
        .data_in_1(data_in_1),
        .data_in_2(data_in_2)
    );
    
    initial clk=1;
    always #2 clk=~clk;

    initial begin
		  reset=1; 
        clk = 0;
        read_enable_1 = 0;
        write_enable_1 = 0;
        write_enable_2 = 0;
        data_in_1 = 16'h456;
        data_in_2 = 16'h890;
        
        #2;
		  reset=0;
        read_enable_1 = 1;
		  #10
		  read_enable_1 = 0;
        
        write_enable_1 = 1;
        data_in_1 = 16'h1234;
        #10;
        write_enable_1 = 0;
        
        read_enable_1 = 1;
        #10;
        read_enable_1 = 0;

        write_enable_2 = 1;
        data_in_2 = 16'h5678;
        #10;
        write_enable_2 = 0;
        
        read_enable_1 = 1;
        #10;
        read_enable_1 = 0;
		  
		  write_enable_2 = 1;
        data_in_2 = 16'h7833;
        #10;
        write_enable_2 = 0;
		  
		  write_enable_1 = 1;
        data_in_1 = 16'h1002;
        #10;
        write_enable_1 = 0;
		  
		  read_enable_1 = 1;
        #10;
        read_enable_1 = 0;
        
        #10 $finish;
    end
    
endmodule


