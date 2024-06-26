;
;       Spectrum C Library
;
; 	ANSI Video handling for ZX Spectrum
;
; 	Handles colors referring to current PAPER/INK/etc. settings
;
;	** alternate (smaller) 4bit font capability:
;	** use the -DPACKEDFONT flag
;	** ROM font -DROMFONT
;
;	set it up with:
;	.__console_w	= max columns
;	.__console_h	= max rows
;	ansicharacter_pixelwidth = char size
;	ansifont	= font file
;
;	Display a char in location (__console_y),(__console_x)
;	A=char to display
;
;
;	$Id: f_ansi_char.asm,v 1.6 2016-06-12 16:06:43 dom Exp $
;

    SECTION code_clib

    PUBLIC  ansi_CHAR

    EXTERN  __console_y
    EXTERN  __console_x

    EXTERN  __console_w
    EXTERN  __console_h

; Dirty thing for self modifying code
    PUBLIC  INVRS
    PUBLIC  BOLD
    EXTERN  ansifont
    EXTERN  ansifont_is_packed
    EXTERN  ansicharacter_pixelwidth

    SECTION code_clib


ansi_CHAR:
    ld      b, a                        ;save character
    ld      a, ansicharacter_pixelwidth
    cp      8
    ld      a, b
    jp      nz, ansi_char_flexible

	; Fast path for printing 8 wide characters
    ld      hl, (BOLD)
    ld      (BOLD2), hl
    ex      af, af                      ;save character
    ld      a, (__console_y)            ; Line text position
    ld      c, a
    and     24
    ld      d, a
    ld      a, c
    and     7
    rrca
    rrca
    rrca
    ld      e, a
    ld      hl, 16384
    add     hl, de
    ld      a, (__console_x)
    srl     a
    jr      nc, first_display
    set     5, h
first_display:
    add     a, l
    ld      l, a
    push    hl
    ex      af, af                      ;character back
    ld      l, a
    ld      h, 0
    add     hl, hl
    add     hl, hl
    add     hl, hl

    ld      de, ansifont-256
    add     hl, de

    pop     de                          ; de - screen, hl - font
    ld      b, 7
    ld      a, (INVRS)
    ld      c, a
char_loop:
    ld      a, (hl)
BOLD2:
    nop                                 ;SMC: rla
    nop                                 ;SMC: or(hl)
    bit     0, c
    jr      z, no_invers
    cpl
no_invers:
    ld      (de), a
    inc     hl
    inc     d
    djnz    char_loop
; Now check for underline
    ld      c, (hl)                     ;next row to print
    ld      a, (INVRS+2)
    cp      24                          ;some magic change i think
    jr      z, no_underline
    ld      c, 255
no_underline:
    ld      a, c
    ld      (de), a
    ret




ansi_char_flexible:
    ld      (char+1), a
    ld      a, (__console_y)            ; Line text position
    push    af
    and     24
    ld      d, a
    pop     af
    and     7
    rrca
    rrca
    rrca
    ld      e, a
    ld      hl, 16384
    add     hl, de
    ld      (RIGA+1), hl

    ld      b, ansicharacter_pixelwidth
    ld      hl, 0
    ld      a, (__console_x)            ; Column text position
    ld      e, a
    ld      d, 0
    or      d
    jr      z, ZCL
LP:
    add     hl, de
    djnz    LP
    ld      a, l
    and     7
    ld      b, 3
LDIV:
    srl     h
    rr      l
    djnz    LDIV
    srl     l
    jr      nc, ZCL
    set     5, h
ZCL:
; Added for color handling
;  push hl
 ; push af
;  ld de,22528-32
;  add hl,de
;  ld a,(__console_y)
;  inc a
;  ld de,32
;.CLP
;  add hl,de
;  dec a
;  jr nz,CLP
;  ld a,(23693)  ;Current color attributes
;  ld (hl),a
;  pop af
;  pop hl
; end of color handling

;  ld b,5
;.RGTA
;  srl a
;  djnz RGTA
    ld      (PRE+1), a
    add     ansicharacter_pixelwidth
    ld      e, a
    ld      a, 16
    sub     e
    ld      (POST+1), a
RIGA:                                   ; Location on screen
    ld      de, 16384
    add     hl, de
    push    hl
    pop     ix
char:
    ld      b, 'A'                      ;SMC: Put here the character to be printed

    ld      hl, ansifont-256
    ld      a, ansifont_is_packed
    and     a
    jr      z, got_font_location
    xor     a
    rr      b
    jr      c, even
    ld      a, 4
even:
    ld      (ROLL+1), a
    ld      hl, ansifont-128
got_font_location:
    ld      de, 8
LFONT:
    add     hl, de
    djnz    LFONT
    ld      de, 256
    ld      c, 8
PRE:
    ld      b, 4                        ;SMC
    call    rlix
    inc     b
    dec     b
    jr      z, DTS
L1:
    call    rlix
    djnz    L1
DTS:
    ld      a, (hl)
BOLD:
    nop                                 ;SMC: rla
    nop                                 ;SMC: or(hl)
    ld      b, a
    ld      a, ansifont_is_packed
    and     a
    ld      a, b
    jr      z, INVRS

ROLL:
    jr      INVRS                       ;SMC
    rla
    rla
    rla
    rla

INVRS:
    nop                                 ;cpl
    dec     c
    jr      UNDRL                       ;SMC: INVRS+2, set to jr nz to underline
    ld      a, 255
UNDRL:
    inc     c

    ld      b, ansicharacter_pixelwidth
L2:
    rla
    call    rlix
    djnz    L2
POST:
    ld      b, 6
    inc     b
    dec     b
    jr      z, NEXT
L3:
    call    rlix
    djnz    L3
NEXT:
    add     ix, de
    inc     hl
    dec     c
    jr      nz, PRE
    ret


; The font
; 9 dots: MAX 28 columns
; 8 dots: MAX 32 columns The only one perfecly color aligned
; 7 dots: MAX 36 columns
; 6 dots: MAX 42 columns Good matching with color attributes
; 5 dots: MAX 51 columns
; 4 dots: MAX 64 columns Matched with color attributes (2 by 2)
; 3 dots: MAX 85 columns Just readable!
; 2 dots: MAX 128 columns (useful for ANSI graphics only.. maybe)
; Address 15360 for ROM Font

rlix:
    push    bc
    ld      b, ixh
    bit     5, b
    jr      z, first
    res     5, b
    ld      ixh, b
    rl      (ix+1)
    set     5, b
    ld      ixh, b
    rl      (ix+0)
    pop     bc
    ret
first:
    set     5, b
    ld      ixh, b
    rl      (ix+0)
    res     5, b
    ld      ixh, b
    rl      (ix+0)
    pop     bc
    ret
