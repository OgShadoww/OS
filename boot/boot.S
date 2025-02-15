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
lgdt [gdt_descriptor

mov eax, cr0        
or eax, 1             
mov cr0, eax 

jmp CODE_SEG:init_protected_mode

[BITS 32]
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

    