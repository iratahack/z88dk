;       CRT0 for the Mattel Aquarius
;
;       Stefano Bodrato Dec. 2000
;
;       If an error occurs eg break we just drop back to BASIC
;
;       $Id: aquarius_crt0.asm $
;

IF      !DEFINED_CRT_ORG_CODE
    defc    CRT_ORG_CODE  = 14768
ENDIF




IFNDEF CLIB_FARHEAP_FIRST
    defc CLIB_FARHEAP_FIRST = AQPLUS_FIRST_BANK
ENDIF

IF CLIB_FARHEAP_BANKS = -1
    UNDEFINE CLIB_FARHEAP_BANKS
    defc CLIB_FARHEAP_BANKS = 64 - CLIB_FARHEAP_FIRST
ENDIF


    defc    TAR__clib_exit_stack_size = 32
    defc    TAR__register_sp = -1
    INCLUDE "crt/classic/crt_rules.inc"

    org     CRT_ORG_CODE

start:
    ld      (__restore_sp_onexit+1),sp	;Save entry stack
    INCLUDE "crt/classic/crt_init_sp.inc"
    call    crt0_init
    INCLUDE "crt/classic/crt_init_atexit.inc"

    INCLUDE "crt/classic/crt_init_heap.inc"
    INCLUDE "crt/classic/crt_init_eidi.inc"
    di
IF CRT_DISABLELOADER != 1
    call    loadbanks
ENDIF
IF CLIB_FARHEAP_BANKS
    call    setup_far_heap
ENDIF

    call    _main   ;Call user program
__Exit:
    call    crt0_exit


__restore_sp_onexit:
    ld  sp,0        ;Restore stack to entry value
    ret




IF CLIB_FARHEAP_BANKS
    EXTERN sbrk_far
setup_far_heap:
    ld      a,CLIB_FARHEAP_BANKS
    push    af                  ;Save it
    srl     a                   ;/4
    srl     a
    ld      de,+((((CLIB_FARHEAP_FIRST - AQPLUS_FIRST_BANK) >> 2) +1) % 256)
    ld      hl,0
    and     a
    jr      z,handle_residual
    ld      b,a
sbrk_loop:
    push    bc
    push    de
    push    hl
    ld      bc,$ffff
    push    bc
    call    sbrk_far
    pop     bc
    pop     hl
    pop     de
    inc     e
    pop     bc      ;Loop count
    djnz    sbrk_loop
handle_residual:
    pop     af
    ; And any left over pages we can just add mnually
  IF (CLIB_FARHEAP_BANKS % 4) > 0
    and     3
    ret     z
    ld      bc,$3fff
    cp      1
    jr      z,sbrk_residual
    ld      bc,$7fff
    cp      2
    jr      z,sbrk_residual
    ld      bc,$bfff
sbrk_residual:
    push    de
    push    hl
    push    bc
    call    sbrk_far
    pop     af
    pop     af
    pop     af
  ENDIF
    and     a
    ret
ENDIF


IF CRT_DISABLELOADER != 1
    ; We bank into segment3
    PUBLIC  banked_call
banked_call:
    pop     hl              ; Get the return address
    ld      (mainsp),sp
    ld      sp,(tempsp)
    in      a,(PORT_BANK3)
    push    af              ; Push the current bank onto the stack
    ld      e,(hl)          ; Fetch the call address
    inc     hl
    ld      d,(hl)
    inc     hl
    ld      a,(hl)          ; ...and page
    add     AQPLUS_FIRST_BANK - 1
    inc     hl
    inc     hl              ; Yes this should be here
    push    hl              ; Push the real return address
    ld      (tempsp),sp
    ld      sp,(mainsp)
    out     (PORT_BANK3),a
    ld      l,e
    ld      h,d
    call	l_dcal		; jp(hl)
    ld      (mainsp),sp
    ld      sp,(tempsp)
    pop     bc              ; Get the return address
    pop     af              ; Pop the old bank
    ld      (tempsp),sp
    ld      sp,(mainsp)
    out     (PORT_BANK3),a
    push    bc
    ret

    EXTERN  __esp_send_cmd
    EXTERN  __esp_send_byte
    EXTERN  __esp_send_bytes
    EXTERN  __esp_read_byte
    EXTERN  asm_strlen
    
; Load banks 35 -> 63 (we call them 1 ->29 )
loadbanks:
    ; Save current binding
    in      a,(PORT_BANK3)
    push    af
    ld      a,1
loadloop:
    push    af
    add     AQPLUS_FIRST_BANK - 1  ;We use banks 1 - 29 for compatibility with other targets
    out     (PORT_BANK3),a
    sub     AQPLUS_FIRST_BANK - 1
    call    setext
    ld      a,ESPCMD_OPEN
    call    __esp_send_cmd
    xor     a                   ;O_RDONLY
    call    __esp_send_byte
    ld      hl,_basename
    push    hl
    call    asm_strlen
    ld      bc,hl
    inc     bc
    pop     hl
    call    __esp_send_bytes
    call    __esp_read_byte     ;Read fd
    bit     7,a
    jr      nz,next
    ld      b,a                 ;Keep fd safe
    ld      a,ESPCMD_READ
    call    __esp_send_cmd
    ; Send fd
    ld      a,b
    call    __esp_send_byte
    ; Now send length (16384)
    xor     a
    call    __esp_send_byte
    ld      a,64
    call    __esp_send_byte
    ; Read result
    call    __esp_read_byte
    and     a
    jr      nz,next
    ; Read offered length
    call    __esp_read_byte
    ld      c,a
    call    __esp_read_byte
    ld      b,a
    ; And read into our bank
    ld      hl,$C000
loop:
    ld      a,b
    or      c
    jr      z,next
    call    __esp_read_byte
    ld      (hl),a
    inc     hl
    dec     bc
    jr      loop
next:
    pop     af
    inc     a
    cp      29
    jr      nz,loadloop
    ; Close all files
    ld      a,ESPCMD_CLOSEALL
    call    __esp_send_cmd
    call    __esp_read_byte     ;Read the response
    pop     af
    out     (PORT_BANK3),a
    ret

setext:
    ld      hl,__basename_ext
    ld      b,a
    rra
    rra
    rra
    rra
    call    conv
    ld      a,b
conv:
    and     15
    add     $90
    daa
    adc     $40
    daa
    ld      (hl),a
    inc     hl
    ret


; Use #pragma string basename [basename] to set the name of the file
_basename:
    DEFINE NEED_basename
    INCLUDE "zcc_opt.def"
    UNDEFINE NEED_basename
    defb    '.'
__basename_ext:
    defm    "00"
    defb    0

mainsp:     defw    0
tempstack:  defs    CLIB_BANKING_STACK_SIZE
tempsp:     defw    tempstack + CLIB_BANKING_STACK_SIZE
ENDIF
