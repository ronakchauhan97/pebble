; register setup for load_sectors
; dh = head, 0 based count
; dl = drive type as per the drive table
; ch = cylinder, 0 based count
; cl = start reading from 'cl'th sector, 1 based count 
; al = no. of sectors to load to memory
; sectors will be read to es:bx

load_sectors:
	; cf = 0 : success
	; cf = 1 : error

	pusha
	mov ah, 0x02	; read mode for int 0x13
	int 0x13

	mov ah, 0x0e
	jnc .read_success

	.read_error:
		mov al, 'E'
		int 0x10
		jmp $
	
	.read_success:
		mov al, 'S'
		int 0x10

	popa
	ret