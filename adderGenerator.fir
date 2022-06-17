circuit adderGenerator :
  module adderGenerator :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_a : UInt<16>, flip in_b : UInt<16>, flip carry_in : UInt<1>, sum : UInt<16>, carry_out : UInt<1>}

    wire outWire : UInt<17> @[adderGenerator.scala 20:23]
    node _outWire_T = add(io.in_a, io.in_b) @[adderGenerator.scala 21:24]
    node _outWire_T_1 = add(_outWire_T, io.carry_in) @[adderGenerator.scala 21:35]
    outWire <= _outWire_T_1 @[adderGenerator.scala 21:13]
    io.sum <= outWire @[adderGenerator.scala 22:12]
    node _io_carry_out_T = bits(outWire, 16, 16) @[adderGenerator.scala 23:28]
    io.carry_out <= _io_carry_out_T @[adderGenerator.scala 23:18]

