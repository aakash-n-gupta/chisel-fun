circuit adder2Stage :
  module adderGenerator :
    input clock : Clock
    input reset : Reset
    output io : { flip in_a : UInt<16>, flip in_b : UInt<16>, flip carry_in : UInt<1>, sum : UInt<16>, carry_out : UInt<1>}

    wire outWire : UInt<17> @[adderGenerator.scala 20:23]
    node _outWire_T = add(io.in_a, io.in_b) @[adderGenerator.scala 21:24]
    node _outWire_T_1 = add(_outWire_T, io.carry_in) @[adderGenerator.scala 21:35]
    outWire <= _outWire_T_1 @[adderGenerator.scala 21:13]
    io.sum <= outWire @[adderGenerator.scala 22:12]
    node _io_carry_out_T = bits(outWire, 16, 16) @[adderGenerator.scala 23:28]
    io.carry_out <= _io_carry_out_T @[adderGenerator.scala 23:18]

  module adderGenerator_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip in_a : UInt<16>, flip in_b : UInt<16>, flip carry_in : UInt<1>, sum : UInt<16>, carry_out : UInt<1>}

    wire outWire : UInt<17> @[adderGenerator.scala 20:23]
    node _outWire_T = add(io.in_a, io.in_b) @[adderGenerator.scala 21:24]
    node _outWire_T_1 = add(_outWire_T, io.carry_in) @[adderGenerator.scala 21:35]
    outWire <= _outWire_T_1 @[adderGenerator.scala 21:13]
    io.sum <= outWire @[adderGenerator.scala 22:12]
    node _io_carry_out_T = bits(outWire, 16, 16) @[adderGenerator.scala 23:28]
    io.carry_out <= _io_carry_out_T @[adderGenerator.scala 23:18]

  module adder2Stage :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_a : UInt<32>, flip in_b : UInt<32>, out_sum : UInt<32>, out_carry : UInt<1>}

    reg pipeline_reg_a : UInt<16>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 19:33]
    reg pipeline_reg_b : UInt<16>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 20:33]
    reg pipeline_cout0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 21:33]
    reg buffer_out_sum : UInt<32>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 23:33]
    reg buffer_out_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 24:35]
    inst adder0 of adderGenerator @[adder2Stage.scala 26:24]
    adder0.clock <= clock
    adder0.reset <= reset
    node _adder0_io_in_a_T = bits(io.in_a, 15, 0) @[adder2Stage.scala 27:30]
    adder0.io.in_a <= _adder0_io_in_a_T @[adder2Stage.scala 27:20]
    node _adder0_io_in_b_T = bits(io.in_b, 15, 0) @[adder2Stage.scala 28:30]
    adder0.io.in_b <= _adder0_io_in_b_T @[adder2Stage.scala 28:20]
    adder0.io.carry_in <= UInt<1>("h0") @[adder2Stage.scala 29:24]
    node _pipeline_reg_a_T = bits(io.in_a, 31, 16) @[adder2Stage.scala 34:30]
    pipeline_reg_a <= _pipeline_reg_a_T @[adder2Stage.scala 34:20]
    node _pipeline_reg_b_T = bits(io.in_b, 31, 16) @[adder2Stage.scala 35:30]
    pipeline_reg_b <= _pipeline_reg_b_T @[adder2Stage.scala 35:20]
    pipeline_cout0 <= adder0.io.carry_out @[adder2Stage.scala 36:20]
    reg pipeline_reg_sum0 : UInt<16>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 41:36]
    pipeline_reg_sum0 <= adder0.io.sum @[adder2Stage.scala 42:23]
    inst adder1 of adderGenerator_1 @[adder2Stage.scala 45:24]
    adder1.clock <= clock
    adder1.reset <= reset
    adder1.io.in_a <= pipeline_reg_a @[adder2Stage.scala 46:20]
    adder1.io.in_b <= pipeline_reg_b @[adder2Stage.scala 47:20]
    adder1.io.carry_in <= pipeline_cout0 @[adder2Stage.scala 48:24]
    node _buffer_out_sum_T = cat(adder1.io.sum, pipeline_reg_sum0) @[Cat.scala 31:58]
    buffer_out_sum <= _buffer_out_sum_T @[adder2Stage.scala 55:20]
    buffer_out_carry <= adder1.io.carry_out @[adder2Stage.scala 56:22]
    io.out_sum <= buffer_out_sum @[adder2Stage.scala 58:16]
    io.out_carry <= buffer_out_carry @[adder2Stage.scala 59:18]

