# UART (Universal Asynchronous Receiver Transmitter) using Verilog

## Overview

This project implements a **basic 8N1 UART (Universal Asynchronous Receiver Transmitter)** in Verilog HDL. The design consists of a **parameterized Baud Rate Generator**, **UART Transmitter**, **UART Receiver**, and a **Top Module** integrating all modules. Functional verification is performed using a **loopback testbench**, where the transmitter output is internally connected to the receiver input to validate end-to-end communication.

---

## Features

- Parameterized Baud Rate Generator
- UART Transmitter (FSM Based)
- UART Receiver (FSM Based)
- 16× Oversampling Receiver
- Loopback Communication
- Busy (`busy`) and Ready (`rdy`) Status Signals
- Transmitter Ready (`tx_rdy`) Signal
- Synthesizable Verilog RTL
- Functional Testbench

---

# UART Configuration

This UART implementation follows the **8N1 UART** communication format.

**8N1** represents:

- **8** → 8 Data Bits
- **N** → No Parity Bit
- **1** → One Stop Bit

| Parameter | Value |
|-----------|-------|
| Communication Format | **8N1 UART** |
| Data Bits | **8** |
| Start Bits | **1** |
| Parity Bit | **None (N)** |
| Stop Bits | **1** |
| Baud Rate | **9600 bps (Default)** |
| Transmission Order | **LSB First** |
| Receiver Sampling | **16× Oversampling** |

---

## UART Frame Format

```
 ---------------------------------------------------------
| Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop |
 ---------------------------------------------------------
|   0   |               8-bit Data               |   1   |
 ---------------------------------------------------------
```

Each UART frame consists of:

- **1 Start Bit (Logic 0)**
- **8 Data Bits (LSB First)**
- **No Parity Bit**
- **1 Stop Bit (Logic 1)**

**Total Frame Length**

```
1 Start Bit + 8 Data Bits + 1 Stop Bit = 10 Bits
```

---

# Project Architecture

```
                 +----------------------+
                 | Baud Rate Generator  |
                 +----------+-----------+
                            |
                +-----------+-----------+
                |                       |
          tx_enable              rx_enable
                |                       |
                v                       v
          +-----------+          +-----------+
          | UART TX   |--------->| UART RX   |
          +-----------+    tx    +-----------+
                     \______________/
                       Loopback Test
```

---

# Project Modules

## 1. Baud Rate Generator

Generates baud-rate enable pulses required for UART communication.

### Inputs

- Clock
- Reset

### Outputs

- `tx_enable`
- `rx_enable`

---

## 2. UART Transmitter

Finite State Machine (FSM) responsible for serial data transmission.

### States

```
IDLE
  ↓
START
  ↓
DATA
  ↓
STOP
```

### Features

- Stores input data
- Sends Start Bit
- Transmits 8-bit data (LSB First)
- Sends Stop Bit
- Generates `busy` signal
- Generates `tx_rdy` signal

---

## 3. UART Receiver

Finite State Machine (FSM) responsible for serial data reception.

### States

```
START
  ↓
DATA
  ↓
STOP
```

### Features

- Detects Start Bit
- Uses **16× Oversampling**
- Samples each bit at its center
- Stores received data
- Generates `rdy` signal after successful reception

---

## 4. UART Top Module

Integrates:

- Baud Rate Generator
- UART Transmitter
- UART Receiver

The transmitter output (`tx`) is internally connected to the receiver input (`rx`) to perform loopback communication.

---

## 5. Testbench

The UART functionality is verified using a **loopback testbench**.

### Test Case 1

| Input | Output | Result |
|-------|--------|--------|
| `0x0E` | `0x0E` | ✅ PASS |

### Test Case 2

| Input | Output | Result |
|-------|--------|--------|
| `0xA1` | `0xA1` | ✅ PASS |

---

# Simulation Results

The simulation verifies:

- Successful UART transmission
- Successful UART reception
- Correct operation of `busy` signal
- Correct operation of `tx_rdy` signal
- Correct assertion of `rdy`
- Accurate reconstruction of transmitted data
- Loopback communication between transmitter and receiver

### Simulation Waveform

> *(Insert `UART_Waveform.png` here)*

---

# Applications

- Serial Communication Interfaces
- FPGA-Based Communication Systems
- Embedded Systems
- Microcontroller Communication
- Debug Interfaces
- Industrial Automation
- Sensor Communication

---

# Future Improvements

- Even/Odd Parity Support
- Configurable Stop Bits
- Configurable Data Width (5/6/7/8 Bits)
- FIFO Buffer Integration
- Framing Error Detection
- Parity Error Detection
- Overrun Error Detection
- Interrupt Support
- Configurable Baud Rate Register

---

# Tools Used

- Verilog HDL
- Xilinx Vivado 2016.4
- XSim Simulator

---

# Repository Structure

```
UART-Verilog/
│
├── baud_rate_generator.v
├── uart_tx.v
├── uart_rx.v
├── uart_top.v
├── uart_tb.v
├── UART_Waveform.png
└── README.md
```

---

# Key Concepts Learned

- Finite State Machine (FSM) Design
- UART Communication Protocol
- Asynchronous Serial Communication
- Baud Rate Generation
- Parameterized Verilog Design
- 16× Oversampling Technique
- Mid-Bit Data Sampling
- Loopback Verification
- RTL Design and Simulation
- Testbench Development

---

# Author

**Shrinithi**

Electronics and Communication Engineering (ECE) Student

**Areas of Interest**
- RTL Design
- Digital Design
- FPGA Design
- VLSI System Design
- Verilog HDL
