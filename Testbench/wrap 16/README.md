<img width="1576" height="806" alt="Image" src="https://github.com/user-attachments/assets/bffc2bca-c604-49e1-b45e-fd52d6f10c16" />

## AHB WRAP16 Burst — 1-Byte Write and Read

The following simulation demonstrates an **AHB WRAP16 burst** for both **write and read operations** with `HSIZE = 0`.

The burst starts at address `0x0000_0018`. Since `HSIZE = 0`, each transfer is **1 byte**. With `HBURST = 6`, the transfer is a **16-beat wrapping burst (`WRAP16`)**.

### Burst Configuration

- Starting Address: `0x0000_0018`
- `HBURST = 6` (`WRAP16`)
- `HSIZE = 0` (1 byte)
- Number of Beats: 16
- Transfer Size: 1 byte
- `HWRITE = 1` for write burst
- `HWRITE = 0` for read burst

---

## 1. AHB WRAP16 Write Burst

The write burst starts at **45 ns** with the initial address `0x0000_0018`.

### Beat 1

- **45 ns – 55 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 1`
  - `HBURST = WRAP16`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = NONSEQ`

- **55 ns – 65 ns:** Data phase
  - Write data: First burst data

### Beat 2

- **55 ns – 65 ns:** Address phase
  - Address: `0x0000_0019`
  - `HWRITE = 1`
  - `HBURST = WRAP16`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = SEQ`

- **65 ns – 75 ns:** Data phase
  - Write data: Second burst data

### Beat 3

- **65 ns – 75 ns:** Address phase
  - Address: `0x0000_001A`
  - `HTRANS = SEQ`

- **75 ns – 85 ns:** Data phase
  - Write data: Third burst data

### Beat 4

- **75 ns – 85 ns:** Address phase
  - Address: `0x0000_001B`
  - `HTRANS = SEQ`

- **85 ns – 95 ns:** Data phase
  - Write data: Fourth burst data

### Beat 5

- **85 ns – 95 ns:** Address phase
  - Address: `0x0000_001C`
  - `HTRANS = SEQ`

- **95 ns – 105 ns:** Data phase
  - Write data: Fifth burst data

### Beat 6

- **95 ns – 105 ns:** Address phase
  - Address: `0x0000_001D`
  - `HTRANS = SEQ`

- **105 ns – 115 ns:** Data phase
  - Write data: Sixth burst data

### Beat 7

- **105 ns – 115 ns:** Address phase
  - Address: `0x0000_001E`
  - `HTRANS = SEQ`

- **115 ns – 125 ns:** Data phase
  - Write data: Seventh burst data

### Beat 8

- **115 ns – 125 ns:** Address phase
  - Address: `0x0000_001F`
  - `HTRANS = SEQ`

- **125 ns – 135 ns:** Data phase
  - Write data: Eighth burst data

### Beat 9 — Address Wrap

- **125 ns – 135 ns:** Address phase
  - Address: `0x0000_0010`
  - `HTRANS = SEQ`

- **135 ns – 145 ns:** Data phase
  - Write data: Ninth burst data

### Beat 10

- **135 ns – 145 ns:** Address phase
  - Address: `0x0000_0011`
  - `HTRANS = SEQ`

- **145 ns – 155 ns:** Data phase
  - Write data: Tenth burst data

### Beat 11

- **145 ns – 155 ns:** Address phase
  - Address: `0x0000_0012`
  - `HTRANS = SEQ`

- **155 ns – 165 ns:** Data phase
  - Write data: Eleventh burst data

### Beat 12

- **155 ns – 165 ns:** Address phase
  - Address: `0x0000_0013`
  - `HTRANS = SEQ`

- **165 ns – 175 ns:** Data phase
  - Write data: Twelfth burst data

### Beat 13

- **165 ns – 175 ns:** Address phase
  - Address: `0x0000_0014`
  - `HTRANS = SEQ`

- **175 ns – 185 ns:** Data phase
  - Write data: Thirteenth burst data

### Beat 14

- **175 ns – 185 ns:** Address phase
  - Address: `0x0000_0015`
  - `HTRANS = SEQ`

- **185 ns – 195 ns:** Data phase
  - Write data: Fourteenth burst data

### Beat 15

- **185 ns – 195 ns:** Address phase
  - Address: `0x0000_0016`
  - `HTRANS = SEQ`

- **195 ns – 205 ns:** Data phase
  - Write data: Fifteenth burst data

### Beat 16

- **195 ns – 205 ns:** Address phase
  - Address: `0x0000_0017`
  - `HTRANS = SEQ`

- **205 ns – 215 ns:** Data phase
  - Write data: Sixteenth burst data

---

## 2. AHB WRAP16 Read Burst

The read burst starts at **245 ns** with the same starting address `0x0000_0018`.

### Beat 1

- **245 ns – 255 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 0`
  - `HBURST = WRAP16`
  - `HSIZE = 0` (1 byte)
  - `HTRANS = NONSEQ`

