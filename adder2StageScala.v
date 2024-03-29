module adderGenerator(
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
module adder2StageScala(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_sum,
  output        io_out_carry
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] adder0_io_in_a; // @[adder2Stage.scala 26:24]
  wire [15:0] adder0_io_in_b; // @[adder2Stage.scala 26:24]
  wire  adder0_io_carry_in; // @[adder2Stage.scala 26:24]
  wire [15:0] adder0_io_sum; // @[adder2Stage.scala 26:24]
  wire  adder0_io_carry_out; // @[adder2Stage.scala 26:24]
  wire [15:0] adder1_io_in_a; // @[adder2Stage.scala 45:24]
  wire [15:0] adder1_io_in_b; // @[adder2Stage.scala 45:24]
  wire  adder1_io_carry_in; // @[adder2Stage.scala 45:24]
  wire [15:0] adder1_io_sum; // @[adder2Stage.scala 45:24]
  wire  adder1_io_carry_out; // @[adder2Stage.scala 45:24]
  reg [15:0] pipeline_reg_a; // @[adder2Stage.scala 19:33]
  reg [15:0] pipeline_reg_b; // @[adder2Stage.scala 20:33]
  reg  pipeline_cout0; // @[adder2Stage.scala 21:33]
  reg [31:0] buffer_out_sum; // @[adder2Stage.scala 23:33]
  reg  buffer_out_carry; // @[adder2Stage.scala 24:35]
  reg [15:0] pipeline_reg_sum0; // @[adder2Stage.scala 41:36]
  wire [31:0] _buffer_out_sum_T = {adder1_io_sum,pipeline_reg_sum0}; // @[Cat.scala 31:58]
  adderGenerator adder0 ( // @[adder2Stage.scala 26:24]
    .io_in_a(adder0_io_in_a),
    .io_in_b(adder0_io_in_b),
    .io_carry_in(adder0_io_carry_in),
    .io_sum(adder0_io_sum),
    .io_carry_out(adder0_io_carry_out)
  );
  adderGenerator adder1 ( // @[adder2Stage.scala 45:24]
    .io_in_a(adder1_io_in_a),
    .io_in_b(adder1_io_in_b),
    .io_carry_in(adder1_io_carry_in),
    .io_sum(adder1_io_sum),
    .io_carry_out(adder1_io_carry_out)
  );
  assign io_out_sum = buffer_out_sum; // @[adder2Stage.scala 58:16]
  assign io_out_carry = buffer_out_carry; // @[adder2Stage.scala 59:18]
  assign adder0_io_in_a = io_in_a[15:0]; // @[adder2Stage.scala 27:30]
  assign adder0_io_in_b = io_in_b[15:0]; // @[adder2Stage.scala 28:30]
  assign adder0_io_carry_in = 1'h0; // @[adder2Stage.scala 29:24]
  assign adder1_io_in_a = pipeline_reg_a; // @[adder2Stage.scala 46:20]
  assign adder1_io_in_b = pipeline_reg_b; // @[adder2Stage.scala 47:20]
  assign adder1_io_carry_in = pipeline_cout0; // @[adder2Stage.scala 48:24]
  always @(posedge clock) begin
    if (reset) begin // @[adder2Stage.scala 19:33]
      pipeline_reg_a <= 16'h0; // @[adder2Stage.scala 19:33]
    end else begin
      pipeline_reg_a <= io_in_a[31:16]; // @[adder2Stage.scala 34:20]
    end
    if (reset) begin // @[adder2Stage.scala 20:33]
      pipeline_reg_b <= 16'h0; // @[adder2Stage.scala 20:33]
    end else begin
      pipeline_reg_b <= io_in_b[31:16]; // @[adder2Stage.scala 35:20]
    end
    if (reset) begin // @[adder2Stage.scala 21:33]
      pipeline_cout0 <= 1'h0; // @[adder2Stage.scala 21:33]
    end else begin
      pipeline_cout0 <= adder0_io_carry_out; // @[adder2Stage.scala 36:20]
    end
    if (reset) begin // @[adder2Stage.scala 23:33]
      buffer_out_sum <= 32'h0; // @[adder2Stage.scala 23:33]
    end else begin
      buffer_out_sum <= _buffer_out_sum_T; // @[adder2Stage.scala 55:20]
    end
    if (reset) begin // @[adder2Stage.scala 24:35]
      buffer_out_carry <= 1'h0; // @[adder2Stage.scala 24:35]
    end else begin
      buffer_out_carry <= adder1_io_carry_out; // @[adder2Stage.scala 56:22]
    end
    if (reset) begin // @[adder2Stage.scala 41:36]
      pipeline_reg_sum0 <= 16'h0; // @[adder2Stage.scala 41:36]
    end else begin
      pipeline_reg_sum0 <= adder0_io_sum; // @[adder2Stage.scala 42:23]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pipeline_reg_a = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  pipeline_reg_b = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  pipeline_cout0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  buffer_out_sum = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  buffer_out_carry = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  pipeline_reg_sum0 = _RAND_5[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
