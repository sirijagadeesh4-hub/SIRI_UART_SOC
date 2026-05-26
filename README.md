![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# SIRI_UART_SOC

UART based System-on-Chip (SoC) designed using Verilog HDL for Tiny Tapeout.

## Project Overview

This project implements a simple UART receiver SoC.

The design receives serial UART data through the input pin and converts it into parallel output data using internal shift registers and sequential logic.

## Features

* UART serial receiver
* Parallel data output
* TinyTapeout compatible
* Verilog RTL implementation
* Simple synthesizable architecture

## Top Module

tt_um_siri_uart_soc

## Pin Description

| Pin         | Function             |
| ----------- | -------------------- |
| ui_in[0]    | UART RX serial input |
| uo_out[7:0] | Received UART data   |
| uio_out[0]  | Reception done flag  |
| clk         | System clock         |
| rst_n       | Active low reset     |

## Working

1. UART serial data enters through `ui_in[0]`
2. Bits are shifted into an internal register
3. After receiving all bits:

   * Data is available on `uo_out`
   * Done flag becomes high on `uio_out[0]`

## Simulation

Simulation is performed using:

* Icarus Verilog
* Cocotb Testbench

## Tiny Tapeout

https://tinytapeout.com

## Author

SIRI
