
; ===============================================================
; Dec 2013
; ===============================================================
; 
; char *stpcpy(char * restrict s1, const char * restrict s2)
;
; Copy string s2 to s1, return ptr to terminating NUL in s1
;
; ===============================================================

SECTION code_clib
SECTION code_string

PUBLIC asm_stpcpy

asm_stpcpy:

   ; enter : hl = char *s2 = src
   ;         de = char *s1 = dst
   ;
   ; exit  : hl = ptr in dst to terminating NUL
   ;         de = ptr in src to terminating NUL
   ;
   ; uses  : af, bc, de, hl

   xor a
   
loop:

IF __CPU_INTEL__ || __CPU_GBZ80__

   ld a,(hl+)
   ld (de+),a

   and a
   jr NZ,loop

ELSE

   cp (hl)
   ldi
   jr NZ,loop

ENDIF

   dec de
   dec hl

   ex de,hl
   ret
