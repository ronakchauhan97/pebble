CFLAGS = -m32 -ffreestanding
LDFLAGS = -m elf_i386 -s --oformat binary -Ttext 0x7c00
ASMFLAGS = -f elf32

kernel.bin: kernel.o bootloader/bootsector.asm bootloader/gdt.inc
	nasm $(ASMFLAGS) bootloader/bootsector.asm -o bootloader.o
	ld $(LDFLAGS) bootloader.o kernel.o -o kernel.bin

kernel.o: kernel/kernel.c
	gcc $(CFLAGS) -c kernel/kernel.c

.PHONY: clean
clean:
	rm -f *.o
	rm -f kernel.bin
	
.PHONY: qemu
qemu:
	qemu-system-x86_64 -drive format=raw,file=kernel.bin