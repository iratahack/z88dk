CHANGES TO SOURCE CODE
======================

DHRY.H

Add after "include <math.h>":

typedef float double_t;
typedef float float_t;

VERIFY CORRECT RESULT
=====================

Using IDE HPDZ.EXE make a new project containing dhry_1.c and dhry_2.c.
Choose CP/M target and max optimizations with global optimization = 2.
Higher global optimization leads to the program hanging.

Under "MAKE->CPP pre-defined symbols" add -DSTATIC -DPRINTF.
Build the program, ignoring warnings as they come up.

Run on a cpm emulator to verify results.

TIMING
======

Change options to produce a ROM binary file.
Enable -DSTATIC and -DTIMER only for CPP pre-defined symbols.

Rebuild to produce DRHY.BIN.

Program size from the IDE dialog is: 1747 (ROM) + 5255 (RAM) = 7002
The two other sections correspond to page zero and initialization code.

To determine start and stop timing points, the output binary
was manually inspected.  TICKS command:

z88dk-ticks dhry.bin -start 0157 -end 02A1 -counter 999999999

start   = TIMER_START in hex
end     = TIMER_STOP in hex
counter = High value to ensure completion

If the result is close to the counter value, the program may have
prematurely terminated so rerun with a higher counter if that is the case.

RESULT
======

HITECH C MSDOS V780pl2
1895 bytes exact

cycle count  = 280100135
time @ 4MHz  = 280100135 / 4x10^6 = 70.0250 seconds
dhrystones/s = 20000 / 70.0250 = 285.6121
DMIPS        = 285.6121 / 1757 = 0.1625
