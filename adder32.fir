circuit adder32 :
  module adder32 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_a : UInt<32>, flip in_b : UInt<32>, sum : UInt<33>}

    node _io_sum_T = add(io.in_a, io.in_b) @[adder32.scala 16:23]
    io.sum <= _io_sum_T @[adder32.scala 16:12]

