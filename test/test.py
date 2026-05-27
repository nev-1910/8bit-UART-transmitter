import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer

@cocotb.test()
async def test_uart_tx(dut):

    # Start clock
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Initialize
    dut.rst_n.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0b10110011

    # Hold reset
    await Timer(20, unit="us")

    # Release reset
    dut.rst_n.value = 1

    # Allow UART FSM to run
    await Timer(300, unit="us")

    # If simulation reaches here, test passes
    dut._log.info("UART transmission simulation completed successfully.")
