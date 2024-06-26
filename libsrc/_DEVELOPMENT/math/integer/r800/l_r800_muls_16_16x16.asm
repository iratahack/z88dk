
SECTION code_clib
SECTION code_math

EXTERN l_r800_mulu_16_16x16
EXTERN l_neg_hl, l_neg_de

PUBLIC l_r800_muls_16_16x16

l_r800_muls_16_16x16:

    ; multiplication of two 16-bit signed numbers into a 16-bit product
    ;
    ; enter : hl = 16-bit signed multiplier
    ;         de = 16-bit signed multiplicand
    ;
    ; exit  : hl = 16-bit signed product
    ;         carry reset
    ;
    ; uses  : af, bc, de, hl

    ld b,d                      ; d = MSB of multiplicand
    ld c,h                      ; h = MSB of multiplier
    push bc                     ; save sign info

    bit 7,d
    call NZ,l_neg_de            ; take absolute value of multiplicand

    bit 7,h
    call NZ,l_neg_hl            ; take absolute value of multiplier

    ld bc,de                    ; do unsigned multiplication
    muluw hl,bc

    pop bc                      ; recover sign info from multiplicand and multiplier
    ld a,b
    xor c
    ret P
    jp l_neg_hl               ; negate product if needed, and return
