<img width="1572" height="810" alt="Image" src="https://github.com/user-attachments/assets/e23bc5fd-9189-41df-8d7a-83418d1d9701" />

## AHB WRAP8 Burst — 2-Byte Write and Read

The following simulation demonstrates an **AHB WRAP8 burst** for both **write and read operations** with `HSIZE = 1`.

The burst starts at address `0x0000_0012`. Since `HSIZE = 1`, each transfer is **2 bytes**. With `HBURST = 4`, the transfer is an **8-beat wrapping burst (`WRAP8`)**.

### Burst Configuration

- Starting Address: `0x0000_0012`
- `HBURST = 4` (`WRAP8`)
- `HSIZE = 1` (2 bytes)
- Number of Beats: 8
- Transfer Size: 2 bytes
- `HWRITE = 1` for write burst
- `HWRITE = 0` for read burst

---

## 1. AHB WRAP8 Write Burst

The write burst starts at **45 ns** with the initial address `0x0000_0012`.

### Beat 1

- **45 ns – 55 ns:** Address phase
  - Address: `0x0000_0012`
  - `HWRITE = 1`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = NONSEQ`

- **55 ns – 65 ns:** Data phase
  - Write data (`HWDATA`): First burst data

### Beat 2

- **55 ns – 65 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 1`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **65 ns – 75 ns:** Data phase
  - Write data (`HWDATA`): Second burst data

### Beat 3

- **65 ns – 75 ns:** Address phase
  - Address: `0x0000_0016`
  - `HWRITE = 1`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **75 ns – 85 ns:** Data phase
  - Write data (`HWDATA`): Third burst data

### Beat 4

- **75 ns – 85 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 1`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **85 ns – 95 ns:** Data phase
  - Write data (`HWDATA`): Fourth burst data

### Beat 5

- **85 ns – 95 ns:** Address phase
  - Address: `0x0000_001A`
  - `HWRITE = 1`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **95 ns – 105 ns:** Data phase
  - Write data (`HWDATA`): Fifth burst data

### Beat 6

- **95 ns – 105 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 1`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **105 ns – 115 ns:** Data phase
  - Write data (`HWDATA`): Sixth burst data

### Beat 7

- **105 ns – 115 ns:** Address phase
  - Address: `0x0000_001E`
  - `HWRITE = 1`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **115 ns – 125 ns:** Data phase
  - Write data (`HWDATA`): Seventh burst data

### Beat 8

- **115 ns – 125 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 1`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **125 ns – 135 ns:** Data phase
  - Write data (`HWDATA`): Eighth burst data

---

## 2. AHB WRAP8 Read Burst

The read burst starts at **165 ns** with the same starting address `0x0000_0012`.

### Beat 1

- **165 ns – 175 ns:** Address phase
  - Address: `0x0000_0012`
  - `HWRITE = 0`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = NONSEQ`

- **175 ns – 185 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0012`

### Beat 2

- **175 ns – 185 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 0`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **185 ns – 195 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0014`

### Beat 3

- **185 ns – 195 ns:** Address phase
  - Address: `0x0000_0016`
  - `HWRITE = 0`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **195 ns – 205 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0016`

### Beat 4

- **195 ns – 205 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 0`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **205 ns – 215 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0018`

### Beat 5

- **205 ns – 215 ns:** Address phase
  - Address: `0x0000_001A`
  - `HWRITE = 0`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **215 ns – 225 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_001A`

### Beat 6

- **215 ns – 225 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 0`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **225 ns – 235 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_001C`

### Beat 7

- **225 ns – 235 ns:** Address phase
  - Address: `0x0000_001E`
  - `HWRITE = 0`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **235 ns – 245 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_001E`

### Beat 8

- **235 ns – 245 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 0`
  - `HBURST = WRAP8`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **245 ns – 255 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0010`

---

## WRAP8 Transaction Summary

| Operation | Beat | Address Phase | Address | `HTRANS` | `HWRITE` | `HBURST` | `HSIZE` | Data Phase |
|-----------|------|---------------|---------|----------|----------|----------|---------|------------|
| Write | 1 | 45–55 ns | `0x0000_0012` | `NONSEQ` | `1` | `WRAP8` | `1` (2B) | 55–65 ns |
| Write | 2 | 55–65 ns | `0x0000_0014` | `SEQ` | `1` | `WRAP8` | `1` (2B) | 65–75 ns |
| Write | 3 | 65–75 ns | `0x0000_0016` | `SEQ` | `1` | `WRAP8` | `1` (2B) | 75–85 ns |
| Write | 4 | 75–85 ns | `0x0000_0018` | `SEQ` | `1` | `WRAP8` | `1` (2B) | 85–95 ns |
| Write | 5 | 85–95 ns | `0x0000_001A` | `SEQ` | `1` | `WRAP8` | `1` (2B) | 95–105 ns |
| Write | 6 | 95–105 ns | `0x0000_001C` | `SEQ` | `1` | `WRAP8` | `1` (2B) | 105–115 ns |
| Write | 7 | 105–115 ns | `0x0000_001E` | `SEQ` | `1` | `WRAP8` | `1` (2B) | 115–125 ns |
| Write | 8 | 115–125 ns | `0x0000_0010` | `SEQ` | `1` | `WRAP8` | `1` (2B) | 125–135 ns |
| Read | 1 | 165–175 ns | `0x0000_0012` | `NONSEQ` | `0` | `WRAP8` | `1` (2B) | 175–185 ns |
| Read | 2 | 175–185 ns | `0x0000_0014` | `SEQ` | `0` | `WRAP8` | `1` (2B) | 185–195 ns |
| Read | 3 | 185–195 ns | `0x0000_0016` | `SEQ` | `0` | `WRAP8` | `1` (2B) | 195–205 ns |
| Read | 4 | 195–205 ns | `0x0000_0018` | `SEQ` | `0` | `WRAP8` | `1` (2B) | 205–215 ns |
| Read | 5 | 205–215 ns | `0x0000_001A` | `SEQ` | `0` | `WRAP8` | `1` (2B) | 215–225 ns |
| Read | 6 | 215–225 ns | `0x0000_001C` | `SEQ` | `0` | `WRAP8` | `1` (2B) | 225–235 ns |
| Read | 7 | 225–235 ns | `0x0000_001E` | `SEQ` | `0` | `WRAP8` | `1` (2B) | 235–245 ns |
| Read | 8 | 235–245 ns | `0x0000_0010` | `SEQ` | `0` | `WRAP8` | `1` (2B) | 245–255 ns |

---

## Address Wrapping Calculation

For this transaction:

```text
HSIZE = 1
Transfer Size = 2^1 = 2 bytes

HBURST = WRAP8
Number of Beats = 8

Wrap Boundary = 8 × 2 bytes
              = 16 bytes
