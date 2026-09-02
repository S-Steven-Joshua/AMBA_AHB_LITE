## AHB INCR16 Burst — 2-Byte Write and Read

The following simulation demonstrates an **AHB INCR16 burst** for both **write and read operations** with `HSIZE = 1`.

The burst starts at address `0x0000_0010`. Since `HSIZE = 1`, each transfer is **2 bytes**. With `HBURST = 7`, the transfer is a **16-beat incrementing burst (`INCR16`)**.

### Burst Configuration

- Starting Address: `0x0000_0010`
- `HBURST = 7` (`INCR16`)
- `HSIZE = 1` (2 bytes)
- Number of Beats: 16
- Transfer Size: 2 bytes
- `HWRITE = 1` for write burst
- `HWRITE = 0` for read burst

---

## 1. AHB INCR16 Write Burst

The write burst starts at **45 ns** with the initial address `0x0000_0010`.

### Beat 1

- **45 ns – 55 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = NONSEQ`

- **55 ns – 65 ns:** Data phase
  - Write data (`HWDATA`): First burst data

### Beat 2

- **55 ns – 65 ns:** Address phase
  - Address: `0x0000_0012`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **65 ns – 75 ns:** Data phase
  - Write data (`HWDATA`): Second burst data

### Beat 3

- **65 ns – 75 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **75 ns – 85 ns:** Data phase
  - Write data (`HWDATA`): Third burst data

### Beat 4

- **75 ns – 85 ns:** Address phase
  - Address: `0x0000_0016`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **85 ns – 95 ns:** Data phase
  - Write data (`HWDATA`): Fourth burst data

### Beat 5

- **85 ns – 95 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **95 ns – 105 ns:** Data phase
  - Write data (`HWDATA`): Fifth burst data

### Beat 6

- **95 ns – 105 ns:** Address phase
  - Address: `0x0000_001A`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **105 ns – 115 ns:** Data phase
  - Write data (`HWDATA`): Sixth burst data

### Beat 7

- **105 ns – 115 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **115 ns – 125 ns:** Data phase
  - Write data (`HWDATA`): Seventh burst data

### Beat 8

- **115 ns – 125 ns:** Address phase
  - Address: `0x0000_001E`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **125 ns – 135 ns:** Data phase
  - Write data (`HWDATA`): Eighth burst data

### Beat 9

- **125 ns – 135 ns:** Address phase
  - Address: `0x0000_0020`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **135 ns – 145 ns:** Data phase
  - Write data (`HWDATA`): Ninth burst data

### Beat 10

- **135 ns – 145 ns:** Address phase
  - Address: `0x0000_0022`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **145 ns – 155 ns:** Data phase
  - Write data (`HWDATA`): Tenth burst data

### Beat 11

- **145 ns – 155 ns:** Address phase
  - Address: `0x0000_0024`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **155 ns – 165 ns:** Data phase
  - Write data (`HWDATA`): Eleventh burst data

### Beat 12

- **155 ns – 165 ns:** Address phase
  - Address: `0x0000_0026`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **165 ns – 175 ns:** Data phase
  - Write data (`HWDATA`): Twelfth burst data

### Beat 13

- **165 ns – 175 ns:** Address phase
  - Address: `0x0000_0028`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **175 ns – 185 ns:** Data phase
  - Write data (`HWDATA`): Thirteenth burst data

### Beat 14

- **175 ns – 185 ns:** Address phase
  - Address: `0x0000_002A`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **185 ns – 195 ns:** Data phase
  - Write data (`HWDATA`): Fourteenth burst data

### Beat 15

- **185 ns – 195 ns:** Address phase
  - Address: `0x0000_002C`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **195 ns – 205 ns:** Data phase
  - Write data (`HWDATA`): Fifteenth burst data

### Beat 16

- **195 ns – 205 ns:** Address phase
  - Address: `0x0000_002E`
  - `HWRITE = 1`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **205 ns – 215 ns:** Data phase
  - Write data (`HWDATA`): Sixteenth burst data

---

## 2. AHB INCR16 Read Burst

The read burst starts at **245 ns** with the same starting address `0x0000_0010`.

### Beat 1

- **245 ns – 255 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = NONSEQ`

