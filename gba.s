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

.arm

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

            bl main

stop:		b stop

			.fill 161, 0x01, 0x00

