<img width="1573" height="807" alt="Image" src="https://github.com/user-attachments/assets/1e407897-7a28-4a9a-909c-d8ec7bb83fe6" />

AHB INCR16 Burst — 2-Byte Write and Read

The following simulation demonstrates an AHB INCR16 burst for both write and read operations with HSIZE = 1.

The burst starts at address 0x0000_0010. Since HSIZE = 1, each transfer is 2 bytes. With HBURST = 7, the transfer is a 16-beat incrementing burst (INCR16).

Unlike a WRAP16 burst, an INCR16 burst does not wrap back to the beginning of a fixed address boundary. The master simply increments the address by the transfer size after every beat.

Burst Configuration

Parameter

Value

Starting Address

0x0000_0010

HBURST

7 (INCR16)

HSIZE

1 (2 bytes)

Number of Beats

16

Transfer Size

2 bytes

Total Burst Size

32 bytes

HWRITE

1 for write / 0 for read

Write Start

45 ns

Read Start

245 ns

1. AHB INCR16 Write Burst

The write burst starts at 45 ns with the initial address:

0x0000_0010

Since each transfer is 2 bytes, the master increments HADDR by 0x02 for every beat.

Write Burst Address Sequence

0x0000_0010 → 0x0000_0012 → 0x0000_0014 → 0x0000_0016
→ 0x0000_0018 → 0x0000_001A → 0x0000_001C → 0x0000_001E
→ 0x0000_0020 → 0x0000_0022 → 0x0000_0024 → 0x0000_0026
→ 0x0000_0028 → 0x0000_002A → 0x0000_002C → 0x0000_002E

Write Burst Timing

Beat

Address Phase

Address

HTRANS

HWRITE

HBURST

HSIZE

Data Phase

1

45–55 ns

0x0000_0010

NONSEQ

1

INCR16

1 (2B)

55–65 ns

2

55–65 ns

0x0000_0012

SEQ

1

INCR16

1 (2B)

65–75 ns

3

65–75 ns

0x0000_0014

SEQ

1

INCR16

1 (2B)

75–85 ns

4

75–85 ns

0x0000_0016

SEQ

1

INCR16

1 (2B)

85–95 ns

5

85–95 ns

0x0000_0018

SEQ

1

INCR16

1 (2B)

95–105 ns

6

95–105 ns

0x0000_001A

SEQ

1

INCR16

1 (2B)

105–115 ns

7

105–115 ns

0x0000_001C

SEQ

1

INCR16

1 (2B)

115–125 ns

8

115–125 ns

0x0000_001E

SEQ

1

INCR16

1 (2B)

125–135 ns

9

125–135 ns

0x0000_0020

SEQ

1

INCR16

1 (2B)

135–145 ns

10

135–145 ns

0x0000_0022

SEQ

1

INCR16

1 (2B)

145–155 ns

11

145–155 ns

0x0000_0024

SEQ

1

INCR16

1 (2B)

155–165 ns

12

155–165 ns

0x0000_0026

SEQ

1

INCR16

1 (2B)

165–175 ns

13

165–175 ns

0x0000_0028

SEQ

1

INCR16

1 (2B)

175–185 ns

14

175–185 ns

0x0000_002A

SEQ

1

INCR16

1 (2B)

185–195 ns

15

185–195 ns

0x0000_002C

SEQ

1

INCR16

1 (2B)

195–205 ns

16

195–205 ns

0x0000_002E

SEQ

1

INCR16

1 (2B)

205–215 ns

AHB pipeline note: The address phase of beat N overlaps the data phase of beat N−1. Therefore, consecutive address and data phases overlap in time.

2. AHB INCR16 Read Burst

The read burst starts at 245 ns with the same starting address:

0x0000_0010

The read transaction uses the same 16-beat incrementing address sequence.

Read Burst Address Sequence

0x0000_0010 → 0x0000_0012 → 0x0000_0014 → 0x0000_0016
→ 0x0000_0018 → 0x0000_001A → 0x0000_001C → 0x0000_001E
→ 0x0000_0020 → 0x0000_0022 → 0x0000_0024 → 0x0000_0026
→ 0x0000_0028 → 0x0000_002A → 0x0000_002C → 0x0000_002E

Read Burst Timing

Beat

Address Phase

Address

HTRANS

HWRITE

HBURST

HSIZE

Data Phase

1

245–255 ns

0x0000_0010

NONSEQ

0

INCR16

1 (2B)

255–265 ns

2

255–265 ns

0x0000_0012

SEQ

0

INCR16

1 (2B)

265–275 ns

3

265–275 ns

0x0000_0014

SEQ

0

INCR16

1 (2B)

275–285 ns

4

275–285 ns

0x0000_0016

SEQ

0

INCR16

1 (2B)

285–295 ns

5

285–295 ns

0x0000_0018

SEQ

0

INCR16

1 (2B)

295–305 ns

6

295–305 ns

0x0000_001A

SEQ

0

INCR16

1 (2B)

305–315 ns

7

305–315 ns

0x0000_001C

SEQ

0

INCR16

1 (2B)

315–325 ns

8

315–325 ns

0x0000_001E

SEQ

0

INCR16

1 (2B)

325–335 ns

9

325–335 ns

0x0000_0020

