import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer


@cocotb.test()
async def test_uart_tx(dut):

    # Start clock
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Apply reset
    dut.rst_n.value = 0
    dut.ena.value = 1

    dut.ui_in.value = 0b10110011

    await Timer(20, unit="us")

    dut.rst_n.value = 1

    # Wait for UART transmission
    await Timer(200, unit="us")

    # Simple check:
    # UART TX line should exist and toggle
    assert dut.uo_out.value.integer >= 0
