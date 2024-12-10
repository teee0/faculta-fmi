.section .note.GNU-stack,"",@progbits

.data
    doi: .long 2
    x: .space 4
    rez: .space 1
    format_scanf: .asciz "%d"
    format_neprim: .asciz "%d nu e prim"
    format_prim: .asciz "%d nu e prim"
    newLine: .asciz "\n"

.text
eprim:
    mov $2,%ecx
l:
    movl 4(%esp),%eax
    xorl %edx,%edx
    divl %ecx
    cmp $0,%edx
    je r0

    divl doi
    mov %eax, %ecx
    
    cmp $0,%ecx
    jne l
    movl $1, 8(%esp)
    jmp vai_exit
r0:
    movl $0, 8(%esp)
vai_exit:
    ret

.global main
main:
    pushl $x
    pushl $format_scanf
    call scanf
    popl %ebx
    popl %ebx


    pushl $rez
    pushl x
    call eprim
    popl %ebx
    popl %ebx

    cmp $1, %ebx
    je prim
    jmp neprim

prim:
    pushl $format_prim
neprim:
    pushl $format_neprim
    call printf
    popl %ebx
    popl %ebx

    pushl $newLine
    call printf
    popl %ebx

etexit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

