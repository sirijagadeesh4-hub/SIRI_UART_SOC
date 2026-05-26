import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge


@cocotb.test()
async def test_project(dut):

    # Start clock
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.rst_n.value = 0
    dut.ui_in.value = 0

    for _ in range(2):
        await RisingEdge(dut.clk)

    dut.rst_n.value = 1

    # Send 7-bit UART data = 1010101
    bits = [1, 0, 1, 0, 1, 0, 1]

    for bit in bits:
        dut.ui_in.value = bit
        await RisingEdge(dut.clk)

    # Wait one extra cycle
    await RisingEdge(dut.clk)

    # Check done signal
    assert dut.uio_out.value[0] == 1

    # Check received data
    assert dut.uo_out.value != 0

    cocotb.log.info("UART test passed")
