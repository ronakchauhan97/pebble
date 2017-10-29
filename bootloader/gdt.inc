gdt_start:

null_descriptor:
	dd 0, 0

; code descriptor for the kernel
kernel_code:
	.limit_low:		dw 0xffff
	.base_low:		dw 0 
	.base_mid:		db 0
	.access:		db 10011010b
	.flags__lim_hi:	db 11001111b
	.base_high:		db 0

; data descriptor for the kernel
kernel_data:
	.limit_low:		dw 0xffff
	.base_low:		dw 0
	.base_mid:		db 0
	.access:		db 10010010b
	.flags__lim_hi:	db 11001111b
	.base_high:		db 0

gdt_end:

gdtr_value:
	.limit:		dw (gdt_end - gdt_start - 1)
	.base:		dd gdt_start

; selectors for kernel code & data segments
K_CODE_SEG equ kernel_code - gdt_start
K_DATA_SEG equ kernel_data - gdt_start