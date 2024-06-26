
INCLUDE "config_private.inc"

SECTION code_clib
SECTION code_l_sdcc

PUBLIC __mulsuchar, __mulsuchar_0

EXTERN l_mulu_16_16x16

__mulsuchar:

   ; 8-bit mixed multiply
   ;
   ; enter : stack = multiplicand (signed byte), multiplicand (byte), ret
   ;
   ; exit  : hl = 16-bit product

   ld hl,3
   add hl,sp

   ld e,(hl)
   dec hl
   ld l,(hl)

   ; must promote to 16-bits

__mulsuchar_0:

   ld h,0

   ld a,e
   add a,a
   sbc a,a
   ld d,a

   jp l_mulu_16_16x16
