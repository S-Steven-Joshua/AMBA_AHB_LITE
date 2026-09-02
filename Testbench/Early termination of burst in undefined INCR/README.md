<img width="1576" height="810" alt="Image" src="https://github.com/user-attachments/assets/26f8144d-144b-44b2-85e3-9ab6535e7d21" />

# AHB Burst Test — Early Termination of Undefined-Length Burst Followed by WRAP4

This simulation demonstrates two back-to-back AHB transactions:

1. An **undefined-length incrementing burst (`HBURST = INCR`)** that is **terminated early**.
2. A new **4-beat wrapping burst (`HBURST = WRAP4`)** started after the first burst is terminated.

`HSIZE = 2` throughout the waveform, so every transfer is **4 bytes**.

> **Important:** The timing below is taken from the waveform's **AHB bus signals (`Haddr`, `Htrans`, `Hburst`, etc.)**, rather than using `Haddr_m` as the reference for the transaction timing.

---

## Burst Configuration

### First transaction — Undefined-length burst

- `HBURST = 1` → `INCR` (undefined-length incrementing burst)
- `HSIZE = 2` → 4-byte transfer
- Starting address presented by the transaction: `0x0000_0010`
- `HTRANS` begins with `NONSEQ`
- The burst continues with `SEQ`
- A `BUSY` transfer is inserted
- The burst is then terminated by returning to `IDLE`
- Because `INCR` has no fixed beat count, the master can terminate it before completing any predefined number of beats.

### Second transaction — WRAP4

- `HBURST = 2` → `WRAP4`
- `HSIZE = 2` → 4-byte transfer
- Starting address: `0x0000_0020`
- Four data transfers are performed
- Address increment = 4 bytes

---

# 1. Early Termination of the Undefined-Length Burst

The first transaction is an **undefined-length (`INCR`) burst**.

From the `HTRANS` waveform, the sequence is:

```text
IDLE → NONSEQ → SEQ → SEQ → BUSY → IDLE
```

The important observation is that the burst **does not continue indefinitely**. The master inserts `BUSY` and then terminates the transaction by driving `HTRANS = IDLE`.

### Timing observed in the waveform

- **~45–55 ns:** First transfer
  - `HTRANS = NONSEQ`
  - `HBURST = INCR`
  - `HSIZE = 2`
  - Starting address is associated with the first transaction.

- **~55–65 ns:** Next sequential transfer
  - `HTRANS = SEQ`
  - Address advances by 4 bytes.

- **~65–75 ns:** Next sequential transfer
  - `HTRANS = SEQ`
  - Address advances by another 4 bytes.

- **~76–86 ns:** BUSY interval
  - `HTRANS = BUSY`
  - No additional data beat is counted for the burst.
  - The burst is subsequently terminated.

- **~86–126 ns:** `HTRANS = IDLE`
  - The undefined-length burst has ended.
  - The bus remains idle before the next transaction starts.

### Why this is an early termination

`HBURST = INCR` does not specify a fixed number of beats. Therefore, unlike `WRAP4`, there is no requirement to complete four transfers.

The waveform shows the master ending this transaction after a short sequence:

```text
NONSEQ → SEQ → SEQ → BUSY → IDLE
```

The `BUSY` cycle is part of the burst control sequence, but it is **not an additional data transfer**.

---

# 2. Starting a New WRAP4 Burst

After the first undefined-length burst has returned to `IDLE`, a **new WRAP4 transaction** begins.

The `HBURST` signal changes from:

```text
INCR   (1)
   ↓
WRAP4  (2)
```

and `HTRANS` starts a new transaction with:

```text
NONSEQ → SEQ → SEQ → SEQ
```

### Timing observed in the waveform

- **~135–145 ns:** First WRAP4 transfer
  - `HTRANS = NONSEQ`
  - `HBURST = WRAP4`
  - `HSIZE = 2`
  - Starting address: `0x0000_0020`

- **~145–155 ns:** WRAP4 Beat 2
  - `HTRANS = SEQ`
  - Address advances by 4 bytes.

- **~155–165 ns:** WRAP4 Beat 3
  - `HTRANS = SEQ`
  - Address advances by 4 bytes.

- **~165–175 ns:** WRAP4 Beat 4
  - `HTRANS = SEQ`
  - Final transfer of the four-beat WRAP4 burst.

- **~166 ns onward:** Transaction returns to `IDLE`.

---

# WRAP4 Address Calculation

For `HSIZE = 2`:

```text
Transfer Size = 2^2
              = 4 bytes
```

For a four-beat wrapping burst:

```text
Wrap Size = 4 beats × 4 bytes
          = 16 bytes
```

Starting at `0x0000_0020`, the WRAP4 address sequence is:

```text
Beat 1 → 0x0000_0020
Beat 2 → 0x0000_0024
Beat 3 → 0x0000_0028
Beat 4 → 0x0000_002C
```

After `0x0000_002C`, another transfer would wrap back to:

```text
0x0000_0020
```

---


# Key Observation

The waveform verifies an **early termination of an undefined-length (`INCR`) burst**, followed by a **new WRAP4 burst**.

The important control transition is:

```text
INCR burst:
NONSEQ → SEQ → SEQ → BUSY → IDLE

then

WRAP4 burst:
NONSEQ → SEQ → SEQ → SEQ → IDLE
```

Thus, the first burst is **not completed as a fixed-length burst** because `INCR` is undefined length. The return to `IDLE` terminates it. After the idle period, the master starts a completely new **WRAP4 burst with `HSIZE = 2`**, beginning at `0x0000_0020`.
