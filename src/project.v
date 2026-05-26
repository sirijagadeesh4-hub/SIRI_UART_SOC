/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_siri_uart_soc(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1 when powered
    input  wire       clk,      // clock
    input  wire       rst_n     // active-low reset
);

  // UART internal registers
  reg [6:0] shift_reg;
  reg [2:0] bit_count;
  reg done_reg;
  reg [7:0] uart_data;

  // UART receive logic
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      shift_reg <= 7'b0000000;
      bit_count <= 3'b000;
      uart_data <= 8'b00000000;
      done_reg  <= 1'b0;
    end
    else begin
      done_reg <= 1'b0;

      // Shift serial input bit
      shift_reg <= {ui_in[0], shift_reg[6:1]};

      // Count received bits
      if (bit_count == 3'd6) begin
        uart_data[6:0] <= shift_reg;
        uart_data[7]   <= 1'b0;
        done_reg       <= 1'b1;
        bit_count      <= 3'b000;
      end
      else begin
        bit_count <= bit_count + 1'b1;
      end
    end
  end

  // Outputs
  assign uo_out  = uart_data;
  assign uio_out = {7'b0000000, done_reg};
  assign uio_oe  = 8'b00000001;

  // Prevent unused input warnings
  wire _unused = &{
    ena,
    uio_in,
    ui_in[7:1],
    1'b0
  };

endmodule

`default_nettype wire
