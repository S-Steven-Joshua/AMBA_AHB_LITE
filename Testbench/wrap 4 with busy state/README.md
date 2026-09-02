<img width="1581" height="803" alt="Image" src="https://github.com/user-attachments/assets/82fa057e-7ae1-4432-bfd3-d51987595e08" />

# AHB WRAP4 Burst — HSIZE = 2 with BUSY State

The waveform shows a **4-beat AHB WRAP4 write burst** with `HSIZE = 2`, so each transfer is **4 bytes**. A `BUSY` transfer occurs between Beat 2 and Beat 3.

> **Important:** The timing below is taken from the **`Haddr` signal**, not `Haddr_m`.  
> In the waveform, **Beat 1 address phase starts at 45 ns**.

## Burst Configuration

- Starting address: `0x0000_0010`
- `HBURST = 2` → `WRAP4`
- `HSIZE = 2` → 4-byte transfer
- Number of data beats: 4
- `HWRITE = 1`
- First transfer: `HTRANS = NONSEQ`
- Following data transfers: `HTRANS = SEQ`
- One `HTRANS = BUSY` occurs between Beat 2 and Beat 3

## Address and Transfer Sequence

From the waveform, the relevant `Haddr` and `Htrans` timing is:

| Time | `Haddr` | `Htrans` | Description |
|---|---|---|---|
| 0–45 ns | `0x0000_0000` | `IDLE` | Bus idle |
| **45–55 ns** | **`0x0000_0010`** | **`NONSEQ`** | **Beat 1 address phase** |
| **55–65 ns** | **`0x0000_0014`** | **`SEQ`** | **Beat 2 address phase** |
| **65–75 ns** | **`0x0000_0018`** | **`BUSY`** | **Beat 3 address is generated during BUSY** |
| **75–85 ns** | **`0x0000_0018`** | **`SEQ`** | **Beat 3 transfer** |
| **85–95 ns** | **`0x0000_001C`** | **`SEQ`** | **Beat 4 transfer** |

## Beat 1

**45–55 ns**

- `Haddr = 0x0000_0010`
- `Htrans = NONSEQ`
- `Hwrite = 1`
- `Hburst = WRAP4`
- `Hsize = 2`

The first beat starts at **45 ns**, as seen on the `Haddr` waveform.

## Beat 2

**55–65 ns**

- `Haddr = 0x0000_0014`
- `Htrans = SEQ`
- `Hwrite = 1`
- `Hburst = WRAP4`
- `Hsize = 2`

The address increments by 4 bytes:

```text
0x10 → 0x14
```

## BUSY State and Beat 3 Address

**65–75 ns**

- `Htrans = BUSY`
- `Haddr = 0x0000_0018`

This is the important behavior shown in the waveform.

During the **BUSY interval**, the master has already generated the **next address, `0x0000_0018`, for Beat 3**.

The BUSY transfer is **not an additional data beat**. It temporarily delays the sequential transfer while the next address is present on `Haddr`.

## Beat 3

The next address generated during BUSY is `0x0000_0018`.

**75–85 ns**

- `Haddr = 0x0000_0018`
- `Htrans = SEQ`
- `Hwrite = 1`
- `Hburst = WRAP4`
- `Hsize = 2`

Thus, the address `0x18` is prepared during BUSY and the actual sequential transfer follows at 75 ns.

## Beat 4

**85–95 ns**

- `Haddr = 0x0000_001C`
- `Htrans = SEQ`
- `Hwrite = 1`
- `Hburst = WRAP4`
- `Hsize = 2`

The address progression is:

```text
Beat 1 : 0x0000_0010
Beat 2 : 0x0000_0014
Beat 3 : 0x0000_0018
Beat 4 : 0x0000_001C
```

## Transaction Summary

| Beat | Address | Address/Control Interval | `HTRANS` | Data Interval |
|---|---|---|---|---|
| 1 | `0x0000_0010` | **45–55 ns** | `NONSEQ` | 55–65 ns |
| 2 | `0x0000_0014` | **55–65 ns** | `SEQ` | 65–75 ns |
| — | `0x0000_0018` | **65–75 ns** | `BUSY` | No new data beat |
| 3 | `0x0000_0018` | **75–85 ns** | `SEQ` | 75–85 ns / corresponding data phase |
| 4 | `0x0000_001C` | **85–95 ns** | `SEQ` | 85–95 ns / corresponding data phase |

### Key Observation

The waveform should be interpreted using **`Haddr`** for the actual bus address timing:

```text
45 ns : Beat 1 address = 0x10, HTRANS = NONSEQ
55 ns : Beat 2 address = 0x14, HTRANS = SEQ
65 ns : Beat 3 address = 0x18, HTRANS = BUSY
75 ns : Beat 3 continues with HTRANS = SEQ
85 ns : Beat 4 address = 0x1C, HTRANS = SEQ
```

The **BUSY state is between Beat 2 and Beat 3**, and the **Beat 3 address (`0x18`) is already driven on `Haddr` during the BUSY interval**.
