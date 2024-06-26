
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; crt rules ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   IFDEF CRT_ORG_CODE
      
      defc __crt_org_code = CRT_ORG_CODE
      
   ELSE
      
      IFDEF TAR__crt_org_code
         
         defc __crt_org_code = TAR__crt_org_code
         
      ELSE
         
         defc __crt_org_code = DEF__crt_org_code
         
      ENDIF
      
   ENDIF

   IFDEF REGISTER_SP
   
      defc __register_sp = REGISTER_SP
   
   ELSE
   
      IFDEF STACKPTR
      
         defc __register_sp = STACKPTR
      
      ELSE
      
         IFDEF TAR__register_sp
         
            defc __register_sp = TAR__register_sp
         
         ELSE
         
            defc __register_sp = DEF__register_sp
         
         ENDIF
         
      ENDIF
   
   ENDIF
   
   
   IFDEF CRT_STACK_SIZE
   
      defc __crt_stack_size = CRT_STACK_SIZE
   
   ELSE
   
      IFDEF TAR__crt_stack_size
      
         defc __crt_stack_size = TAR__crt_stack_size
      
      ELSE
      
         defc __crt_stack_size = DEF__crt_stack_size
      
      ENDIF
   
   ENDIF
   
      
   IFDEF CRT_ORG_DATA
   
      defc __crt_org_data = CRT_ORG_DATA
   
   ELSE
   
      IFDEF TAR__crt_org_data
      
         defc __crt_org_data = TAR__crt_org_data
      
      ELSE
      
         defc __crt_org_data = DEF__crt_org_data
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CRT_ORG_BSS
   
      defc __crt_org_bss = CRT_ORG_BSS
   
   ELSE
   
      IFDEF TAR__crt_org_bss
      
         defc __crt_org_bss = TAR__crt_org_bss
      
      ELSE
      
         defc __crt_org_bss = DEF__crt_org_bss
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CRT_MODEL
   
      defc __crt_model = CRT_MODEL
   
   ELSE
   
      IFDEF TAR__crt_model
      
         defc __crt_model = TAR__crt_model
      
      ELSE
      
         defc __crt_model = DEF__crt_model
      
      ENDIF
   
   ENDIF
   
   IFDEF CRT_INITIALIZE_BSS
   
      defc __crt_initialize_bss = CRT_INITIALIZE_BSS
   
   ELSE
   
      IFDEF TAR__crt_initialize_bss
      
         defc __crt_initialize_bss = TAR__crt_initialize_bss
      
      ELSE
      
         defc __crt_initialize_bss = DEF__crt_initialize_bss
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CRT_INCLUDE_PREAMBLE
   
      defc __crt_include_preamble = CRT_INCLUDE_PREAMBLE
   
   ELSE
   
      IFDEF TAR__crt_include_preamble
      
         defc __crt_include_preamble = TAR__crt_include_preamble
      
      ELSE
      
         defc __crt_include_preamble = DEF__crt_include_preamble
      
      ENDIF
      
   ENDIF

   IFDEF CRT_ORG_VECTOR_TABLE
   
      defc __crt_org_vector_table = CRT_ORG_VECTOR_TABLE
   
   ELSE
   
      IFDEF TAR__crt_org_vector_table
      
         defc __crt_org_vector_table = TAR__crt_org_vector_table
      
      ELSE
      
         defc __crt_org_vector_table = DEF__crt_org_vector_table
      
      ENDIF
      
   ENDIF

IF __Z180

   IFDEF CRT_IO_VECTOR_BASE
   
      defc __crt_io_vector_base = CRT_IO_VECTOR_BASE
   
   ELSE
   
      IFDEF TAR__crt_io_vector_base
      
         defc __crt_io_vector_base = TAR__crt_io_vector_base
      
      ELSE
      
         defc __crt_io_vector_base = DEF__crt_io_vector_base
      
      ENDIF
      
   ENDIF

