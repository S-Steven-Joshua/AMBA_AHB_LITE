<img width="1578" height="816" alt="Image" src="https://github.com/user-attachments/assets/2aafe70b-aae1-4e9d-90cb-33b34ee8b787" />

## AHB INCR8 Burst — 4-Byte Write and Read

The following simulation demonstrates an **AHB INCR8 burst** for both **write and read operations** with `HSIZE = 2`.

The burst starts at address `0x0000_0020`. Since `HSIZE = 2`, each transfer is **4 bytes**. With `HBURST = 5`, the transfer is an **8-beat incrementing burst (`INCR8`)**.

### Burst Configuration

- Starting Address: `0x0000_0020`
- `HBURST = 5` (`INCR8`)
- `HSIZE = 2` (4 bytes)
- Number of Beats: 8
- Transfer Size: 4 bytes
- `HWRITE = 1` for write burst
- `HWRITE = 0` for read burst

---

## 1. AHB INCR8 Write Burst

The write burst starts at **45 ns** with the initial address `0x0000_0020`.

### Beat 1

- **45 ns – 55 ns:** Address phase
  - Address: `0x0000_0020`
  - `HWRITE = 1`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = NONSEQ`

- **55 ns – 65 ns:** Data phase
  - Write data (`HWDATA`): First burst data

### Beat 2

- **55 ns – 65 ns:** Address phase
  - Address: `0x0000_0024`
  - `HWRITE = 1`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **65 ns – 75 ns:** Data phase
  - Write data (`HWDATA`): Second burst data

### Beat 3

- **65 ns – 75 ns:** Address phase
  - Address: `0x0000_0028`
  - `HWRITE = 1`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **75 ns – 85 ns:** Data phase
  - Write data (`HWDATA`): Third burst data

### Beat 4

- **75 ns – 85 ns:** Address phase
  - Address: `0x0000_002C`
  - `HWRITE = 1`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **85 ns – 95 ns:** Data phase
  - Write data (`HWDATA`): Fourth burst data

### Beat 5

- **85 ns – 95 ns:** Address phase
  - Address: `0x0000_0030`
  - `HWRITE = 1`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **95 ns – 105 ns:** Data phase
  - Write data (`HWDATA`): Fifth burst data

### Beat 6

- **95 ns – 105 ns:** Address phase
  - Address: `0x0000_0034`
  - `HWRITE = 1`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **105 ns – 115 ns:** Data phase
  - Write data (`HWDATA`): Sixth burst data

### Beat 7

- **105 ns – 115 ns:** Address phase
  - Address: `0x0000_0038`
  - `HWRITE = 1`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **115 ns – 125 ns:** Data phase
  - Write data (`HWDATA`): Seventh burst data

### Beat 8

- **115 ns – 125 ns:** Address phase
  - Address: `0x0000_003C`
  - `HWRITE = 1`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **125 ns – 135 ns:** Data phase
  - Write data (`HWDATA`): Eighth burst data

---

## 2. AHB INCR8 Read Burst

The read burst starts at **165 ns** with the same starting address `0x0000_0020`.

### Beat 1

- **165 ns – 175 ns:** Address phase
  - Address: `0x0000_0020`
  - `HWRITE = 0`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = NONSEQ`

- **175 ns – 185 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0020`

### Beat 2

- **175 ns – 185 ns:** Address phase
  - Address: `0x0000_0024`
  - `HWRITE = 0`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **185 ns – 195 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0024`

### Beat 3

- **185 ns – 195 ns:** Address phase
  - Address: `0x0000_0028`
  - `HWRITE = 0`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **195 ns – 205 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0028`

### Beat 4

- **195 ns – 205 ns:** Address phase
  - Address: `0x0000_002C`
  - `HWRITE = 0`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **205 ns – 215 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_002C`

### Beat 5

- **205 ns – 215 ns:** Address phase
  - Address: `0x0000_0030`
  - `HWRITE = 0`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **215 ns – 225 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0030`

### Beat 6

- **215 ns – 225 ns:** Address phase
  - Address: `0x0000_0034`
  - `HWRITE = 0`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **225 ns – 235 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0034`

### Beat 7

- **225 ns – 235 ns:** Address phase
  - Address: `0x0000_0038`
  - `HWRITE = 0`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **235 ns – 245 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0038`

### Beat 8

- **235 ns – 245 ns:** Address phase
  - Address: `0x0000_003C`
  - `HWRITE = 0`
  - `HBURST = INCR8`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **245 ns – 255 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_003C`

---

## INCR8 Transaction Summary

| Operation | Beat | Address Phase | Address | `HTRANS` | `HWRITE` | `HBURST` | `HSIZE` | Data Phase |
|-----------|------|---------------|---------|----------|----------|----------|---------|------------|
| Write | 1 | 45–55 ns | `0x0000_0020` | `NONSEQ` | `1` | `INCR8` | `2` (4B) | 55–65 ns |
| Write | 2 | 55–65 ns | `0x0000_0024` | `SEQ` | `1` | `INCR8` | `2` (4B) | 65–75 ns |
| Write | 3 | 65–75 ns | `0x0000_0028` | `SEQ` | `1` | `INCR8` | `2` (4B) | 75–85 ns |
| Write | 4 | 75–85 ns | `0x0000_002C` | `SEQ` | `1` | `INCR8` | `2` (4B) | 85–95 ns |
| Write | 5 | 85–95 ns | `0x0000_0030` | `SEQ` | `1` | `INCR8` | `2` (4B) | 95–105 ns |
| Write | 6 | 95–105 ns | `0x0000_0034` | `SEQ` | `1` | `INCR8` | `2` (4B) | 105–115 ns |
| Write | 7 | 105–115 ns | `0x0000_0038` | `SEQ` | `1` | `INCR8` | `2` (4B) | 115–125 ns |
| Write | 8 | 115–125 ns | `0x0000_003C` | `SEQ` | `1` | `INCR8` | `2` (4B) | 125–135 ns |
| Read | 1 | 165–175 ns | `0x0000_0020` | `NONSEQ` | `0` | `INCR8` | `2` (4B) | 175–185 ns |
| Read | 2 | 175–185 ns | `0x0000_0024` | `SEQ` | `0` | `INCR8` | `2` (4B) | 185–195 ns |
| Read | 3 | 185–195 ns | `0x0000_0028` | `SEQ` | `0` | `INCR8` | `2` (4B) | 195–205 ns |
| Read | 4 | 195–205 ns | `0x0000_002C` | `SEQ` | `0` | `INCR8` | `2` (4B) | 205–215 ns |
| Read | 5 | 205–215 ns | `0x0000_0030` | `SEQ` | `0` | `INCR8` | `2` (4B) | 215–225 ns |
| Read | 6 | 215–225 ns | `0x0000_0034` | `SEQ` | `0` | `INCR8` | `2` (4B) | 225–235 ns |
| Read | 7 | 225–235 ns | `0x0000_0038` | `SEQ` | `0` | `INCR8` | `2` (4B) | 235–245 ns |
| Read | 8 | 235–245 ns | `0x0000_003C` | `SEQ` | `0` | `INCR8` | `2` (4B) | 245–255 ns |

---

## Address Calculation

For this transaction:

```text
HSIZE = 2
Transfer Size = 2^2 = 4 bytes

HBURST = INCR8
Number of Beats = 8
