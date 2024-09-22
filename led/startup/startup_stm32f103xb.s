    .section .isr_vector,"a",%progbits
    .type    g_pfnVectors, %object
    .size    g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
    .word   _estack                        /* Top of stack */
    .word   Reset_Handler                  /* Reset Handler */
    .word   NMI_Handler                    /* NMI Handler */
    .word   HardFault_Handler              /* Hard Fault Handler */

    /* More exception handlers can go here if necessary */

    .section .text.Reset_Handler
Reset_Handler:
    /* Copy .data section from Flash to RAM */
    ldr   r0, =_sdata
    ldr   r1, =_edata
    ldr   r2, =_etext
    bl    memcpy

    /* Zero fill the .bss section */
    ldr   r0, =_sbss
    ldr   r1, =_ebss
    mov   r2, #0
    bl    memset

    /* Call main() */
    bl     main

    /* Loop forever */
    b      .
