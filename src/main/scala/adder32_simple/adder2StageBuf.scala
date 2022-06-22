package adder2Stage

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

import adderGenerator._

class adder2Stage extends Module{
    val io = IO(new Bundle {
        val in_a = Input(UInt(32.W))
        val in_b = Input(UInt(32.W))

        val out_sum = Output(UInt(32.W))
        val out_carry = Output(UInt(1.W))
    })

    val out_reg = RegInit(UInt(16.W), 0.U)
    val pipeline_reg_a = RegInit(UInt(16.W), 0.U) // for the MSB bits to be processed in stage 2
    val pipeline_reg_b = RegInit(UInt(16.W), 0.U) // for the MSB bits to be processed in stage 2
    val pipeline_cout0 = RegInit(UInt(1.W), 0.U) // for carryout of adder0

    // creating input and output buffer regs for IO

    val adder0 = Module(new adderGenerator(16))
    adder0.io.in_a := io.in_a(15, 0)
    adder0.io.in_b := io.in_b(15, 0)
    adder0.io.carry_in := 0.U // 

    val sum0 = adder0.io.sum 
    val carry_out0 = adder0.io.carry_out

    pipeline_reg_a := io.in_a(31, 16)
    pipeline_reg_b := io.in_b(31, 16)
    pipeline_cout0 := carry_out0 
    // first stage of adder complete, results flushed in the pipelining regs


    // creating regs for stage 2
    val pipeline_reg_sum0 = RegInit(UInt(16.W), 0.U)

    // instanciating 2nd adder
    val adder1 = Module(new adderGenerator(16))
    adder1.io.in_a := pipeline_reg_a
    adder1.io.in_b := pipeline_reg_b
    adder1.io.carry_in := pipeline_cout0

    val sum1 = adder1.io.sum 
    val carry_out1 = adder1.io.carry_out //-- we ingore the carry out 

    // out_reg := sum0; // delay the adder0 result for 1 cycle to give entire 32bit output after 2 cycles

    io.out_sum := Cat(sum1, pipeline_reg_sum0)
    io.out_carry := carry_out1

}

object VerilogMain extends App{
    (new ChiselStage).emitVerilog(new adder2Stage)
}