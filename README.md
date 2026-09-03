# AMBA AHB-Lite RTL Implementation & Verification

A **SystemVerilog RTL implementation of the AMBA 3 AHB-Lite protocol**, developed and verified using **Xilinx Vivado**.

This project implements an AHB-Lite master-side transaction engine, a memory-based AHB-Lite slave, and a modular set of testbenches covering single transfers, incrementing bursts, wrapping bursts, `BUSY` transfers, undefined-length `INCR` bursts, alignment checks, address-range errors, and `HREADY`/`HRESP` error responses.

---

## Overview

The project is organized around a simple AHB-Lite master/slave system:

```text
                  Testbench
                      |
                      | Master stimulus
                      | Haddr_m
                      | Hwdata_m
                      | Hwrite_m
                      | Htrans_m
                      | Hburst_m
                      | Hsize_m
                      v
             +---------------------+
             |   ahb_master_lite   |
             |                     |
             | Transfer sequencing  |
             | Burst handling       |
             | Address generation   |
             +----------+----------+
                        |
                        | AHB-Lite bus
                        |
                        v
             +---------------------+
             |      ahb_slave      |
             |                     |
             | Address checking    |
             | Alignment checking  |
             | Read / Write logic  |
             | RAM model           |
             | HREADY / HRESP      |
             +----------+----------+
                        |
                        v
                  Memory (RAM)
```

### Testbench-to-Master Interface

In this implementation, the testbench provides the master transaction information through the `_m` signals.

```text
Haddr_m
Hwdata_m
Hwrite_m
Htrans_m
Hburst_m
Hsize_m
```

The `ahb_master_lite` module converts this stimulus into the AHB-Lite bus signals:

```text
Haddr
Hwdata
Hwrite
Htrans
Hburst
Hsize
```

The slave returns:

```text
Hready
Hresp
Hrdata
```

This makes the testbenches useful for directly controlling and observing different AHB-Lite transaction scenarios.

---

# Features

## AHB-Lite Transfer Support

The RTL supports the AHB-Lite transfer types:

| `HTRANS` | Transfer | Description |
|---|---|---|
| `2'b00` | `IDLE` | No active transfer |
| `2'b01` | `BUSY` | Inserted cycle within a burst |
| `2'b10` | `NONSEQ` | First transfer of a transaction/burst |
| `2'b11` | `SEQ` | Sequential transfer following `NONSEQ` |

The master implements these states internally as:

```text
idle
busy
nonseq
seq
```

and generates the corresponding `HTRANS` values.

---

# Transfer Size Support

The implementation supports `HSIZE` values up to `2`.

| `HSIZE` | Transfer Size |
|---:|---:|
| `3'b000` | 1 byte |
| `3'b001` | 2 bytes |
| `3'b010` | 4 bytes |

The transfer-byte calculation is based on:

```text
Transfer Bytes = 2^HSIZE
```

Therefore:

```text
HSIZE = 0  → 1 byte
HSIZE = 1  → 2 bytes
HSIZE = 2  → 4 bytes
```

The slave also implements byte, halfword, and word read/write handling corresponding to these sizes.

---

# Burst Support

The RTL includes handling for the AHB-Lite `HBURST` encodings.

| `HBURST` | Burst Type | Beats |
|---:|---|---:|
| `3'b000` | `SINGLE` | 1 |
| `3'b001` | `INCR` | Undefined length |
| `3'b010` | `WRAP4` | 4 |
| `3'b011` | `INCR4` | 4 |
| `3'b100` | `WRAP8` | 8 |
| `3'b101` | `INCR8` | 8 |
| `3'b110` | `WRAP16` | 16 |
| `3'b111` | `INCR16` | 16 |

The implementation calculates the expected burst length for defined 4-, 8-, and 16-beat bursts and uses the transfer size to determine address movement.

### Important Verification Note

The RTL supports the above burst encodings, but the verification environment does **not claim exhaustive coverage of every possible `HBURST × HSIZE` combination**.

The repository contains focused tests for selected combinations and protocol conditions. This distinction is intentional: the project demonstrates implementation support while documenting the combinations that have actually been exercised in simulation.

---

# Incrementing Bursts

The project verifies:

- `INCR4`
- `INCR8`
- `INCR16`
- Undefined-length `INCR`

For an incrementing burst, the address advances according to the transfer size:

```text
Next Address = Current Address + Transfer Bytes
```

Examples:

```text
HSIZE = 0  → address increment = 1 byte
HSIZE = 1  → address increment = 2 bytes
HSIZE = 2  → address increment = 4 bytes
```

The testbench collection also includes an **early termination of undefined INCR** scenario.

