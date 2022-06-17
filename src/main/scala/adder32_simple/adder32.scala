package adder32

import chisel3._
import chisel3.stage.ChiselStage
// import chisel3.util._
// import chisel3.tester._
// import chisel3.tester.RawTester.test

class adder32 extends Module {
    val io = IO(new Bundle {
        val in_a = Input(UInt(32.W))
        val in_b = Input(UInt(32.W))
        val sum = Output(UInt(33.W))    //the carry is the MSB bit, sum gives the correct 33bit output
    })

    io.sum := io.in_a +& io.in_b
}

object VerilogMain extends App {
    (new ChiselStage).emitVerilog(new adder32)
}

// println(getVerilog(new adder32))

// complete writing the test for the adder

// test(new adder32) {
//     c => scala.util.Random
//     val data = Random.nextInt()
// }