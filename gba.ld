OUTPUT_FORMAT("elf32-littlearm")

OUTPUT_ARCH(arm)

MEMORY {

	ROM : ORIGIN = 0x08000000, LENGTH = 32M

	INTRAM : ORIGIN = 0x03000000, LENGTH = 32K

	EXTRAM : ORIGIN = 0x02000000, LENGTH = 256K

}

__text_start__ = ORIGIN(EXTRAM);

__intram_top__ = ORIGIN(INTRAM);

__sp_irq__	=	__intram_top__ - 0x60;

__sp_user__	=	__sp_irq__ - 0xA0;

SECTIONS {

	. = __text_start__;

	.init : { * (.init); . = ALIGN(4); } > EXTRAM = 0xFF

	.text ALIGN (4) : { * (.text); . = ALIGN(4); } > EXTRAM = 0xFF

	__text_end = .;

	.rodata : { * (.rodata); }  > EXTRAM = 0xFF

}