---

# Wrapping Bursts

The project includes verification for:

- `WRAP4`
- `WRAP8`
- `WRAP16`


The master calculates the wrapping boundary from the burst length and transfer size.

Conceptually:

```text
Burst Bytes = Number of Beats × Transfer Bytes

Lower Boundary = Start Address & ~(Burst Bytes - 1)

Upper Boundary = Lower Boundary + Burst Bytes - 1
```

When the next sequential address reaches the wrapping boundary, the address returns to the lower boundary.

---

# BUSY Transfer

The implementation supports the AHB-Lite `BUSY` transfer type.

A dedicated testbench verifies a burst containing a `BUSY` state:

```text
wrap4 with busy state
```

The master preserves the current burst address during a `BUSY` cycle rather than advancing the address as it would for a completed sequential transfer.

This is an important part of the burst-control logic.

---

# Single Read and Write

Dedicated verification is provided for single read and write transactions with different transfer sizes.

The tests exercise:

```text
Write
Read
HSIZE = 0
HSIZE = 1
HSIZE = 2
```

The slave maps byte and halfword accesses into the appropriate portions of its 32-bit memory word and supports full-word transfers for `HSIZE=2`.

---

# Address Alignment Verification

The project contains a dedicated **Unaligned address** test.

The slave checks address alignment based on `HSIZE`.

### Byte Transfer

```text
HSIZE = 0
```

Any byte address is valid from an alignment perspective.

### Halfword Transfer

```text
HSIZE = 1
```

The least-significant address bit must be zero:

```text
HADDR[0] == 0
```

### Word Transfer

```text
HSIZE = 2
```

The two least-significant address bits must be zero:

```text
HADDR[1:0] == 2'b00
```

An address that does not satisfy the required alignment is treated as an invalid transfer condition.

---

# Address Out-of-Range Verification

The slave memory uses the address range:

```text
0x0000_0000 – 0x0000_03FF
```

A dedicated **Address out of range** test verifies invalid accesses.

For example:

```text
Maximum valid address = 0x0000_03FF
Access address        = 0x0000_0400
```

Since:

```text
0x0000_0400 > 0x0000_03FF
```

the access is outside the valid address range.

The slave detects the invalid address and generates an AHB-Lite ERROR response.

---

# HREADY and HRESP Error Response

The project explicitly verifies the slave response mechanism using `HREADY` and `HRESP`.

For an invalid access, the implemented response sequence is:

```text
First response cycle:
    HREADY = 0
    HRESP  = 1

Second response cycle:
    HREADY = 1
    HRESP  = 1
```

This provides a two-cycle ERROR response.

The verification includes both:

- Out-of-range write access
- Out-of-range read access

### Example

For:

```text
HADDR = 0x0000_0400
```

the address is outside:

```text
0x0000_0000 – 0x0000_03FF
```

and the slave responds with:

```text
HREADY : 0 → 1
HRESP  : 1 → 1
```

The waveform-based tests are used to verify that the response is held for the first cycle and completed during the second cycle.

---

# Slave Response State Machine

The slave uses dedicated response states:

```text
normal
error_wait
error_done
```

The intended response flow is:

```text
                 Invalid transfer
                        |
                        v
                    ERROR
                        |
                        v
                 error response
                        |
             +----------+----------+
             |                     |
        First cycle           Second cycle
        HREADY = 0             HREADY = 1
        HRESP  = 1             HRESP  = 1
             |                     |
             +----------+----------+
                        |
                        v
                     normal
```

This separates normal transfer handling from ERROR-response generation.

---

# Undefined INCR and Burst Termination

The repository contains dedicated scenarios for undefined-length incrementing bursts:

```text
Undefined INCR Write
Undefined INCR write and read
Early termination of burst in undefined INCR
```

These tests verify that an undefined-length incrementing burst can continue with sequential transfers and that the burst can be terminated by the master.

---

# Verification Testbench Structure

The repository contains focused test directories rather than one large monolithic testbench.

Current verification scenarios include:

```text
Testbench/
│
├── Address out of range
├── Early termination of burst in undefined INCR
├── INCR 16
├── INCR4
├── INCR8
├── Single Write and Single Read for different HSize
├── Unaligned address
├── Undefined INCR Write
├── Undefined INCR write and read
├── Wrap 4 with Hsize=0
├── Wrap 4 with Hsize=1
├── Wrap 4 with Hsize=2
├── Wrap 8
├── wrap 16 Hsize=2
└── wrap4 with busy state
```

Each scenario is intended to isolate a particular AHB-Lite feature or corner condition, making waveform debugging easier.

---

# Verification Coverage

