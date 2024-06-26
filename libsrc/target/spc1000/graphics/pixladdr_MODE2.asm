;

;-----------  GFX paging  -------------

    SECTION code_clib

    PUBLIC  pixeladdress_MODE2

    INCLUDE "target/spc1000/def/spc1000.def"

; Entry  h = x
;        l = y
; Exit: hl = address
;	 a = pixel number
; Uses: a, bc, de, hl
pixeladdress_MODE2:

	; add y-times the nuber of bytes per line (32)
	; or just multiply y by 32 and the add
    ld      e, h
    ld      h, 0
    add     hl, hl
    add     hl, hl
    add     hl, hl
    add     hl, hl
    add     hl, hl
    ld      a, e                        ;4 pixels per byte
    srl     e
    srl     e
    ld      d, 0
    add     hl, de
    and     3
    xor     3
    ret
