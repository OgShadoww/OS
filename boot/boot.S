[BITS 16]
[ORG 0x7C00]

mov ah, 0x0E          
mov al, 'B'          
int 0x10            
mov al, 'o'
int 0x10
mov al, 'o'
int 0x10
mov al, 't'
int 0x10
mov al, 'i'
int 0x10
mov al, 'n'
int 0x10
mov al, 'g'
int 0x10
mov al, ' '
int 0x10
mov al, 'O'
int 0x10
mov al, 'S'
int 0x10
mov al, '.'
int 0x10

cli
lgdt [gdt_descriptor]

mov eax, cr0        
or eax, 1             
mov cr0, eax 

jmp CODE_SEG:init_protected_mode

[BITS 32]
init_protected_mode:
    mov ax, DATA_SEG     ; 7️⃣ Data segment
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov esp, 0x90000     ; stack

    ; ====== output "Protected Mode!" vue VGA (0xB8000) ======
    mov edi, 0xB8000     ; VGA memory
    mov al, 'P'
    mov ah, 0x07         ; white text
    stosw
    mov al, 'r'
    stosw
    mov al, 'o'
    stosw
    mov al, 't'
    stosw
    mov al, 'e'
    stosw
    mov al, 'c'
    stosw
    mov al, 't'
    stosw
    mov al, 'e'
    stosw
    mov al, 'd'
    stosw
    mov al, ' '
    stosw
    mov al, 'M'
    stosw
    mov al, 'o'
    stosw
    mov al, 'd'
    stosw
    mov al, 'e'
    stosw
    mov al, '!'
    stosw


    call load_kernel

    jmp $ 

load_kernel:
    mov ebx, kernel_start 
    call ebx               
    ret

; ======== GDT (Global Descriptor Table) ========
gdt_start:
    dq 0                        
gdt_code:
    dw 0xFFFF, 0x0000, 0x9A, 0xCF  
gdt_data:
    dw 0xFFFF, 0x0000, 0x92, 0xCF 

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

kernel_start equ 0x100000  

times 510-($-$$) db 0     
dw 0xAA55