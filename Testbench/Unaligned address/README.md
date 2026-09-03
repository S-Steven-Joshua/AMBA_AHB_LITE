<img width="1572" height="812" alt="Image" src="https://github.com/user-attachments/assets/8d9b7175-457d-4dd0-a71a-b065fed2b117" />

# AHB-Lite HREADY and HRESP Error Response Verification

## 1. Objective

This simulation is intended to verify the correct operation of the **AHB-Lite `HREADY` and `HRESP` signals**, specifically the behavior of an **ERROR response** for both **write and read transactions**.

The main purpose of this waveform is to demonstrate that when an error occurs:

- `HRESP` indicates an ERROR response.
- `HREADY` is driven low for the first response cycle.
- `HREADY` is driven high for the second response cycle.
- `HRESP` remains asserted for both response cycles.

The waveform contains two ERROR response events:
1. The **first ERROR response occurs during a write transaction**.
2. The **second ERROR response occurs during a read transaction**.

---

## 2. AHB-Lite ERROR Response

For an AHB-Lite ERROR response, the response is presented over **two cycles**.

The expected pattern is:

| Response Cycle | `HREADY` | `HRESP` | Meaning |
|---|---:|---:|---|
| First cycle | `0` | `1` | ERROR response is indicated and the transfer is held |
| Second cycle | `1` | `1` | ERROR response is completed |

Thus:

```text
First cycle:
    HREADY = 0
    HRESP  = 1

Second cycle:
    HREADY = 1
    HRESP  = 1
```

The uploaded waveform demonstrates this behavior for both a write transaction and a read transaction.

---

## 3. First ERROR Response — Write Transaction

The **first ERROR response occurs during the write transaction**, approximately between **55 ns and 75 ns**.

### Cycle 1: 55–65 ns

```text
HREADY = 0
HRESP  = 1
```

During this cycle, `HRESP` is asserted to indicate an ERROR response, while `HREADY` is low. Therefore, the transfer is not yet completed.

### Cycle 2: 65–75 ns

```text
HREADY = 1
HRESP  = 1
```

During the second response cycle, `HREADY` becomes high while `HRESP` remains asserted. This completes the ERROR response.

### First ERROR Response Summary

| Time | Transaction | `HREADY` | `HRESP` | Meaning |
|---|---|---:|---:|---|
| 55–65 ns | Write | `0` | `1` | First ERROR response cycle; transfer held |
| 65–75 ns | Write | `1` | `1` | Second ERROR response cycle; response completes |

Therefore, the first error event demonstrates:

```text
Write ERROR Response

HREADY : 0 → 1
HRESP  : 1 → 1
```

---

## 4. Second ERROR Response — Read Transaction

The **second ERROR response occurs during the read transaction**, approximately between **135 ns and 155 ns**.

### Cycle 1: 135–145 ns

```text
HREADY = 0
HRESP  = 1
```

During the first response cycle, `HREADY` is low and `HRESP` is asserted. The transfer is therefore held while the ERROR response is initiated.

### Cycle 2: 145–155 ns

```text
HREADY = 1
HRESP  = 1
```

During the second response cycle, `HREADY` becomes high while `HRESP` remains asserted, completing the ERROR response.

### Second ERROR Response Summary

| Time | Transaction | `HREADY` | `HRESP` | Meaning |
|---|---|---:|---:|---|
| 135–145 ns | Read | `0` | `1` | First ERROR response cycle; transfer held |
| 145–155 ns | Read | `1` | `1` | Second ERROR response cycle; response completes |

Therefore, the second error event demonstrates:

```text
Read ERROR Response

HREADY : 0 → 1
HRESP  : 1 → 1
```

---

## 5. Complete ERROR Response Verification

The two ERROR response events visible in the waveform can be summarized as follows:

| Error Event | Transaction | First Response Cycle | Second Response Cycle | `HRESP` Behavior |
|---|---|---|---|---|
| Error 1 | **Write** | 55–65 ns: `HREADY=0` | 65–75 ns: `HREADY=1` | `HRESP=1` for both cycles |
| Error 2 | **Read** | 135–145 ns: `HREADY=0` | 145–155 ns: `HREADY=1` | `HRESP=1` for both cycles |

The waveform therefore verifies the intended ERROR response behavior for **both write and read operations**:

```text
WRITE ERROR RESPONSE
--------------------
Cycle 1: HREADY = 0, HRESP = 1
Cycle 2: HREADY = 1, HRESP = 1


READ ERROR RESPONSE
-------------------
Cycle 1: HREADY = 0, HRESP = 1
Cycle 2: HREADY = 1, HRESP = 1
```

This demonstrates that:

- `HRESP` correctly indicates an ERROR response.
- `HREADY` is held low during the first ERROR-response cycle.
- `HREADY` becomes high during the second response cycle.
- `HRESP` remains asserted for both response cycles.
- The ERROR response is correctly completed after two response cycles.
- The same ERROR-response mechanism works for both **write** and **read** transactions.
