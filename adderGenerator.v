module adderGenerator(
  input         clock,
  input         reset,
  input  [15:0] io_in_a,
  input  [15:0] io_in_b,
  input         io_carry_in,
  output [15:0] io_sum,
  output        io_carry_out
);
  wire [16:0] _outWire_T = io_in_a + io_in_b; // @[adderGenerator.scala 21:24]
  wire [16:0] _GEN_0 = {{16'd0}, io_carry_in}; // @[adderGenerator.scala 21:35]
  wire [17:0] _outWire_T_1 = _outWire_T + _GEN_0; // @[adderGenerator.scala 21:35]
  wire [16:0] outWire = _outWire_T_1[16:0]; // @[adderGenerator.scala 20:23 21:13]
  assign io_sum = outWire[15:0]; // @[adderGenerator.scala 22:12]
  assign io_carry_out = outWire[16]; // @[adderGenerator.scala 23:28]
endmodule
