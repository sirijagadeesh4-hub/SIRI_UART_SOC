# UART SoC

## Description
This project implements a 7-bit UART serial receiver SoC using Verilog for Tiny Tapeout.

## How it works
The design receives serial data through `ui[0]`. Each clock cycle, one bit is shifted into a 7-bit shift register. After receiving 7 bits, the data is converted into parallel form and displayed on `uo_out[6:0]`.

A done signal is generated on `uio[0]` to indicate successful reception of data.

### Inputs
- `ui[0]` → UART serial input
- `clk` → system clock
- `rst_n` → active-low reset

### Outputs
- `uo[6:0]` → received UART data
- `uo[7]` → unused
- `uio[0]` → done signal

## How to test
1. Apply reset (`rst_n = 0`) for one clock cycle.
2. Set `rst_n = 1`.
3. Send serial bits through `ui[0]`.
4. Provide one bit per clock cycle.
5. After 7 clock cycles, observe the received data on `uo_out[6:0]`.
6. Verify that `uio[0]` goes HIGH for one cycle to indicate completion.
