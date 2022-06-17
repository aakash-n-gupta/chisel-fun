package adderGenerator

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

class adderGenerator(WIDTH: Int = 16)extends Module{
    val io = IO(new Bundle {
        val in_a = Input(UInt(WIDTH.W))
        val in_b = Input(UInt(WIDTH.W))
        val carry_in = Input(UInt(1.W))


        val sum = Output(UInt(WIDTH.W))
        val carry_out = Output(UInt(1.W))
    })
    // Cat(io.carry_out, io.sum) := io.in_a +& io.in_b +& io.carry_in
    // this did not work as chisel does not allow subword assignment
    val extendedWIDTH = WIDTH + 1
    val outWire = Wire(UInt((extendedWIDTH).W))
    outWire := io.in_a +& io.in_b +& io.carry_in
    io.sum := outWire
    io.carry_out := outWire(WIDTH)

}

object VerilogMain extends App {
    (new ChiselStage).emitVerilog(new adderGenerator(16))
}