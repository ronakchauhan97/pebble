ORG 0x7c00
BITS 16

segment .text

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
	mov ebp, 0x8000
	mov esp, 0x8000


pmode:
	; testing protected mode
	mov edx, VID_MEM
	mov ah, 0x0f		; select color white on black
	mov al, 'A'
	mov word [edx], ax

	jmp $


%pathsearch gdt "gdt.inc"
%include "bootloader/gdt.inc"

VID_MEM equ 0xb8000
times 510 - ($-$$) db 0
dw 0xaa55