| Feature / Scenario | Status |
|---|:---:|
| Single Write | ✓ |
| Single Read | ✓ |
| Different `HSIZE` values | ✓ |
| `INCR4` | ✓ |
| `INCR8` | ✓ |
| `INCR16` | ✓ |
| Undefined `INCR` Write | ✓ |
| Undefined `INCR` Write and Read | ✓ |
| Early Undefined `INCR` Termination | ✓ |
| `WRAP4` | ✓ |
| `WRAP4` with `HSIZE=0` | ✓ |
| `WRAP4` with `HSIZE=1` | ✓ |
| `WRAP4` with `HSIZE=2` | ✓ |
| `WRAP8` | ✓ |
| `WRAP16` with `HSIZE=2` | ✓ |
| `BUSY` state in burst | ✓ |
| Unaligned address | ✓ |
| Address out of range | ✓ |
| `HREADY` response behavior | ✓ |
| `HRESP` ERROR response | ✓ |

> **Note:** A check mark means that a corresponding verification scenario exists in the repository. It does not imply exhaustive verification of every parameter combination.

---

# RTL Files

The main RTL directory contains:

```text
RTL/
├── ahb_master_lite.sv
├── ahb_slave.sv
└── ahb_top.sv
```

### `ahb_master_lite.sv`

Responsible for master-side:

- Transfer sequencing
- `HTRANS` generation
- Burst tracking
- Beat counting
- Address generation
- Incrementing burst handling
- Wrapping burst handling
- `BUSY` handling
- Transfer-size tracking
- Write-data pipelining
- Response-aware state transitions

### `ahb_slave.sv`

Responsible for:

- Address capture
- Address-range validation
- Alignment validation
- Read operations
- Write operations
- RAM storage
- `HREADY` generation
- `HRESP` ERROR response generation
- Read-data generation

### `ahb_top.sv`

Provides the top-level integration of the master and slave for simulation.

---

# Verification Methodology

The current verification approach is **directed, scenario-based, waveform-driven verification**.

Each testbench applies a specific transaction condition and the resulting waveform is inspected for correct protocol behavior.

The verification focuses on:

```text
Stimulus
   ↓
Master transaction generation
   ↓
AHB-Lite bus behavior
   ↓
Slave response
   ↓
Waveform verification
```

Particular attention is given to the relationship between:

```text
HADDR
HWRITE
HTRANS
HBURST
HSIZE
HWDATA
HRDATA
HREADY
HRESP
```

---

# Development Environment

| Item | Environment |
|---|---|
| HDL | SystemVerilog |
| FPGA/EDA Tool | Xilinx Vivado |
| Verification | RTL simulation + waveform inspection |
| Version Control | Git / GitHub |

---

# Project Goals

The project was developed to gain practical experience with:

- AMBA AHB-Lite protocol implementation
- RTL design using SystemVerilog
- Master/slave transaction sequencing
- Burst address generation
- Incrementing and wrapping bursts
- Transfer-size handling
- `BUSY` transfer behavior
- Undefined-length burst termination
- Address alignment checking
- Address-range checking
- `HREADY` response handling
- `HRESP` ERROR handling
- Directed RTL verification
- Waveform-based debugging

---

# Future Improvements

Possible next steps for the project include:

- SystemVerilog Assertions (SVA)
- Functional coverage
- Constrained-random transaction generation
- Automated scoreboard/checker
- Automated regression testing
- Additional wait-state scenarios
- More protocol-error scenarios
- Expanded `HBURST × HSIZE` coverage
- Formal verification of address and burst logic
- Continuous-integration simulation

---

# Author

**S-Steven-Joshua**

Repository:

**AMBA_AHB_LITE**

---

## Summary

This repository contains a practical **AMBA AHB-Lite RTL implementation and directed verification environment**.

The implementation supports:

```text
Transfer Types
    ├── IDLE
    ├── BUSY
    ├── NONSEQ
    └── SEQ

Transfer Sizes
    ├── 1 byte
    ├── 2 bytes
    └── 4 bytes

Burst Types
    ├── SINGLE
    ├── INCR
    ├── INCR4
    ├── INCR8
    ├── INCR16
    ├── WRAP4
    ├── WRAP8
    └── WRAP16

Verification
    ├── Single read/write
    ├── Burst transfers
    ├── BUSY state
    ├── Undefined INCR termination
    ├── Unaligned address
    ├── Address out of range
    └── HREADY / HRESP ERROR response
```

The project demonstrates both **protocol implementation** and **directed verification of important AHB-Lite corner cases**, while keeping implementation support separate from the specific combinations that have been exercised in simulation.
