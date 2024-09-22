/* Memory areas */
MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 64K
    RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 20K
}

/* Entry point */
ENTRY(Reset_Handler)

/* Sections */
SECTIONS
{
    .text : {
        KEEP(*(.isr_vector)) /* Interrupt vector table */
        *(.text*)            /* Code */
        *(.rodata*)          /* Read-only data */
        _etext = .;          /* End of text */
    } > FLASH

    .data : AT(_etext) {
        _sdata = .;
        *(.data*)            /* Initialized data */
        _edata = .;
    } > RAM

    .bss : {
        _sbss = .;
        *(.bss*)             /* Uninitialized data */
        _ebss = .;
    } > RAM
}
