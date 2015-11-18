.phony: all gba boot clean

output = raw

cc = $(shell which 'arm-elf-gcc')

nm = $(shell which 'arm-elf-nm')

objcopy = $(shell which 'arm-elf-objcopy')

gbafix = $(DEVKITPRO)/arm/bin/gbafix

xxd = $(shell which 'xxd')

size = $(shell which 'arm-elf-size')

usbgba = $(shell which 'usbgba')

files = $(shell find . -name '*.c' -o -name '*.s')

ldfiles = $(shell find . -name '*.ld')

cflags = -std=c99 -O3 -mcpu=arm7tdmi -mtune=arm7tdmi -fomit-frame-pointer -ffast-math -nostartfiles -nostdlib -ffreestanding

ldflags = $(foreach ldfile, $(ldfiles),-Wl,-T $(ldfile))

all: gba

gba:

	$(cc) $(cflags) $(ldflags) $(files) -o $(output).elf

	$(nm) $(output).elf

	$(objcopy) -O binary $(output).elf $(output).gba

	$(gbafix) $(output).gba -t $(output) -c $(output)

	$(xxd) $(output).gba

	$(size) $(output).elf

boot: gba

	$(usbgba) $(output).gba

clean:

	rm -rf *.o *.elf *.gba