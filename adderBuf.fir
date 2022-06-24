circuit adderBuf :
  module adderBuf :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_a : UInt<32>, flip in_b : UInt<32>, sum : UInt<33>}

    reg reg_in_a : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[adderBuf.scala 14:27]
    reg reg_in_b : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[adderBuf.scala 15:27]
    reg reg_sum : UInt<33>, clock with :
      reset => (reset, UInt<33>("h0")) @[adderBuf.scala 16:26]
    reg_in_a <= io.in_a @[adderBuf.scala 19:14]
    reg_in_b <= io.in_b @[adderBuf.scala 20:14]
    node sum = add(reg_in_a, reg_in_b) @[adderBuf.scala 22:24]
    reg_sum <= sum @[adderBuf.scala 23:13]
    io.sum <= reg_sum @[adderBuf.scala 24:12]

