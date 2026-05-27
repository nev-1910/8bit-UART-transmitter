import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


@cocotb.test()
async def test_uart_tx(dut):

    # Start clock
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Apply reset
    dut.rst_n.value = 0
    dut.ena.value = 1

    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await Timer(50, units="us")

    # Release reset
    dut.rst_n.value = 1

    # Send sample 8-bit data
    dut.ui_in.value = 0b10101010

    await Timer(200, units="us")

    # Print UART output
    print("UART TX Output:", dut.uo_out.value)
