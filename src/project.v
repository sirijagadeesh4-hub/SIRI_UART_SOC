/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
assign uo_out  = uart_data;
assign uio_out = {7'b0000000, done_reg};
assign uio_oe  = 8'b00000001;
  // List all unused inputs to prevent warnings
wire _unused = &{ena, clk, rst_n, 1'b0};
 reg [6:0] shift_reg;
  reg [2:0] bit_count;
  reg done_reg;
  reg [7:0] uart_data;

  // UART receive logic
  always @(posedge clk) begin
    if (!rst_n) begin
      shift_reg <= 7'b0000000;
      bit_count <= 3'b000;
      uart_data <= 8'b00000000;
      done_reg <= 1'b0;
    end
    else begin
      done_reg <= 1'b0;

      // Shift serial input
      shift_reg <= {ui_in[0], shift_reg[6:1]};

      if (bit_count == 3'd6) begin
        uart_data[6:0] <= shift_reg;
        uart_data[7] <= 1'b0;
        done_reg <= 1'b1;
        bit_count <= 3'b000;
      end
      else begin
        bit_count <= bit_count + 1'b1;
      end
    end
  end

  // Keep template structure
  assign uo_out  = uart_data;
  assign uio_out = {7'b0000000, done_reg};
  assign uio_oe  = 8'b00000001;

  // List all unused inputs to prevent warnings
 wire _unused = &{
    ena,
    clk,
    rst_n,
    uio_in,
    ui_in[7:1],
    1'b0
};
endmodule
