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

- **~30–40 ns:** First transfer
  - `HTRANS = NONSEQ`
  - `HBURST = INCR`
  - `HSIZE = 2`
  - Starting address is associated with the first transaction.

- **~40–50 ns:** Next sequential transfer
  - `HTRANS = SEQ`
  - Address advances by 4 bytes.

- **~50–60 ns:** Next sequential transfer
  - `HTRANS = SEQ`
  - Address advances by another 4 bytes.

- **~60–70 ns:** BUSY interval
  - `HTRANS = BUSY`
  - No additional data beat is counted for the burst.
  - The burst is subsequently terminated.

- **~70–110 ns:** `HTRANS = IDLE`
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

- **~110–120 ns:** First WRAP4 transfer
  - `HTRANS = NONSEQ`
  - `HBURST = WRAP4`
  - `HSIZE = 2`
  - Starting address: `0x0000_0020`

- **~120–130 ns:** WRAP4 Beat 2
  - `HTRANS = SEQ`
  - Address advances by 4 bytes.

- **~130–140 ns:** WRAP4 Beat 3
  - `HTRANS = SEQ`
  - Address advances by 4 bytes.

- **~140–150 ns:** WRAP4 Beat 4
  - `HTRANS = SEQ`
  - Final transfer of the four-beat WRAP4 burst.

- **~150 ns onward:** Transaction returns to `IDLE`.

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

# Transaction Sequence Summary

```text
FIRST TRANSACTION
────────────────────────────────────────────

HBURST = INCR
HSIZE  = 2

IDLE
  │
  ├── NONSEQ   (~30–40 ns)
  │
  ├── SEQ      (~40–50 ns)
  │
  ├── SEQ      (~50–60 ns)
  │
  ├── BUSY     (~60–70 ns)
  │
  └── IDLE     (~70–110 ns)
             ↑
       Early termination


SECOND TRANSACTION
────────────────────────────────────────────

HBURST = WRAP4
HSIZE  = 2

IDLE
  │
  ├── NONSEQ   (~110–120 ns) → 0x20
  ├── SEQ      (~120–130 ns) → 0x24
  ├── SEQ      (~130–140 ns) → 0x28
  ├── SEQ      (~140–150 ns) → 0x2C
  │
  └── IDLE
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