ENDIF

   IFDEF CRT_INTERRUPT_MODE
   
      defc __crt_interrupt_mode = CRT_INTERRUPT_MODE
   
   ELSE
   
      IFDEF TAR__crt_interrupt_mode
      
         defc __crt_interrupt_mode = TAR__crt_interrupt_mode
      
      ELSE
      
         defc __crt_interrupt_mode = DEF__crt_interrupt_mode
      
      ENDIF
      
   ENDIF


   IFDEF CRT_INTERRUPT_MODE_EXIT
   
      defc __crt_interrupt_mode_exit = CRT_INTERRUPT_MODE_EXIT
   
   ELSE
   
      IFDEF TAR__crt_interrupt_mode_exit
      
         defc __crt_interrupt_mode_exit = TAR__crt_interrupt_mode_exit
      
      ELSE
      
         defc __crt_interrupt_mode_exit = DEF__crt_interrupt_mode_exit
      
      ENDIF
      
   ENDIF

   
   IFDEF CRT_ENABLE_COMMANDLINE
   
      defc __crt_enable_commandline = CRT_ENABLE_COMMANDLINE
   
   ELSE
   
      IFDEF TAR__crt_enable_commandline
      
         defc __crt_enable_commandline = TAR__crt_enable_commandline
      
      ELSE
      
         defc __crt_enable_commandline = DEF__crt_enable_commandline
      
      ENDIF
   
   ENDIF


   IFDEF CRT_ENABLE_COMMANDLINE_EX
   
      defc __crt_enable_commandline_ex = CRT_ENABLE_COMMANDLINE_EX
   
   ELSE
   
      IFDEF TAR__crt_enable_commandline_ex
      
         defc __crt_enable_commandline_ex = TAR__crt_enable_commandline_ex
      
      ELSE
      
         defc __crt_enable_commandline_ex = DEF__crt_enable_commandline_ex
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CRT_ENABLE_RESTART
   
      defc __crt_enable_restart = CRT_ENABLE_RESTART
   
   ELSE
   
      IFDEF TAR__crt_enable_restart
      
         defc __crt_enable_restart = TAR__crt_enable_restart
      
      ELSE
      
         defc __crt_enable_restart = DEF__crt_enable_restart
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CRT_ENABLE_CLOSE
   
      defc __crt_enable_close = CRT_ENABLE_CLOSE
   
   ELSE
   
      IFDEF TAR__crt_enable_close
      
         defc __crt_enable_close = TAR__crt_enable_close
      
      ELSE
      
         defc __crt_enable_close = DEF__crt_enable_close
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CRT_ENABLE_EIDI
   
      defc __crt_enable_eidi = CRT_ENABLE_EIDI
      
   ELSE
   
      IFDEF TAR__crt_enable_eidi
      
         defc __crt_enable_eidi = TAR__crt_enable_eidi
      
      ELSE
      
         defc __crt_enable_eidi = DEF__crt_enable_eidi
         
      ENDIF
      
   ENDIF
   
   
   IF __crt_enable_restart
   
      defc __crt_on_exit = 0x10008
   
   ELSE
   
      IFDEF CRT_ON_EXIT
      
         defc __crt_on_exit = CRT_ON_EXIT
      
      ELSE
      
         IFDEF TAR__crt_on_exit
         
            defc __crt_on_exit = TAR__crt_on_exit
            
         ELSE
         
            defc __crt_on_exit = DEF__crt_on_exit
         
         ENDIF
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CLIB_EXIT_STACK_SIZE
   
      defc __clib_exit_stack_size = CLIB_EXIT_STACK_SIZE
   
   ELSE
   
      IFDEF TAR__clib_exit_stack_size
      
         defc __clib_exit_stack_size = TAR__clib_exit_stack_size
      
      ELSE
      
         defc __clib_exit_stack_size = DEF__clib_exit_stack_size
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CLIB_QUICKEXIT_STACK_SIZE
   
      defc __clib_quickexit_stack_size = CLIB_QUICKEXIT_STACK_SIZE

   ELSE
   
      IFDEF TAR__clib_quickexit_stack_size
      
         defc __clib_quickexit_stack_size = TAR__clib_quickexit_stack_size
      
      ELSE
      
         defc __clib_quickexit_stack_size = DEF__clib_quickexit_stack_size
      
      ENDIF
      
   ENDIF
   
   
   IFDEF CLIB_MALLOC_HEAP_SIZE
   
      defc __clib_malloc_heap_size = CLIB_MALLOC_HEAP_SIZE
   
   ELSE
   
      IFDEF TAR__clib_malloc_heap_size
      
         defc __clib_malloc_heap_size = TAR__clib_malloc_heap_size
      
      ELSE
      
         defc __clib_malloc_heap_size = DEF__clib_malloc_heap_size
      
      ENDIF

   ENDIF

   
   IFDEF CLIB_STDIO_HEAP_SIZE
   
      defc __clib_stdio_heap_size = CLIB_STDIO_HEAP_SIZE
   
   ELSE
   
      IFDEF TAR__clib_stdio_heap_size
      
         defc __clib_stdio_heap_size = TAR__clib_stdio_heap_size
      
      ELSE
      
         defc __clib_stdio_heap_size = DEF__clib_stdio_heap_size
   
      ENDIF
   
   ENDIF
   
   
   IFDEF CLIB_BALLOC_TABLE_SIZE
   
      defc __clib_balloc_table_size = CLIB_BALLOC_TABLE_SIZE
   
   ELSE
   
      IFDEF TAR__clib_balloc_table_size
      
         defc __clib_balloc_table_size = TAR__clib_balloc_table_size
      
      ELSE
      
         defc __clib_balloc_table_size = DEF__clib_balloc_table_size
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CLIB_FOPEN_MAX
   
      defc __clib_fopen_max = CLIB_FOPEN_MAX
   
   ELSE
   
      IFDEF TAR__clib_fopen_max
      
         defc __clib_fopen_max = TAR__clib_fopen_max
      
      ELSE
      
         defc __clib_fopen_max = DEF__clib_fopen_max
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CLIB_OPEN_MAX
   
      defc __clib_open_max = CLIB_OPEN_MAX

   ELSE
   
      IFDEF TAR__clib_open_max
      
         defc __clib_open_max = TAR__clib_open_max
      
      ELSE
      
         defc __clib_open_max = DEF__clib_open_max
      
      ENDIF
      
   ENDIF


   IFDEF CRT_ENABLE_RST
   
      defc __crt_enable_rst = CRT_ENABLE_RST
   
   ELSE
   
      IFDEF TAR__crt_enable_rst
      
         defc __crt_enable_rst = TAR__crt_enable_rst
      
      ELSE
      
         defc __crt_enable_rst = DEF__crt_enable_rst
      
      ENDIF
   
   ENDIF
   
   
   IFDEF CRT_ENABLE_NMI
   
      defc __crt_enable_nmi = CRT_ENABLE_NMI
   
   ELSE
   
      IFDEF TAR__crt_enable_nmi
      
         defc __crt_enable_nmi = TAR__crt_enable_nmi
      
      ELSE
      
         defc __crt_enable_nmi = DEF__crt_enable_nmi
      
      ENDIF
      
   ENDIF
   
   
   IFDEF CRT_ENABLE_TRAP
   
      defc __crt_enable_trap = CRT_ENABLE_TRAP
   
   ELSE
   
      IFDEF TAR__crt_enable_trap
      
         defc __crt_enable_trap = TAR__crt_enable_trap
      
      ELSE
      
         defc __crt_enable_trap = DEF__crt_enable_trap
      
      ENDIF
      
   ENDIF