- **255 ns – 265 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0010`

### Beat 2

- **255 ns – 265 ns:** Address phase
  - Address: `0x0000_0012`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **265 ns – 275 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0012`

### Beat 3

- **265 ns – 275 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **275 ns – 285 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0014`

### Beat 4

- **275 ns – 285 ns:** Address phase
  - Address: `0x0000_0016`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **285 ns – 295 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0016`

### Beat 5

- **285 ns – 295 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **295 ns – 305 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0018`

### Beat 6

- **295 ns – 305 ns:** Address phase
  - Address: `0x0000_001A`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **305 ns – 315 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_001A`

### Beat 7

- **305 ns – 315 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **315 ns – 325 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_001C`

### Beat 8

- **315 ns – 325 ns:** Address phase
  - Address: `0x0000_001E`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **325 ns – 335 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_001E`

### Beat 9

- **325 ns – 335 ns:** Address phase
  - Address: `0x0000_0020`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **335 ns – 345 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0020`

### Beat 10

- **335 ns – 345 ns:** Address phase
  - Address: `0x0000_0022`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **345 ns – 355 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0022`

### Beat 11

- **345 ns – 355 ns:** Address phase
  - Address: `0x0000_0024`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **355 ns – 365 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0024`

### Beat 12

- **355 ns – 365 ns:** Address phase
  - Address: `0x0000_0026`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **365 ns – 375 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0026`

### Beat 13

- **365 ns – 375 ns:** Address phase
  - Address: `0x0000_0028`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **375 ns – 385 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0028`

### Beat 14

- **375 ns – 385 ns:** Address phase
  - Address: `0x0000_002A`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **385 ns – 395 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_002A`

### Beat 15

- **385 ns – 395 ns:** Address phase
  - Address: `0x0000_002C`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **395 ns – 405 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_002C`

### Beat 16

- **395 ns – 405 ns:** Address phase
  - Address: `0x0000_002E`
  - `HWRITE = 0`
  - `HBURST = INCR16`
  - `HSIZE = 1` (2 bytes)
  - `HTRANS = SEQ`

- **405 ns – 415 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_002E`

---

## INCR16 Transaction Summary

