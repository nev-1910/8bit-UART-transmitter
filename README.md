# 8-bit UART Transmitter using TinyTapeout

## Project Overview

This project implements a simple 8-bit UART (Universal Asynchronous Receiver Transmitter) Transmitter using Verilog HDL in the TinyTapeout framework.

The design accepts 8-bit parallel input data and transmits it serially through a UART TX output line.

---

## Features

- 8-bit data transmission
- Serial UART output
- TinyTapeout compatible
- Simple single-module architecture
- Designed for 1x1 TinyTapeout tile

---

## Working Principle

1. 8-bit parallel data is given through input pins.
2. The UART transmitter sends:
   - Start bit
   - 8 data bits
   - Stop bit
3. Serial data appears at UART TX output.

---

## Inputs

| Pin | Function |
|-----|----------|
| ui[0] | Data bit 0 |
| ui[1] | Data bit 1 |
| ui[2] | Data bit 2 |
| ui[3] | Data bit 3 |
| ui[4] | Data bit 4 |
| ui[5] | Data bit 5 |
| ui[6] | Data bit 6 |
| ui[7] | Data bit 7 |

---

## Outputs

| Pin | Function |
|-----|----------|
| uo[0] | UART TX Output |

---

## Tools Used

- Verilog HDL
- TinyTapeout
- GitHub Actions
- Cocotb
- GTKWave

---

## Author

Nevin Philip