- **255 ns – 265 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0018`

### Beat 2

- **255 ns – 265 ns:** Address phase
  - Address: `0x0000_0019`
  - `HTRANS = SEQ`

- **265 ns – 275 ns:** Data phase
  - Read data: Data stored at `0x0000_0019`

### Beat 3

- **265 ns – 275 ns:** Address phase
  - Address: `0x0000_001A`
  - `HTRANS = SEQ`

- **275 ns – 285 ns:** Data phase
  - Read data: Data stored at `0x0000_001A`

### Beat 4

- **275 ns – 285 ns:** Address phase
  - Address: `0x0000_001B`
  - `HTRANS = SEQ`

- **285 ns – 295 ns:** Data phase
  - Read data: Data stored at `0x0000_001B`

### Beat 5

- **285 ns – 295 ns:** Address phase
  - Address: `0x0000_001C`
  - `HTRANS = SEQ`

- **295 ns – 305 ns:** Data phase
  - Read data: Data stored at `0x0000_001C`

### Beat 6

- **295 ns – 305 ns:** Address phase
  - Address: `0x0000_001D`
  - `HTRANS = SEQ`

- **305 ns – 315 ns:** Data phase
  - Read data: Data stored at `0x0000_001D`

### Beat 7

- **305 ns – 315 ns:** Address phase
  - Address: `0x0000_001E`
  - `HTRANS = SEQ`

- **315 ns – 325 ns:** Data phase
  - Read data: Data stored at `0x0000_001E`

### Beat 8

- **315 ns – 325 ns:** Address phase
  - Address: `0x0000_001F`
  - `HTRANS = SEQ`

- **325 ns – 335 ns:** Data phase
  - Read data: Data stored at `0x0000_001F`

### Beat 9 — Address Wrap

- **325 ns – 335 ns:** Address phase
  - Address: `0x0000_0010`
  - `HTRANS = SEQ`

- **335 ns – 345 ns:** Data phase
  - Read data: Data stored at `0x0000_0010`

### Beat 10

- **335 ns – 345 ns:** Address phase
  - Address: `0x0000_0011`
  - `HTRANS = SEQ`

- **345 ns – 355 ns:** Data phase
  - Read data: Data stored at `0x0000_0011`

### Beat 11

- **345 ns – 355 ns:** Address phase
  - Address: `0x0000_0012`
  - `HTRANS = SEQ`

- **355 ns – 365 ns:** Data phase
  - Read data: Data stored at `0x0000_0012`

### Beat 12

- **355 ns – 365 ns:** Address phase
  - Address: `0x0000_0013`
  - `HTRANS = SEQ`

- **365 ns – 375 ns:** Data phase
  - Read data: Data stored at `0x0000_0013`

### Beat 13

- **365 ns – 375 ns:** Address phase
  - Address: `0x0000_0014`
  - `HTRANS = SEQ`

- **375 ns – 385 ns:** Data phase
  - Read data: Data stored at `0x0000_0014`

### Beat 14

- **375 ns – 385 ns:** Address phase
  - Address: `0x0000_0015`
  - `HTRANS = SEQ`

- **385 ns – 395 ns:** Data phase
  - Read data: Data stored at `0x0000_0015`

### Beat 15

- **385 ns – 395 ns:** Address phase
  - Address: `0x0000_0016`
  - `HTRANS = SEQ`

- **395 ns – 405 ns:** Data phase
  - Read data: Data stored at `0x0000_0016`

### Beat 16

- **395 ns – 405 ns:** Address phase
  - Address: `0x0000_0017`
  - `HTRANS = SEQ`

- **405 ns – 415 ns:** Data phase
  - Read data: Data stored at `0x0000_0017`

---

## WRAP16 Transaction Summary

| Operation | Beat | Address Phase | Address | `HTRANS` | `HWRITE` | `HBURST` | `HSIZE` | Data Phase |
|-----------|------|---------------|---------|----------|----------|----------|---------|------------|
| Write | 1 | 45–55 ns | `0x18` | `NONSEQ` | 1 | WRAP16 | 0 (1B) | 55–65 ns |
| Write | 2 | 55–65 ns | `0x19` | `SEQ` | 1 | WRAP16 | 0 (1B) | 65–75 ns |
| Write | 3 | 65–75 ns | `0x1A` | `SEQ` | 1 | WRAP16 | 0 (1B) | 75–85 ns |
| Write | 4 | 75–85 ns | `0x1B` | `SEQ` | 1 | WRAP16 | 0 (1B) | 85–95 ns |
| Write | 5 | 85–95 ns | `0x1C` | `SEQ` | 1 | WRAP16 | 0 (1B) | 95–105 ns |
| Write | 6 | 95–105 ns | `0x1D` | `SEQ` | 1 | WRAP16 | 0 (1B) | 105–115 ns |
| Write | 7 | 105–115 ns | `0x1E` | `SEQ` | 1 | WRAP16 | 0 (1B) | 115–125 ns |
| Write | 8 | 115–125 ns | `0x1F` | `SEQ` | 1 | WRAP16 | 0 (1B) | 125–135 ns |
| Write | 9 | 125–135 ns | `0x10` | `SEQ` | 1 | WRAP16 | 0 (1B) | 135–145 ns |
| Write | 10 | 135–145 ns | `0x11` | `SEQ` | 1 | WRAP16 | 0 (1B) | 145–155 ns |
| Write | 11 | 145–155 ns | `0x12` | `SEQ` | 1 | WRAP16 | 0 (1B) | 155–165 ns |
| Write | 12 | 155–165 ns | `0x13` | `SEQ` | 1 | WRAP16 | 0 (1B) | 165–175 ns |
| Write | 13 | 165–175 ns | `0x14` | `SEQ` | 1 | WRAP16 | 0 (1B) | 175–185 ns |
| Write | 14 | 175–185 ns | `0x15` | `SEQ` | 1 | WRAP16 | 0 (1B) | 185–195 ns |
| Write | 15 | 185–195 ns | `0x16` | `SEQ` | 1 | WRAP16 | 0 (1B) | 195–205 ns |
| Write | 16 | 195–205 ns | `0x17` | `SEQ` | 1 | WRAP16 | 0 (1B) | 205–215 ns |
| Read | 1 | 245–255 ns | `0x18` | `NONSEQ` | 0 | WRAP16 | 0 (1B) | 255–265 ns |
| Read | 2 | 255–265 ns | `0x19` | `SEQ` | 0 | WRAP16 | 0 (1B) | 265–275 ns |
| Read | 3 | 265–275 ns | `0x1A` | `SEQ` | 0 | WRAP16 | 0 (1B) | 275–285 ns |
| Read | 4 | 275–285 ns | `0x1B` | `SEQ` | 0 | WRAP16 | 0 (1B) | 285–295 ns |
| Read | 5 | 285–295 ns | `0x1C` | `SEQ` | 0 | WRAP16 | 0 (1B) | 295–305 ns |
| Read | 6 | 295–305 ns | `0x1D` | `SEQ` | 0 | WRAP16 | 0 (1B) | 305–315 ns |
| Read | 7 | 305–315 ns | `0x1E` | `SEQ` | 0 | WRAP16 | 0 (1B) | 315–325 ns |
| Read | 8 | 315–325 ns | `0x1F` | `SEQ` | 0 | WRAP16 | 0 (1B) | 325–335 ns |
| Read | 9 | 325–335 ns | `0x10` | `SEQ` | 0 | WRAP16 | 0 (1B) | 335–345 ns |
| Read | 10 | 335–345 ns | `0x11` | `SEQ` | 0 | WRAP16 | 0 (1B) | 345–355 ns |
| Read | 11 | 345–355 ns | `0x12` | `SEQ` | 0 | WRAP16 | 0 (1B) | 355–365 ns |
| Read | 12 | 355–365 ns | `0x13` | `SEQ` | 0 | WRAP16 | 0 (1B) | 365–375 ns |
| Read | 13 | 365–375 ns | `0x14` | `SEQ` | 0 | WRAP16 | 0 (1B) | 375–385 ns |
| Read | 14 | 375–385 ns | `0x15` | `SEQ` | 0 | WRAP16 | 0 (1B) | 385–395 ns |
| Read | 15 | 385–395 ns | `0x16` | `SEQ` | 0 | WRAP16 | 0 (1B) | 395–405 ns |
| Read | 16 | 395–405 ns | `0x17` | `SEQ` | 0 | WRAP16 | 0 (1B) | 405–415 ns |

---

## Address Wrapping Calculation

For this transaction:

```text
HSIZE = 0
Transfer Size = 2^0 = 1 byte

HBURST = WRAP16
Number of Beats = 16

Wrap Boundary = 16 × 1 byte
              = 16 bytes