IF __8085

   IFDEF CRT_ENABLE_INT55
   
      defc __crt_enable_int55 = CRT_ENABLE_INT55
   
   ELSE
   
      IFDEF TAR__crt_enable_int55
      
         defc __crt_enable_int55 = TAR__crt_enable_int55
      
      ELSE
      
         defc __crt_enable_int55 = DEF__crt_enable_int55
      
      ENDIF
      
   ENDIF
   
   
   IFDEF CRT_ENABLE_INT65
   
      defc __crt_enable_int65 = CRT_ENABLE_INT65
   
   ELSE
   
      IFDEF TAR__crt_enable_int65
      
         defc __crt_enable_int65 = TAR__crt_enable_int65
      
      ELSE
      
         defc __crt_enable_int65 = DEF__crt_enable_int65
      
      ENDIF
      
   ENDIF
   
   
   IFDEF CRT_ENABLE_INT65
   
      defc __crt_enable_int75 = CRT_ENABLE_INT65
   
   ELSE
   
      IFDEF TAR__crt_enable_int75
      
         defc __crt_enable_int75 = TAR__crt_enable_int75
      
      ELSE
      
         defc __crt_enable_int75 = DEF__crt_enable_int75
      
      ENDIF
      
   ENDIF
   
   
   IFDEF CRT_ENABLE_RST40H
   
      defc __crt_enable_rst40h = CRT_ENABLE_RST40H
   
   ELSE
   
      IFDEF TAR__crt_enable_rst40h
      
         defc __crt_enable_rst40h = TAR__crt_enable_rst40h
      
      ELSE
      
         defc __crt_enable_rst40h = DEF__crt_enable_rst40h
      
      ENDIF
      
   ENDIF

ENDIF

   ;; rules that must be processed by m4
   
   ifdef(`M4__CRT_INCLUDE_DRIVER_INSTANTIATION',,`define(`M4__CRT_INCLUDE_DRIVER_INSTANTIATION', 0)')

   IFNDEF __crt_include_driver_instantiation
      defc __crt_include_driver_instantiation = M4__CRT_INCLUDE_DRIVER_INSTANTIATION
   ENDIF

   ;; public definitions

   PUBLIC __clib_fopen_max
   PUBLIC __clib_open_max
   
   PUBLIC __exit_stack_size
   PUBLIC __quickexit_stack_size
   
   defc __exit_stack_size = __clib_exit_stack_size
   defc __quickexit_stack_size = __clib_quickexit_stack_size

   IF __Z180
   
      PUBLIC __IO_VECTOR_BASE
      
      IF __crt_io_vector_base < 0
      
         IF (__crt_org_vector_table < 0)
         
            IF (-__crt_org_vector_table) & 0x1f
            
               "Cannot place __IO_VECTOR_BASE at start of interrupt vector table"
            
            ELSE
            
               defc __IO_VECTOR_BASE = (-__crt_org_vector_table) & 0xe0
               
            ENDIF
         
         ELSE
         
            IF __crt_org_vector_table & 0x1f
            
               "Cannot place __IO_VECTOR_BASE at start of interrupt vector table"
            
            ELSE
            
               defc __IO_VECTOR_BASE = __crt_org_vector_table & 0xe0

            ENDIF
            
         ENDIF
      
      ELSE
      
         IF __crt_io_vector_base & 0x1f
         
            "Illegal __IO_VECTOR_BASE"
         
         ELSE

            defc __IO_VECTOR_BASE = __crt_io_vector_base & 0xe0
         
         ENDIF
      
      ENDIF
   
   ENDIF

;; end crt rules ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