SEQ

0

INCR16

1 (2B)

335–345 ns

10

335–345 ns

0x0000_0022

SEQ

0

INCR16

1 (2B)

345–355 ns

11

345–355 ns

0x0000_0024

SEQ

0

INCR16

1 (2B)

355–365 ns

12

355–365 ns

0x0000_0026

SEQ

0

INCR16

1 (2B)

365–375 ns

13

375–385 ns

0x0000_0028

SEQ

0

INCR16

1 (2B)

385–395 ns

14

385–395 ns

0x0000_002A

SEQ

0

INCR16

1 (2B)

395–405 ns

15

395–405 ns

0x0000_002C

SEQ

0

INCR16

1 (2B)

405–415 ns

16

405–415 ns

0x0000_002E

SEQ

0

INCR16

1 (2B)

415–425 ns

3. INCR16 Transaction Summary

Operation

Beat

Address Phase

Address

HTRANS

HWRITE

HBURST

HSIZE

Data Phase

Write

1

45–55 ns

0x10

NONSEQ

1

INCR16

1 (2B)

55–65 ns

Write

2

55–65 ns

0x12

SEQ

1

INCR16

1 (2B)

65–75 ns

Write

3

65–75 ns

0x14

SEQ

1

INCR16

1 (2B)

75–85 ns

Write

4

75–85 ns

0x16

SEQ

1

INCR16

1 (2B)

85–95 ns

Write

5

85–95 ns

0x18

SEQ

1

INCR16

1 (2B)

95–105 ns

Write

6

95–105 ns

0x1A

SEQ

1

INCR16

1 (2B)

105–115 ns

Write

7

105–115 ns

0x1C

SEQ

1

INCR16

1 (2B)

115–125 ns

Write

8

115–125 ns

0x1E

SEQ

1

INCR16

1 (2B)

125–135 ns

Write

9

125–135 ns

0x20

SEQ

1

INCR16

1 (2B)

135–145 ns

Write

10

135–145 ns

0x22

SEQ

1

INCR16

1 (2B)

145–155 ns

Write

11

145–155 ns

0x24

SEQ

1

INCR16

1 (2B)

155–165 ns

Write

12

155–165 ns

0x26

SEQ

1

INCR16

1 (2B)

165–175 ns

Write

13

165–175 ns

0x28

SEQ

1

INCR16

1 (2B)

175–185 ns

Write

14

175–185 ns

0x2A

SEQ

1

INCR16

1 (2B)

185–195 ns

Write

15

185–195 ns

0x2C

SEQ

1

INCR16

1 (2B)

195–205 ns

Write

16

195–205 ns

0x2E

SEQ

1

INCR16

1 (2B)

205–215 ns

Read

1

245–255 ns

0x10

NONSEQ

0

INCR16

1 (2B)

255–265 ns

Read

2

255–265 ns

0x12

SEQ

0

INCR16

1 (2B)

265–275 ns

Read

3

265–275 ns

0x14

SEQ

0

INCR16

1 (2B)

275–285 ns

Read

4

275–285 ns

0x16

SEQ

0

INCR16

1 (2B)

285–295 ns

Read

5

285–295 ns

0x18

SEQ

0

INCR16

1 (2B)

295–305 ns

Read

6

295–305 ns

0x1A

SEQ

0

INCR16

1 (2B)

305–315 ns

Read

7

305–315 ns

0x1C

SEQ

0

INCR16

1 (2B)

315–325 ns

Read

8

315–325 ns

0x1E

SEQ

0

INCR16

1 (2B)

325–335 ns

Read

9

325–335 ns

0x20

SEQ

0

INCR16

1 (2B)

335–345 ns

Read

10

335–345 ns

0x22

SEQ

0

INCR16

1 (2B)

345–355 ns

Read

11

345–355 ns

0x24

SEQ

0

INCR16

1 (2B)

355–365 ns

Read

12

355–365 ns

0x26

SEQ

0

INCR16

1 (2B)

365–375 ns

Read

13

375–385 ns

0x28

SEQ

0

INCR16

1 (2B)

385–395 ns

Read

14

385–395 ns

0x2A

SEQ

0

INCR16

1 (2B)

395–405 ns

Read

15

395–405 ns

0x2C

SEQ

0

INCR16

1 (2B)

405–415 ns

Read

16

405–415 ns

0x2E

SEQ

0

INCR16

1 (2B)

415–425 ns

4. Address Increment Calculation

For this transaction:

HSIZE = 1
Transfer Size = 2^1
              = 2 bytes

HBURST = INCR16
Number of Beats = 16

Total Burst Size = 16 × 2 bytes
                 = 32 bytes

The starting address is:

0x0000_0010

The master increments the address by 2 bytes per beat:

0x10 → 0x12 → 0x14 → 0x16
     → 0x18 → 0x1A → 0x1C → 0x1E
     → 0x20 → 0x22 → 0x24 → 0x26
     → 0x28 → 0x2A → 0x2C → 0x2E

The final address is:

0x0000_002E

The next address would be:

0x0000_0030

However, the burst contains exactly 16 beats, so the transaction ends at 0x0000_002E.

Important: Unlike WRAP16, an INCR16 burst does not wrap the address back to 0x10. The address continues to increment normally