| Operation | Beat | Address Phase | Address | `HTRANS` | `HWRITE` | `HBURST` | `HSIZE` | Data Phase |
|-----------|------|---------------|---------|----------|----------|----------|---------|------------|
| Write | 1 | 45–55 ns | `0x0000_0010` | `NONSEQ` | `1` | `INCR16` | `1` (2B) | 55–65 ns |
| Write | 2 | 55–65 ns | `0x0000_0012` | `SEQ` | `1` | `INCR16` | `1` (2B) | 65–75 ns |
| Write | 3 | 65–75 ns | `0x0000_0014` | `SEQ` | `1` | `INCR16` | `1` (2B) | 75–85 ns |
| Write | 4 | 75–85 ns | `0x0000_0016` | `SEQ` | `1` | `INCR16` | `1` (2B) | 85–95 ns |
| Write | 5 | 85–95 ns | `0x0000_0018` | `SEQ` | `1` | `INCR16` | `1` (2B) | 95–105 ns |
| Write | 6 | 95–105 ns | `0x0000_001A` | `SEQ` | `1` | `INCR16` | `1` (2B) | 105–115 ns |
| Write | 7 | 105–115 ns | `0x0000_001C` | `SEQ` | `1` | `INCR16` | `1` (2B) | 115–125 ns |
| Write | 8 | 115–125 ns | `0x0000_001E` | `SEQ` | `1` | `INCR16` | `1` (2B) | 125–135 ns |
| Write | 9 | 125–135 ns | `0x0000_0020` | `SEQ` | `1` | `INCR16` | `1` (2B) | 135–145 ns |
| Write | 10 | 135–145 ns | `0x0000_0022` | `SEQ` | `1` | `INCR16` | `1` (2B) | 145–155 ns |
| Write | 11 | 145–155 ns | `0x0000_0024` | `SEQ` | `1` | `INCR16` | `1` (2B) | 155–165 ns |
| Write | 12 | 155–165 ns | `0x0000_0026` | `SEQ` | `1` | `INCR16` | `1` (2B) | 165–175 ns |
| Write | 13 | 165–175 ns | `0x0000_0028` | `SEQ` | `1` | `INCR16` | `1` (2B) | 175–185 ns |
| Write | 14 | 175–185 ns | `0x0000_002A` | `SEQ` | `1` | `INCR16` | `1` (2B) | 185–195 ns |
| Write | 15 | 185–195 ns | `0x0000_002C` | `SEQ` | `1` | `INCR16` | `1` (2B) | 195–205 ns |
| Write | 16 | 195–205 ns | `0x0000_002E` | `SEQ` | `1` | `INCR16` | `1` (2B) | 205–215 ns |
| Read | 1 | 245–255 ns | `0x00000010` | `NONSEQ` | `0` | `INCR16` | `1` (2B) | 255–265 ns |
| Read | 2 | 255–265 ns | `0x00000012` | `SEQ` | `0` | `INCR16` | `1` (2B) | 265–275 ns |
| Read | 3 | 265–275 ns | `0x00000014` | `SEQ` | `0` | `INCR16` | `1` (2B) | 275–285 ns |
| Read | 4 | 275–285 ns | `0x00000016` | `SEQ` | `0` | `INCR16` | `1` (2B) | 285–295 ns |
| Read | 5 | 285–295 ns | `0x00000018` | `SEQ` | `0` | `INCR16` | `1` (2B) | 295–305 ns |
| Read | 6 | 295–305 ns | `0x0000001A` | `SEQ` | `0` | `INCR16` | `1` (2B) | 305–315 ns |
| Read | 7 | 305–315 ns | `0x0000001C` | `SEQ` | `0` | `INCR16` | `1` (2B) | 315–325 ns |
| Read | 8 | 315–325 ns | `0x0000001E` | `SEQ` | `0` | `INCR16` | `1` (2B) | 325–335 ns |
| Read | 9 | 325–335 ns | `0x00000020` | `SEQ` | `0` | `INCR16` | `1` (2B) | 335–345 ns |
| Read | 10 | 335–345 ns | `0x00000022` | `SEQ` | `0` | `INCR16` | `1` (2B) | 345–355 ns |
| Read | 11 | 345–355 ns | `0x00000024` | `SEQ` | `0` | `INCR16` | `1` (2B) | 355–365 ns |
| Read | 12 | 355–365 ns | `0x00000026` | `SEQ` | `0` | `INCR16` | `1` (2B) | 365–375 ns |
| Read | 13 | 365–375 ns | `0x00000028` | `SEQ` | `0` | `INCR16` | `1` (2B) | 375–385 ns |
| Read | 14 | 375–385 ns | `0x0000002A` | `SEQ` | `0` | `INCR16` | `1` (2B) | 385–395 ns |
| Read | 15 | 385–395 ns | `0x0000002C` | `SEQ` | `0` | `INCR16` | `1` (2B) | 395–405 ns |
| Read | 16 | 395–405 ns | `0x0000002E` | `SEQ` | `0` | `INCR16` | `1` (2B) | 405–415 ns |

---

## Address Calculation

For this transaction:

```text
HSIZE = 1
Transfer Size = 2^1 = 2 bytes

HBURST = INCR16
Number of Beats = 16
```
