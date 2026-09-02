<img width="1580" height="802" alt="Image" src="https://github.com/user-attachments/assets/a0ea16ee-5873-4bd4-a07a-21a3d696d9f8" />

## AHB Undefined-Length INCR Burst

The following simulation demonstrates an **AHB undefined-length incrementing burst (`INCR`)** consisting of **5 beats**.

The burst starts at address `0x0000_0010` with `HSIZE = 2`, corresponding to a **4-byte transfer**. The AHB master calculates the address for each subsequent beat by incrementing the previous address by 4 bytes.

### Burst Configuration

- Starting Address: `0x0000_0010`
- `HWRITE = 1`
- `HBURST = 1` (`INCR`)
- `HSIZE = 2` (4 bytes)
- Number of Beats: 5

---

### 1. Beat 1

- **45 ns – 55 ns:** Address phase
  - Address: `0x0000_0010`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = NONSEQ`

- **55 ns – 65 ns:** Data phase
  - Write data (`HWDATA`): `0x1111_1111`

---

### 2. Beat 2

- **55 ns – 65 ns:** Address phase
  - Address: `0x0000_0014`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **65 ns – 75 ns:** Data phase
  - Write data (`HWDATA`): `0x2222_2222`

---

### 3. Beat 3

- **65 ns – 75 ns:** Address phase
  - Address: `0x0000_0018`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **75 ns – 85 ns:** Data phase
  - Write data (`HWDATA`): `0x3333_3333`

---

### 4. Beat 4

- **75 ns – 85 ns:** Address phase
  - Address: `0x0000_001C`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **85 ns – 95 ns:** Data phase
  - Write data (`HWDATA`): `0x4444_4444`

---

### 5. Beat 5

- **85 ns – 95 ns:** Address phase
  - Address: `0x0000_0020`
  - `HWRITE = 1`
  - `HBURST = INCR`
  - `HSIZE = 2` (4 bytes)
  - `HTRANS = SEQ`

- **95 ns – 105 ns:** Data phase
  - Write data (`HWDATA`): `0x5555_5555`

---

### Burst Transaction Summary

| Beat | Address Phase | Address | `HTRANS` | `HWRITE` | `HBURST` | `HSIZE` | Data Phase | `HWDATA` |
|------|---------------|---------|----------|----------|----------|---------|------------|----------|
| 1 | 45–55 ns | `0x0000_0010` | `NONSEQ` | `1` | `INCR` | `2` (4B) | 55–65 ns | `0x1111_1111` |
| 2 | 55–65 ns | `0x0000_0014` | `SEQ` | `1` | `INCR` | `2` (4B) | 65–75 ns | `0x2222_2222` |
| 3 | 65–75 ns | `0x0000_0018` | `SEQ` | `1` | `INCR` | `2` (4B) | 75–85 ns | `0x3333_3333` |
| 4 | 75–85 ns | `0x0000_001C` | `SEQ` | `1` | `INCR` | `2` (4B) | 85–95 ns | `0x4444_4444` |
| 5 | 85–95 ns | `0x0000_0020` | `SEQ` | `1` | `INCR` | `2` (4B) | 95–105 ns | `0x5555_5555` |

---

### Address Calculation

Since `HSIZE = 2`:

```text
Transfer Size = 2^2 = 4 bytes
