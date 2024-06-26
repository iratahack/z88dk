;
;       ZX IF1 & Microdrive functions
;
;       Get Microdrive status
;
;       int if1_mdv_status (int drive);
;
;       Returns:
;       0: Microdrive Ready, cartridge inserted, no write protection
;       1: Cartridge is write protected
;       2: Microdrive not present
;
;       $Id: if1_mdv_status.asm $
;

    SECTION code_clib
    PUBLIC  if1_mdv_status
    PUBLIC  _if1_mdv_status

    EXTERN  if1_rommap
    EXTERN  MOTOR


if1_mdv_status:
_if1_mdv_status:

; __FASTCALL__

    ld      a, l
    ld      hl, -1
    and     a                           ; drive no. = 0 ?
    ret     z                           ; yes, return -1
    cp      9                           ; drive no. >8 ?
    ret     nc                          ; yes, return -1

    push    af
    call    if1_rommap
    pop     af

    call    MOTOR                       ; select drive motor
    ld      hl, retcode+1
    ld      a, 2
    ld      (hl), a
    jr      nz, estatus                 ; microdrive not present

    in      a, ($ef)
    and     1                           ; test the write-protect tab
		;;ret	z		; drive 'write' protected
    xor     1                           ; invert result (now 1=protected)
    ld      (hl), a

estatus:
    xor     a
    call    MOTOR                       ; Switch microdrive motor off (a=0)
    call    1                           ; unpage
    ei

retcode:
    ld      hl, 0
    ret
