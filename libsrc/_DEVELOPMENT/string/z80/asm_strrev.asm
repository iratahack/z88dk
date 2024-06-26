
; ===============================================================
; Dec 2013
; ===============================================================
; 
; char *strrev(char *s)
;
; Reverse string in place.
;
; ===============================================================

SECTION code_clib
SECTION code_string

PUBLIC asm_strrev

EXTERN __str_locate_nul

asm_strrev:

   ; enter: hl = char *s
   ;
   ; exit : hl = char *s (reversed)
   ;        bc = 0
   ;
   ; uses : af, bc, de

   ; find end of string and string length
   
   ld de,hl                    ; de = char *s

   call __str_locate_nul       ; bc = -strlen(s) - 1
   dec hl                      ; hl = ptr to char prior to terminating 0

   push de                     ; save char *s

IF __CPU_INTEL__
   ld a,b
   rla
   ld a,b
   rra
   cpl
   ld b,a
   ld a,c
   rra
   cpl 
   ld c,a
ELSE
   ld a,b                      ; bc = ceil(-((-strlen-1)/2)-1)
   sra a                       ;    = ceil((strlen-1)/2)
   rr c                        ; -1 maps to 0 (strlen = 0)
   cpl                         ; -2 maps to 0 (strlen = 1)
   ld b,a                      ; -3 maps to 1 (strlen = 2)
   ld a,c                      ; -4 maps to 1 (strlen = 3)
   cpl                         ; etc, yields number of chars to swap
   ld c,a
ENDIF

   or b
   jr Z,exit                   ; if numswaps == 0, exit


IF __CPU_INTEL__ || __CPU_GBZ80__
   dec bc
   inc b
   inc c

loop:
   ld a,(de)                   ; char at front of s
   push af

   ld  a,(hl)
   ld (de+),a

   pop af
   ld (hl-),a

   dec c
   jr NZ,loop
   dec b
   jr NZ,loop

ELSE

loop:
   ld a,(de)                   ; char at front of s
   ldi                         ; char at rear written to front of s
   dec hl
   ld (hl),a                   ; char from front written to rear of s 
   dec hl
   jp PE,loop

ENDIF

exit:
   pop hl                      ; hl = char *s
   ret
