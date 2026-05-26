import cocotb
from cocotb.triggers import RisingEdge
from cocotb.clock import Clock

@cocotb.test()
async def test_uart(dut):

    # Start clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut.rst_n.value = 0
    dut.ui_in.value = 0

    for _ in range(5):
        await RisingEdge(dut.clk)

    dut.rst_n.value = 1

    # Send serial bits
    bits = [1,0,1,0,1,0,1]

    for b in bits:
        dut.ui_in.value = b
        await RisingEdge(dut.clk)

    # Wait
    await RisingEdge(dut.clk)

    # Print result
    print("UART DATA =", dut.uo_out.value)
