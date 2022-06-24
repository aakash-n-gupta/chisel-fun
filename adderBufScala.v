module adderBufScala(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [32:0] io_sum
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_in_a; // @[adderBufScala.scala 14:27]
  reg [31:0] reg_in_b; // @[adderBufScala.scala 15:27]
  reg [32:0] reg_sum; // @[adderBufScala.scala 16:26]
  wire [32:0] sum = reg_in_a + reg_in_b; // @[adderBufScala.scala 22:24]
  assign io_sum = reg_sum; // @[adderBufScala.scala 24:12]
  always @(posedge clock) begin
    if (reset) begin // @[adderBufScala.scala 14:27]
      reg_in_a <= 32'h0; // @[adderBufScala.scala 14:27]
    end else begin
      reg_in_a <= io_in_a; // @[adderBufScala.scala 19:14]
    end
    if (reset) begin // @[adderBufScala.scala 15:27]
      reg_in_b <= 32'h0; // @[adderBufScala.scala 15:27]
    end else begin
      reg_in_b <= io_in_b; // @[adderBufScala.scala 20:14]
    end
    if (reset) begin // @[adderBufScala.scala 16:26]
      reg_sum <= 33'h0; // @[adderBufScala.scala 16:26]
    end else begin
      reg_sum <= sum; // @[adderBufScala.scala 23:13]
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
  reg_in_a = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_in_b = _RAND_1[31:0];
  _RAND_2 = {2{`RANDOM}};
  reg_sum = _RAND_2[32:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
