`timescale 1ns / 100ps

module test;


initial begin
  $dumpfile("TESTWAV.vcd");
  $dumpvars(0,test);
end

event		error_event;

reg clk = 0;
always #10 clk = !clk;

reg [1:0] fpu_rmode = 0; //round to nearest even

reg [2:0] fpu_op = 0; // div


reg [31:0] opa = 32'h41c00000; //24
reg [31:0] opb = 32'h41200000; // 10

// Should get 28

wire [31:0] out;
wire snan, qnan, inf, ine, overflow, underflow, div_by_zero, zero;

fpu u0(clk, fpu_rmode, fpu_op, opa, opb, out, snan, qnan, inf, ine, overflow, underflow, div_by_zero, zero);


initial begin
  #1000 $finish;
end

initial begin
  $display("time\topa\topb\tout");
  $monitor("%0d,\t%h,\t%h,\t%h,", $time, opa,opb,out);
end


endmodule // test
