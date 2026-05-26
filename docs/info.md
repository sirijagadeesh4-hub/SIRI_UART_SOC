# SIRI UART SOC

## Project Description
SIRI UART SOC is a simple UART receiver System-on-Chip designed using Verilog for Tiny Tapeout.

The design receives serial UART data through the input pin and converts it into parallel 8-bit data.

## Features
- UART serial receiver
- 8-bit parallel output
- TinyTapeout compatible
- Simple RTL architecture

## Inputs
| Pin | Description |
|-----|-------------|
| ui_in[0] | UART RX Serial Input |
| clk | System Clock |
| rst_n | Active Low Reset |

## Outputs
| Pin | Description |
|-----|-------------|
| uo_out[7:0] | Received UART Data |
| uio_out[0] | Data Ready Signal |

## How it Works
The UART receiver shifts incoming serial bits into a shift register.
After receiving 7 bits, the data is transferred to the output register and a done signal is generated.

## Testing
The design is tested using a Verilog testbench located in the `test` folder.
