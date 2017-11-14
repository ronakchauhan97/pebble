[BITS 16]

section .text

extern k_main

init_rmode:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax


; enabling the A20 gate using BIOS interrupt 15h, may not work with all BIOSes
enable_A20:
	mov ax, 0x2401
	int 0x15

; loading the kernel into memory
disk_load:
	mov dl, 0x80	; 1st HDD
	xor dh, dh		; head 0
	mov ch, 0		; cylinder 0
	mov cl, 0x02	; start reading from 2nd sector 
	mov al, 0x01	; #sectors to load - this value is hardcoded as of now & varies as per size of the final binary
	mov bx, 0x7e00
	call load_sectors


; switching to protected mode
switch_pm:
	cli
	lgdt [gdtr_value]
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
	jmp K_CODE_SEG:init_pmode


BITS 32
init_pmode:
	mov ax, K_DATA_SEG
	mov ds, ax
	mov es, ax
	mov ss, ax

	; initialize stack base and top
	mov ebp, 0x1000000
	mov esp, 0x1000000

pmode:
	call k_main ; jump to the kernel

%include "bootloader/gdt.inc"
%include "bootloader/disk.inc"

times 510 - ($-$$) db 0
dw 0xaa55