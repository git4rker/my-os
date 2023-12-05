MBALIGN  equ  1 << 0 
MEMINFO  equ  1 << 1
MBFLAGS  equ  MBALIGN | MEMINFO 
MAGIC    equ  0x1BADB002
CHECKSUM equ -(MAGIC + MBFLAGS)

section .multiboot
align 4
	dd MAGIC
	dd MBFLAGS
	dd CHECKSUM

section .bss
align 16
stack_bottom:
resb 16384 ; 16 KiB
stack_top:

section .text
global _start:function (_start.end - _start)

gdt:
gdt_null:
	dq 0

gdt_code:
	dw 0FFFFh
	dw 0
	db 0
	db 10011010b
	db 11001111b
	db 0

gdt_data:
	dw 0FFFFh
	dw 0
	db 0
	db 10010010b
	db 11001111b
	db 0
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt - 1
    dd gdt

enterPM:
	cli
	lgdt [gdt_descriptor]

	mov eax, cr0
	or eax, 0x1 ; 3. set 32-bit mode bit in cr0
	mov cr0, eax

	mov	ax, 0x10
	mov	ds, ax
	mov	es, ax
	mov	fs, ax
	mov	gs, ax
	mov	ss, ax
	jmp	0x08:.flush
.flush:
	ret

_start:
	mov esp, stack_top

	call enterPM

	extern kernel_main
	call kernel_main

	cli
.hang:	hlt
	jmp .hang
.end: