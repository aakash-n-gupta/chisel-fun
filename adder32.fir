circuit adder32 :
  module adder32 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_a : UInt<32>, flip in_b : UInt<32>, sum : UInt<33>}

    reg in_a : UInt, clock with :
      reset => (reset, io.in_a) @[adder32.scala 16:24]
    reg in_b : UInt, clock with :
      reset => (reset, io.in_b) @[adder32.scala 17:24]
    node sum = add(in_a, in_b) @[adder32.scala 19:20]
    io.sum <= sum @[adder32.scala 20:12]

