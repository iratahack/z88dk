; uint in_LookupKey(uchar c)

    SECTION code_clib
    PUBLIC  in_LookupKey
    PUBLIC  _in_LookupKey
    EXTERN  in_keytranstbl

; Given the ascii code of a character, returns the scan row and mask
; corresponding to the key that needs to be pressed to generate the
; character.
;
; The scan row returned will have bit 7 set and bit 6 set to
; indicate if CAPS, SYM SHIFTS also have to be pressed to generate the
; ascii code, respectively.

; enter: L = ascii character code
; exit : L = scan row
;        H = mask
;        else: L = scan row, H = mask
;              bit 7 of L set if SHIFT needs to be pressed
;              bit 6 of L set if CTRL needs to be pressed
; uses : AF,BC,HL

; The 16-bit value returned is a scan code understood by
; in_KeyPressed.

in_LookupKey:
_in_LookupKey:
    ld      a, l
    ld      hl, in_keytranstbl
    ld      bc, 64*3
    cpir
    jr      nz, notfound

    ld      a, +(64*3)-1
    sub     c                           ;A = position in table
    ld      c, a
    ld      hl, 0
    cp      64*2
    jr      c, not_function_table
    sub     64*2
    ld      c, a
    set     6, l
    jr      continue

notfound:
    ld      hl, 0
    scf
    ret


not_function_table:
    cp      64
    jr      c, continue
    sub     64
    ld      c, a
    set     7, l

continue:
	; l = flags
	; c = character
	; find the row divide by 4
    ld      a, c
    rrca
    rrca
    and     15                          ;row number
    ld      h, a
    ld      a, c
    and     3

	; l = row number, a = character in row
	; find the mask
    ld      b, @00000001
    ld      e, a
find_mask:
    ld      a, e
    and     a
    jr      z, found_mask
    rlc     b
    dec     e
    jr      find_mask

found_mask:
	; l = modifiers
	; h = row number
	; b = mask
    ld      a, l
    or      h
    ld      l, a
    ld      h, b
    and     a
    ret


