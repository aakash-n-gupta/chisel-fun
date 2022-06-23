package adder32

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._
import chisel3.testers._
// import chisel3.tester.RawTester.test

class adder32 extends Module {
    val io = IO(new Bundle {
        val in_a = Input(UInt(32.W))
        val in_b = Input(UInt(32.W))
        val sum = Output(UInt(33.W))    //the carry is the MSB bit, sum gives the correct 33bit output
    })

    val in_a  = RegInit(io.in_a)
    val in_b  = RegInit(io.in_b)

    val sum = in_a +& in_b
    io.sum := sum
}

object VerilogMain extends App {
    (new ChiselStage).emitVerilog(new adder32)
}

// println(getVerilog(new adder32))

// complete writing the test for the adder
// class BasicTest extends AnyFlatSpec with ChiselScalatestTester {
    //   behavior of "MyModule"
  // test class body here

//   test(new adder32){ c =>
//   val cycles = 100
//   import scala.util.Random
//   for (i <- 0 until cycles){
//     val in_a = Random.nextInt(1000)
//     val in_b = Random.nextInt(1000)
//     c.io.in_a.poke(in_a.U)
//     c.io.in_c.poke(in_a.U)
//     c.io.out.out_sum.expect(in_a + in_b)
//     c.io.out.out_carry.expect(0.U)
//   }
//   }
