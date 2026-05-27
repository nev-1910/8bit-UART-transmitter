import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_uart_tx(dut):

    await Timer(1, unit="us")
