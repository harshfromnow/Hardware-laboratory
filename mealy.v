module mealy(
 input x,clk,reset,
 output reg out
 );

 parameter S0 = 0 , S1 = 1 , S2 = 2;
 reg [1:0] PS,NS ;

 always @ (posedge clk or posedge reset)
   if (reset)
     PS <= S0;  
   else
     PS <= NS;
   
 always @ (posedge clk or posedge reset)
   if (reset)
     out <= 1'b0;
   else
     out <= (PS == S2) && x;
  
 always @ (*)
  begin
    case(PS)
        S0 : NS = (x == 1) ? S1 : S0 ;
        S1 : NS = (x == 0) ? S2 : S1;
        S2 : NS = (x == 1) ? S1 : S0; 
    endcase
  end
  
 endmodule

//TESTBENCH

module mealy_tb;
 // Inputs
 reg x;
 reg clk;
 reg reset;
 // Outputs
 wire out;
 // Instantiate the Unit Under Test (UUT)
mealy uut (
    .x(x), 
    .clk(clk), 
    .reset(reset), 
    .out(out)
);


always #5 clk = ~ clk;  

initial begin
fork 
    clk = 1'b0;
    reset = 1'b1;
    #15 reset = 1'b0;
begin  
    x = 0;#10 x = 1 ; #10 x = 0 ; #10 x = 1;
    #10 x = 0;#10 x = 1 ; #10 x = 0 ; #10 x = 1 ;
    #10 x = 1;#10 x = 0 ; #10 x = 0 ; #10 x = 1 ;
    #10 x = 0;#10 x = 1 ; #10 x = 1 ; #10 x = 0 ;
    #10 $finish; 
end
join   
end  
endmodule
