<img width="1573" height="807" alt="Image" src="https://github.com/user-attachments/assets/15274787-160f-4ded-8622-e29072b34c69" />

## AHB Read/Write Transaction Timing

The following transactions demonstrate **AHB write and read operations** for different transfer sizes: 1 byte, 2 bytes, and 4 bytes.

### 1. 1-Byte Write Transaction

* **45 ns – 55 ns:** Address phase

  * Address: `0x0000_0010`
  * `HWRITE = 1`
  * `HBURST = 0`
  * `HSIZE = 0` (1 byte)

* **55 ns – 65 ns:** Data phase

  * Write data (`HWDATA`): `0x0000_00AB`

### 2. 1-Byte Read Transaction

* **85 ns – 95 ns:** Address phase

  * Address: `0x0000_0010`
  * `HWRITE = 0`
  * `HBURST = 0`
  * `HSIZE = 0` (1 byte)

* **95 ns – 105 ns:** Data phase

  * Read data (`HRDATA`): `0x0000_00AB`

---

### 3. 2-Byte Write Transaction

* **125 ns – 135 ns:** Address phase

  * Address: `0x0000_0012`
  * `HWRITE = 1`
  * `HBURST = 0`
  * `HSIZE = 1` (2 bytes)

* **135 ns – 145 ns:** Data phase

  * Write data (`HWDATA`): `0x0000_ABCD`

### 4. 2-Byte Read Transaction

* **165 ns – 175 ns:** Address phase

  * Address: `0x0000_0012`
  * `HWRITE = 0`
  * `HBURST = 0`
  * `HSIZE = 1` (2 bytes)

* **175 ns – 185 ns:** Data phase

  * Read data (`HRDATA`): `0x0000_ABCD`

---

### 5. 4-Byte Write Transaction

* **205 ns – 215 ns:** Address phase

  * Address: `0x0000_0014`
  * `HWRITE = 1`
  * `HBURST = 0`
  * `HSIZE = 2` (4 bytes)

* **215 ns – 225 ns:** Data phase

  * Write data (`HWDATA`): `0xDEAD_BEEF`

### 6. 4-Byte Read Transaction

* **245 ns – 255 ns:** Address phase

  * Address: `0x0000_0014`
  * `HWRITE = 0`
  * `HBURST = 0`
  * `HSIZE = 2` (4 bytes)

* **255 ns – 265 ns:** Data phase

  * Read data (`HRDATA`): `0xDEAD_BEEF`

---

### Transaction Summary

| Transfer | Address       | Operation | `HSIZE` | Write Data    | Read Data     |
| -------- | ------------- | --------- | ------- | ------------- | ------------- |
| 1 Byte   | `0x0000_0010` | Write     | `0`     | `0x0000_00AB` | —             |
| 1 Byte   | `0x0000_0010` | Read      | `0`     | —             | `0x0000_00AB` |
| 2 Bytes  | `0x0000_0012` | Write     | `1`     | `0x0000_ABCD` | —             |
| 2 Bytes  | `0x0000_0012` | Read      | `1`     | —             | `0x0000_ABCD` |
| 4 Bytes  | `0x0000_0014` | Write     | `2`     | `0xDEAD_BEEF` | —             |
| 4 Bytes  | `0x0000_0014` | Read      | `2`     | —             | `0xDEAD_BEEF` |

> **Note:** Each AHB transfer consists of an **address phase** followed by a **data phase**. The examples above verify read-after-write behavior for 1-byte, 2-byte, and 4-byte transfers.

