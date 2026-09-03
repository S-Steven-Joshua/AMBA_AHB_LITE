# AHB-Lite HREADY and HRESP — Address Out-of-Range ERROR Verification

## 1. Objective

This simulation verifies the **AHB-Lite `HREADY` and `HRESP` error-response mechanism** when the master accesses an address outside the valid memory range.

The valid memory address range is:

```text
0000_0000 to 0000_03FF
```

The waveform shows an access to:

```text
HADDR = 0000_0400
```

Since:

```text
0000_0400 > 0000_03FF
```

the address is out of range. The purpose of this test is to verify that the slave detects this invalid access and generates the appropriate **AHB-Lite ERROR response** using `HRESP` and `HREADY`.

---

## 2. Address Range Check

The valid address range is:

```text
Minimum address = 0000_0000
Maximum address = 0000_03FF
```

The address presented to the slave in the waveform is:

```text
0000_0400
```

Therefore:

```text
0000_0400 > 0000_03FF
```

The access is invalid and must generate an ERROR response.

The waveform clearly shows `Haddr[31:0]` changing to:

```text
00000400
```

during the transaction, confirming that the out-of-range address is being passed to the slave.

---

## 3. Write Transaction

The invalid access shown in this waveform is a **write transaction**.

The master-side control signals show the write operation during the active transfer:

```text
Hwrite_m = 1
Htrans_m = 2
```

The write data shown on the master side is:

```text
Hwdata_m = dead...
```

and the corresponding slave-side write data is:

```text
Hwdata = deadbeef
```

The transaction therefore attempts to write data to the invalid address:

```text
Address = 0000_0400
Data    = DEADBEEF
```

Because `0x0000_0400` is outside the valid memory range, the slave generates an ERROR response.

---

## 4. ERROR Response — Write Transaction

The ERROR response is visible approximately from **55 ns to 75 ns**.

### First ERROR Response Cycle — 55–65 ns

During the first response cycle:

```text
HREADY = 0
HRESP  = 1
```

This means:

- `HRESP = 1` indicates that the slave is reporting an ERROR.
- `HREADY = 0` prevents the transfer from completing during this cycle.
- The master is held for the first response cycle.

### Second ERROR Response Cycle — 65–75 ns

During the second response cycle:

```text
HREADY = 1
HRESP  = 1
```

This means:

- `HRESP` remains asserted to indicate ERROR.
- `HREADY` becomes `1`.
- The ERROR response is completed.

### Write ERROR Response Summary

| Time | Transaction | Address | `HREADY` | `HRESP` | Description |
|---|---|---|---:|---:|---|
| 55–65 ns | Write | `0000_0400` | `0` | `1` | First ERROR response cycle |
| 65–75 ns | Write | `0000_0400` | `1` | `1` | Second ERROR response cycle; response completes |

The key response sequence is:

```text
HREADY : 0 → 1
HRESP  : 1 → 1
```

---

## 5. Complete ERROR Response Verification

The waveform demonstrates the complete ERROR response for the **out-of-range write access**.

### Transaction

```text
Operation : WRITE
Address   : 0000_0400
Valid max : 0000_03FF
Data      : DEADBEEF
```

Address check:

```text
0000_0400 > 0000_03FF
        ↓
   OUT OF RANGE
        ↓
    HRESP = 1
```

### ERROR response

```text
First cycle:
    HREADY = 0
    HRESP  = 1

Second cycle:
    HREADY = 1
    HRESP  = 1
```

### Verification Table

| Item | Observed Behavior | Verification |
|---|---|---|
| Address | `0000_0400` | Greater than `0000_03FF` |
| Access type | Write | Invalid write access |
| Error indication | `HRESP = 1` | ERROR reported |
| First response cycle | `HREADY = 0` | Transfer held |
| Second response cycle | `HREADY = 1` | Response completed |
| `HRESP` duration | Asserted for both response cycles | Correct ERROR response |

Therefore, the waveform verifies that an **out-of-range write access to `0x0000_0400`** correctly generates an **AHB-Lite two-cycle ERROR response**, with `HREADY` transitioning from `0` to `1` while `HRESP` remains asserted.
