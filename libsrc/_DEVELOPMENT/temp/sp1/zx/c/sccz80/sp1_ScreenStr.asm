; uint sp1_ScreenStr(uchar row, uchar col)
; CALLER linkage for function pointers

SECTION code_clib
SECTION code_temp_sp1

PUBLIC sp1_ScreenStr

EXTERN asm_sp1_ScreenStr

sp1_ScreenStr:

   ld hl,2
   ld e,(hl)
   inc hl
   inc hl
   ld d,(hl)
   
;   jp asm_sp1_ScreenStr
   push ix
   call asm_sp1_ScreenStr
   pop ix
   ret

; SDCC bridge for Classic
IF __CLASSIC
PUBLIC _sp1_ScreenStr
defc _sp1_ScreenStr = sp1_ScreenStr
ENDIF

