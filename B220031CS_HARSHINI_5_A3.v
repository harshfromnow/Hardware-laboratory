module register_file (
    input wire clk,
    input wire [4:0] read_port_select,
    input wire [4:0] write_port_select,
    input wire [63:0] write_data_1,
    input wire [63:0] write_data_2,
    input wire write_enable_1,
    input wire write_enable_2,
    output reg [63:0] read_data_1,
    output reg [63:0] read_data_2,
    output reg [63:0] read_data_3,
    output reg [63:0] read_data_4
);

reg [63:0] registers [0:31];

always @(posedge clk) begin
    if (write_enable_1) begin
        registers[write_port_select] <= write_data_1;
    end
    if (write_enable_2) begin
        registers[write_port_select] <= write_data_2;
    end
end

always @* begin
    read_data_1 = registers[read_port_select];
    read_data_2 = registers[read_port_select];
    read_data_3 = registers[read_port_select];
    read_data_4 = registers[read_port_select];
end

endmodule

//TESTBENCH

module register_file_tb;

    // Signals
    reg clk = 0;
    reg [4:0] read_port_select, write_port_select;
    reg [63:0] write_data_1, write_data_2;
    reg write_enable_1, write_enable_2;
    wire [63:0] read_data_1, read_data_2, read_data_3, read_data_4;

    register_file regfile_inst (
        .clk(clk),
        .read_port_select(read_port_select),
        .write_port_select(write_port_select),
        .write_data_1(write_data_1),
        .write_data_2(write_data_2),
        .write_enable_1(write_enable_1),
        .write_enable_2(write_enable_2),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2),
        .read_data_3(read_data_3),
        .read_data_4(read_data_4)
    );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end

    // Clock generation
    always #(5) clk = ~clk; 

    // Stimulus
    initial begin

        read_port_select = 5'b00000;
        write_port_select = 5'b00000;
        write_data_1 = 64'h1111111111111111;
        write_data_2 = 64'h2222222222222222;
        write_enable_1 = 1;
        write_enable_2 = 1;

        #10;
        write_enable_1 = 0;
        write_enable_2 = 0;
        read_port_select = 5'b00001;
        write_port_select = 5'b00001;
        write_data_1 = 64'h3333333333333333;
        write_data_2 = 64'h4444444444444444;
        write_enable_1 = 1;
        write_enable_2 = 1;

        #100;
        $finish;
    end

endmodule
