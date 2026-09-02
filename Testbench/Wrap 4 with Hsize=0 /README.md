<img width="1586" height="866" alt="Image" src="https://github.com/user-attachments/assets/8983a427-352f-4d4b-818f-2e9716260d05" />
## AHB WRAP4 Burst — Write and Read

The following simulation demonstrates an **AHB WRAP4 burst** for both **write and read operations**.

The burst starts at address `0x0000_0012` with a transfer size of **1 byte**. Since `HBURST = 2`, the transfer is a **4-beat wrapping burst**.

### Burst Configuration

- Starting Address: `0x0000_0012`
- `HBURST = 2` (`WRAP4`)
- `HSIZE = 0` (1 byte)
- Number of Beats: 4
- Transfer Size: 1 byte
- `HWRITE = 1` for write burst
- `HWRITE = 0` for read burst

---

## 1. AHB WRAP4 Write Burst

The write burst starts at **45 ns** with the initial address `0x0000_0012`.

### Beat 1

- **45 ns – 55 ns:** Address phase
  - Address: `0x0000_0012`
  - `HWRITE = 1`
  - `HBURST = WRAP4`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = NONSEQ`

- **55 ns – 65 ns:** Data phase
  - Write data: First burst data

### Beat 2

- **55 ns – 65 ns:** Address phase
  - Address: `0x0000_0013`
  - `HWRITE = 1`
  - `HBURST = WRAP4`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = SEQ`

- **65 ns – 75 ns:** Data phase
  - Write data: Second burst data

### Beat 3

- **65 ns – 75 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 1`
  - `HBURST = WRAP4`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = SEQ`

- **75 ns – 85 ns:** Data phase
  - Write data: Third burst data

### Beat 4

- **75 ns – 85 ns:** Address phase
  - Address: `0x0000_0011`
  - `HWRITE = 1`
  - `HBURST = WRAP4`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = SEQ`

- **85 ns – 95 ns:** Data phase
  - Write data: Fourth burst data

---

## 2. AHB WRAP4 Read Burst

The read burst starts at **125 ns** with the same starting address `0x0000_0012`.

### Beat 1

- **125 ns – 135 ns:** Address phase
  - Address: `0x0000_0012`
  - `HWRITE = 0`
  - `HBURST = WRAP4`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = NONSEQ`

- **135 ns – 145 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0012`

### Beat 2

- **135 ns – 145 ns:** Address phase
  - Address: `0x0000_0013`
  - `HWRITE = 0`
  - `HBURST = WRAP4`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = SEQ`

- **145 ns – 155 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0013`

### Beat 3

- **145 ns – 155 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 0`
  - `HBURST = WRAP4`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = SEQ`

- **155 ns – 165 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0010`

### Beat 4

- **155 ns – 165 ns:** Address phase
  - Address: `0x0000_0011`
  - `HWRITE = 0`
  - `HBURST = WRAP4`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = SEQ`

- **165 ns – 175 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0011`

---

## WRAP4 Transaction Summary

| Operation | Beat | Address Phase | Address | `HTRANS` | `HWRITE` | `HBURST` | `HSIZE` | Data Phase |
|-----------|------|---------------|---------|----------|----------|----------|---------|------------|
| Write | 1 | 45–55 ns | `0x0000_0012` | `NONSEQ` | `1` | `WRAP4` | `0` (1B) | 55–65 ns |
| Write | 2 | 55–65 ns | `0x0000_0013` | `SEQ` | `1` | `WRAP4` | `0` (1B) | 65–75 ns |
| Write | 3 | 65–75 ns | `0x0000_0010` | `SEQ` | `1` | `WRAP4` | `0` (1B) | 75–85 ns |
| Write | 4 | 75–85 ns | `0x0000_0011` | `SEQ` | `1` | `WRAP4` | `0` (1B) | 85–95 ns |
| Read | 1 | 125–135 ns | `0x0000_0012` | `NONSEQ` | `0` | `WRAP4` | `0` (1B) | 135–145 ns |
| Read | 2 | 135–145 ns | `0x0000_0013` | `SEQ` | `0` | `WRAP4` | `0` (1B) | 145–155 ns |
| Read | 3 | 145–155 ns | `0x0000_0010` | `SEQ` | `0` | `WRAP4` | `0` (1B) | 155–165 ns |
| Read | 4 | 155–165 ns | `0x0000_0011` | `SEQ` | `0` | `WRAP4` | `0` (1B) | 165–175 ns |

---

## Address Wrapping Calculation

For this transaction:

```text
HSIZE = 0
Transfer Size = 2^0 = 1 byte

HBURST = WRAP4
Number of Beats = 4

Wrap Boundary = 4 × 1 byte = 4 bytes
