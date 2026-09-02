<img width="1585" height="868" alt="Image" src="https://github.com/user-attachments/assets/960dfea8-e831-4d20-96e1-7ca5bcfcdf33" />
## AHB WRAP4 Burst — 4-Byte Write and Read

The following simulation demonstrates an **AHB WRAP4 burst** for both **write and read operations** with `HSIZE = 2`.

The burst starts at address `0x0000_0014`. Since `HSIZE = 2`, each transfer is **4 bytes**. With `HBURST = 2`, the transfer is a **4-beat wrapping burst**.

### Burst Configuration

- Starting Address: `0x0000_0014`
- `HBURST = 2` (`WRAP4`)
- `HSIZE = 2` (4 bytes)
- Number of Beats: 4
- Transfer Size: 4 bytes
- `HWRITE = 1` for write burst
- `HWRITE = 0` for read burst

---

## 1. AHB WRAP4 Write Burst

The write burst starts at **45 ns** with the initial address `0x0000_0014`.

### Beat 1

- **45 ns – 55 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 1`
  - `HBURST = WRAP4`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = NONSEQ`

- **55 ns – 65 ns:** Data phase
  - Write data (`HWDATA`): First burst data

### Beat 2

- **55 ns – 65 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 1`
  - `HBURST = WRAP4`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **65 ns – 75 ns:** Data phase
  - Write data (`HWDATA`): Second burst data

### Beat 3

- **65 ns – 75 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 1`
  - `HBURST = WRAP4`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **75 ns – 85 ns:** Data phase
  - Write data (`HWDATA`): Third burst data

### Beat 4

- **75 ns – 85 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 1`
  - `HBURST = WRAP4`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **85 ns – 95 ns:** Data phase
  - Write data (`HWDATA`): Fourth burst data

---

## 2. AHB WRAP4 Read Burst

The read burst starts at **125 ns** with the same starting address `0x0000_0014`.

### Beat 1

- **125 ns – 135 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 0`
  - `HBURST = WRAP4`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = NONSEQ`

- **135 ns – 145 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0014`

### Beat 2

- **135 ns – 145 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 0`
  - `HBURST = WRAP4`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **145 ns – 155 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0018`

### Beat 3

- **145 ns – 155 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 0`
  - `HBURST = WRAP4`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **155 ns – 165 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_001C`

### Beat 4

- **155 ns – 165 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 0`
  - `HBURST = WRAP4`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **165 ns – 175 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0010`

---

## WRAP4 Transaction Summary

| Operation | Beat | Address Phase | Address | `HTRANS` | `HWRITE` | `HBURST` | `HSIZE` | Data Phase |
|-----------|------|---------------|---------|----------|----------|----------|---------|------------|
| Write | 1 | 45–55 ns | `0x0000_0014` | `NONSEQ` | `1` | `WRAP4` | `2` (4B) | 55–65 ns |
| Write | 2 | 55–65 ns | `0x0000_0018` | `SEQ` | `1` | `WRAP4` | `2` (4B) | 65–75 ns |
| Write | 3 | 65–75 ns | `0x0000_001C` | `SEQ` | `1` | `WRAP4` | `2` (4B) | 75–85 ns |
| Write | 4 | 75–85 ns | `0x0000_0010` | `SEQ` | `1` | `WRAP4` | `2` (4B) | 85–95 ns |
| Read | 1 | 125–135 ns | `0x0000_0014` | `NONSEQ` | `0` | `WRAP4` | `2` (4B) | 135–145 ns |
| Read | 2 | 135–145 ns | `0x0000_0018` | `SEQ` | `0` | `WRAP4` | `2` (4B) | 145–155 ns |
| Read | 3 | 145–155 ns | `0x0000_001C` | `SEQ` | `0` | `WRAP4` | `2` (4B) | 155–165 ns |
| Read | 4 | 155–165 ns | `0x0000_0010` | `SEQ` | `0` | `WRAP4` | `2` (4B) | 165–175 ns |

---

## Address Wrapping Calculation

For this transaction:

```text
HSIZE = 2
Transfer Size = 2^2 = 4 bytes

HBURST = WRAP4
Number of Beats = 4

Wrap Boundary = 4 × 4 bytes
              = 16 bytes
