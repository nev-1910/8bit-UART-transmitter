# 8-bit UART Transmitter

## Project Description

This project implements a simple 8-bit UART transmitter using Verilog HDL in the TinyTapeout framework.

The design accepts 8-bit parallel input data and transmits it serially through the UART TX output pin.

---

## How it works

The UART transmitter takes 8-bit input data from the ui_in pins.

The transmitted UART frame contains:

1. Start bit
2. 8 data bits
3. Stop bit

The serial output is available on output pin uo[0].

The design works using the TinyTapeout system clock and reset signals.

---

## How to test

1. Apply reset using rst_n.
2. Provide 8-bit input data through ui_in[7:0].
3. Run the simulation using cocotb testbench.
4. Observe UART serial output on uo[0].
5. Verify output waveform using GTKWave.

---

## Inputs

| Pin | Description |
|-----|-------------|
| ui
