<img width="1572" height="803" alt="Image" src="https://github.com/user-attachments/assets/78de44fa-6f85-4c63-ad8e-fb44361f5064" />

## AHB Undefined-Length INCR Burst — Write and Read

The following simulation demonstrates an **AHB undefined-length incrementing burst (`INCR`)** for both **write and read operations**.

The burst starts at address `0x0000_0010` with:

- `HBURST = 1` (`INCR`)
- `HSIZE = 2` → 4-byte transfer
- Burst length = 5 beats
- Address increment = 4 bytes

The AHB master calculates the address for each subsequent beat based on the transfer size.

---

## 1. AHB INCR Write Burst

The write burst starts at **45 ns** with the initial address `0x0000_0010`.

Since `HSIZE = 2`, each transfer is 4 bytes and the address increments by 4 bytes for every subsequent beat.

### Beat 1

- **45 ns – 55 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = NONSEQ`

- **55 ns – 65 ns:** Data phase
  - Write data (`HWDATA`): First burst data

### Beat 2

- **55 ns – 65 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **65 ns – 75 ns:** Data phase
  - Write data (`HWDATA`): Second burst data

### Beat 3

- **65 ns – 75 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **75 ns – 85 ns:** Data phase
  - Write data (`HWDATA`): Third burst data

### Beat 4

- **75 ns – 85 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **85 ns – 95 ns:** Data phase
  - Write data (`HWDATA`): Fourth burst data

### Beat 5

- **85 ns – 95 ns:** Address phase
  - Address: `0x0000_0020`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **95 ns – 105 ns:** Data phase
  - Write data (`HWDATA`): `0x5555_5555`

---

## 2. AHB INCR Read Burst

After the write burst, the master initiates a **read INCR burst** starting again from address `0x0000_0010`.

The read burst also consists of **5 beats**, with each transfer being 4 bytes.

### Beat 1

- **145 ns – 155 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 0`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = NONSEQ`

- **155 ns – 165 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0010`

### Beat 2

- **155 ns – 165 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 0`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **165 ns – 175 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0014`

### Beat 3

- **165 ns – 175 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 0`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **175 ns – 185 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0018`

### Beat 4

- **175 ns – 185 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 0`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **185 ns – 195 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_001C`

### Beat 5

- **185 ns – 195 ns:** Address phase
  - Address: `0x0000_0020`
  - `HWRITE = 0`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **195 ns – 205 ns:** Data phase
  - Read data (`HRDATA`): Data stored at `0x0000_0020`

---

## Burst Transaction Summary

| Operation | Beat | Address Phase | Address | `HTRANS` | `HWRITE` | `HBURST` | `HSIZE` | Data Phase |
|-----------|------|---------------|---------|----------|----------|----------|---------|------------|
| Write | 1 | 45–55 ns | `0x0000_0010` | `NONSEQ` | `1` | `INCR` | `2` (4B) | 55–65 ns |
| Write | 2 | 55–65 ns | `0x0000_0014` | `SEQ` | `1` | `INCR` | `2` (4B) | 65–75 ns |
| Write | 3 | 65–75 ns | `0x0000_0018` | `SEQ` | `1` | `INCR` | `2` (4B) | 75–85 ns |
| Write | 4 | 75–85 ns | `0x0000_001C` | `SEQ` | `1` | `INCR` | `2` (4B) | 85–95 ns |
| Write | 5 | 85–95 ns | `0x0000_0020` | `SEQ` | `1` | `INCR` | `2` (4B) | 95–105 ns |
| Read | 1 | 145–155 ns | `0x0000_0010` | `NONSEQ` | `0` | `INCR` | `2` (4B) | 155–165 ns |
| Read | 2 | 155–165 ns | `0x0000_0014` | `SEQ` | `0` | `INCR` | `2` (4B) | 165–175 ns |
| Read | 3 | 165–175 ns | `0x0000_0018` | `SEQ` | `0` | `INCR` | `2` (4B) | 175–185 ns |
| Read | 4 | 175–185 ns | `0x0000_001C` | `SEQ` | `0` | `INCR` | `2` (4B) | 185–195 ns |
| Read | 5 | 185–195 ns | `0x0000_0020` | `SEQ` | `0` | `INCR` | `2` (4B) | 195–205 ns |

---

## Address Calculation

For both the write and read bursts:

```text
HSIZE = 2
Transfer Size = 2^2 = 4 bytes
