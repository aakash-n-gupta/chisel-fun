module adder32(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [32:0] io_sum
);
  assign io_sum = io_in_a + io_in_b; // @[adder32.scala 16:23]
endmodule
