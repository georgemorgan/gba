.section	".init"

.align

.arm

header:		b multiboot

			.fill 0x9C, 0x01, 0x00	@ Nintendo Logo Character Data

			.fill 0x10, 0x01, 0x00	@ Game Title

			.byte 0x30, 0x31		@ Maker Code

			.byte 0x96				@ Fixed Value

			.byte 0x00				@ Main Unit Code

			.byte 0x00				@ Device Type

			.fill 0x07, 0x01, 0x00	@ Unused

			.byte 0x00				@ Software Version Number

			.byte 0xF0				@ Complement Check

			.byte 0x00, 0x00		@ Checksum

multiboot:	b start

			.byte 0x00				@ Boot Method (0 = ROM boot, 3 = Multiplay)

			.byte 0x00				@ Slave Number

			.byte 0x00				@ Reserved

			.byte 0x00				@ Reserved

			.word 0x00				@ Reserved

			.word 0x00				@ Reserved

			.word 0x00				@ Reserved

			.word 0x00				@ Reserved

			.word 0x00				@ Reserved

			.word 0x00				@ Reserved

.section	".text"

.global start

.align

.equ REGBASE, 0x4000000

.equ DISPCNT, 0x4000000

.equ VRAM_ADDR, 0x6000000

start:

			mov r0, #REGBASE

			str r0, [r0, #0x208]

			/* Put the ARM processor into IRQ mode. */

			mov	r0, #0x12

			msr	cpsr, r0

			/* Set up the IRQ stack. */

			ldr	sp, =__sp_irq__

			/* Put the ARM processor into System mode. */

			mov r0, #0x1F

			msr cpsr, r0

			/* Set up the user stack. */

			ldr	sp, =__sp_user__

			/* Configure the display. */

			mov r0, #DISPCNT  /* r0 now contains the base address for the LCD control register. The register is 16 bits wide. */

			ldr r1, =#0x403 /* r1 now contains the hexadecimal value 0x403. This will enable the display controller and turn on BG 2. */

			strh r1, [r0] /* Load the contents of r1 into the register pointed to by the address held in r0. */

			mov r0, #VRAM_ADDR /* r0 now contains the base address of video RAM. */

loop1:		mov r1, #0x00 /* r1 now contains the hexadecimal value 0x20, or a red pixel. */

			and r2, #0

			and r4, #0

			and r5, #0

			mov r6, #160

loop2:		str r1, [r4] /* The address in video memory is set to the contents of r1 and the pointer incremented by two bytes. */

			add r4, r2

			mov r5, r3

			mul r5, r6

			add r1, #2

			add r2, #1

			cmp r2, #240

			bne loop2

loop3:		and r2, #0

			add r3, #1

			b loop2

			b loop1

stop:		b stop

			.fill 161, 0x01, 0x00

