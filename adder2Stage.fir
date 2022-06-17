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
    output io : { flip in_a : UInt<32>, flip in_b : UInt<32>, flip in_carry : UInt<32>, out_sum : UInt<32>, out_carry : UInt<32>}

    reg out_reg : UInt<16>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 20:26]
    reg pipeline_reg : UInt<16>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 21:31]
    reg pipeline_cout0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[adder2Stage.scala 22:33]
    inst adder0 of adderGenerator @[adder2Stage.scala 24:24]
    adder0.clock <= clock
    adder0.reset <= reset
    node _adder0_io_in_a_T = bits(io.in_a, 15, 0) @[adder2Stage.scala 25:30]
    adder0.io.in_a <= _adder0_io_in_a_T @[adder2Stage.scala 25:20]
    node _adder0_io_in_b_T = bits(io.in_a, 15, 0) @[adder2Stage.scala 26:30]
    adder0.io.in_b <= _adder0_io_in_b_T @[adder2Stage.scala 26:20]
    adder0.io.carry_in <= io.in_carry @[adder2Stage.scala 27:24]
    pipeline_reg <= adder0.io.sum @[adder2Stage.scala 32:18]
    pipeline_cout0 <= adder0.io.carry_out @[adder2Stage.scala 33:20]
    inst adder1 of adderGenerator_1 @[adder2Stage.scala 36:24]
    adder1.clock <= clock
    adder1.reset <= reset
    node _adder1_io_in_a_T = bits(io.in_a, 31, 16) @[adder2Stage.scala 37:30]
    adder1.io.in_a <= _adder1_io_in_a_T @[adder2Stage.scala 37:20]
    node _adder1_io_in_b_T = bits(io.in_a, 31, 16) @[adder2Stage.scala 38:30]
    adder1.io.in_b <= _adder1_io_in_b_T @[adder2Stage.scala 38:20]
    adder1.io.carry_in <= pipeline_cout0 @[adder2Stage.scala 39:24]
    out_reg <= adder0.io.sum @[adder2Stage.scala 44:13]
    node _io_out_sum_T = cat(adder1.io.sum, out_reg) @[Cat.scala 31:58]
    io.out_sum <= _io_out_sum_T @[adder2Stage.scala 46:16]
    io.out_carry <= adder1.io.carry_out @[adder2Stage.scala 47:18]

