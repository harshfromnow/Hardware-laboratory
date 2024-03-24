module regfile (
    input wire clk,
    input wire [2:0] read_port_1,
    input wire [2:0] read_port_2,
    input wire [2:0] write_port_1,
    input wire [7:0] write_data,
    input wire write_enable,
    output reg [7:0] read_data_1,
    output reg [7:0] read_data_2
);

reg [7:0] registers [7:0];

always @(posedge clk) begin
    if (write_enable) begin
        registers[write_port_1] <= write_data;
    end
else begin
    read_data_1 <= registers[read_port_1];
    read_data_2 <= registers[read_port_2];
end
end
endmodule

//TESTBENCH

module regfile_tb;

    reg clk;
    reg [2:0] read_port_1, read_port_2, write_port_1;
    reg [7:0] write_data;
    reg write_enable;
    wire [7:0] read_data_1, read_data_2;
    
    regfile regfile_inst (
        .clk(clk),
        .read_port_1(read_port_1),
        .read_port_2(read_port_2),
        .write_port_1(write_port_1),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin

        clk = 0;
        read_port_1 = 3'b000;
        read_port_2 = 3'b001;
        write_port_1 = 3'b010;
        write_data = 8'b11001100;
        write_enable = 1'b0;
        
        #5 write_enable = 1'b1;
        #5 write_data = 8'b10101010;
        #5 write_enable = 1'b0;
        #5 read_port_1 = 3'b011;
        #5 read_port_2 = 3'b010;
        #5 write_port_1 = 3'b111;
        #5 write_data = 8'b11110000;
        #5 write_enable = 1'b1;
        #5 write_enable = 1'b0;
        #5 write_enable = 1'b1;
        #5 write_data = 8'b01010101;
        #5 write_enable = 1'b0;
        #5 read_port_1 = 3'b100;
        #5 read_port_2 = 3'b101;
        #5 write_port_1 = 3'b011;
        #5 write_data = 8'b00110011;
        #5 write_enable = 1'b1;
        #5 write_enable = 1'b0;
        #5 read_port_1 = 3'b011;
        #5 read_port_2 = 3'b011;

        #100 $finish;
    end
    
endmodule
