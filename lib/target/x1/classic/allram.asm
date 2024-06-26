;	CRT0 for the Sharp X1 - all RAM mode
;
;	Karl Von Dyson (for X1s.org)
;
;

    defc    CRT_ORG_CODE = 0x0000
    defc    TAR__register_sp = 0x0000

    ; We want to intercept rst38 to our interrupt manager that reads the 
    ; keyboard
    defc    TAR__crt_enable_rst = $8080
    defc    TAR__crt_on_exit = $10001       ;loop forever
    EXTERN  asm_im1_handler
    defc    _z80_rst_38h = asm_im1_handler

    ; Add NMI for good measure
IFNDEF CRT_ENABLE_NMI
    defc        TAR__crt_enable_nmi = 1
    EXTERN      asm_nmi_handler
    defc        _z80_nmi = asm_nmi_handler
ENDIF	

    INCLUDE	"crt/classic/crt_rules.inc"

    org	CRT_ORG_CODE

    EXTERN asm_im1_handler
    EXTERN asm_nmi_handler
    EXTERN asm_im1_install_isr

if (ASMPC<>$0000)
    defs    CODE_ALIGNMENT_ERROR
endif
    di
    jp      program

    INCLUDE "crt/classic/crt_z80_rsts.inc"

program:
    INCLUDE "crt/classic/crt_init_sp.inc"

    call    crt0_init
    INCLUDE "crt/classic/crt_init_atexit.inc"
    INCLUDE "crt/classic/crt_init_heap.inc"

    ; Install the keyboard interrupt handler
    ld      de,asm_x1_keyboard_handler
    call    asm_im1_install_isr
    im      1
    ei
  
    call    _wait_sub_cpu
    ld      bc, $1900
    ld      a, $E4	; Interrupt vector set
    out     (c), a
    call    _wait_sub_cpu
    ld      bc,$1900
    ld      a, $52	; 
    out     (c), a
    call    _main

__Exit:
    call    crt0_exit
    INCLUDE "crt/classic/crt_exit_eidi.inc"
    INCLUDE "crt/classic/crt_terminate.inc"
