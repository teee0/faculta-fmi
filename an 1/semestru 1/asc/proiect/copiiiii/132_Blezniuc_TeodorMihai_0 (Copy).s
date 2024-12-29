.data
  extra: .byte 1

  v: .zero 1024
  x: .long 1
  #extra 
  enter: .asciz "\n"
  f_write_long: .asciz "%d\n"
  #extra input text
  text_nr: .asciz "Cate operatii : "
  text_t_op: .asciz "Tipul operatiei : "
  text_get: .asciz "get : " 
  text_add: .asciz "add : " 
  text_del: .asciz "del : "
  #formats
  f_read_long:.asciz "%d"
  f_read_byte: .asciz "%hhd"
  f_write_nofd: .asciz "(%d, %d)\n"
  f_write_fd: .asciz "%hhd: (%d, %d)\n"
  #constants
  size: .long 1024
  last_i: .long 1023
  #variables
  start: .long 0
  end: .long 0
  #read at runtime
  nr_op: .space 4
  t_op: .space 4
  
  descriptor: .space 1

.text
.global main

#misc

input:#(text,x)
#check if extra is on
  movl extra, %eax
  cmpl $0, %eax
  je basic_input
#print extra text if true
  pushl 4(%esp)
  call puts
  pop %ebx
basic_input:
  pushl 8(%esp)
  pushl $f_read_long
  call scanf
  popl %ebx
  popl %ebx

 ret


get_intern: #schimbi tu descriptor inainte ca mor
  movl $-1, start
  movl $-1, end
  
  movl $0, %ecx
  for_gi:
    cmpl size, %ecx
    je for_gi_exit
    #for body
    #pushl %ecx
    #pushl %ecx
    #pushl $f_write_long
    #call printf
    #popl %ebx
    #popl %ebx
    #popl %ecx
    
    #vezi ca dupa ce am comentat asta merge ori e problema accesarea ori loopu ori ambele
    movb (%edi,%ecx,1), %ah
    cmpb %ah, descriptor    
    jne for_gi_post
    
    cmpl $-1, start
    jne start_deja_gasit
    movl %ecx, start
    start_deja_gasit:
    movl %ecx, end
    
    for_gi_post:
    inc %ecx
    jmp for_gi
  for_gi_exit:  
  ret
get:
  pushl $descriptor
  pushl $f_read_byte
  call scanf
  popl %ebx
  popl %ebx
  
  pushl $descriptor
  call get_intern
  popl %ebx
  
  pushl end
  pushl start
  pushl $f_write_nofd
  call printf
  pop %ebx
  pop %ebx
  pop %ebx
  
  ret

get0:
  ret
add_intern:
  ret
add:
  ret



citeste_nr_op:
  pushl $nr_op
  pushl $text_nr
  call input
  popl %ebx
  popl %ebx
  ret

citeste_t_op:
  pushl $t_op
  pushl $text_t_op
  call input
  popl %ebx
  popl %ebx
  ret

main:
  lea v, %edi
  call citeste_nr_op

  movl nr_op, %ecx

  for_main: #for _ in range(nr_op-1, 0, -1)
  pushl %ecx

  call citeste_t_op
  s1:
    cmpl $1, t_op
    jne s2
    call add
    jmp s_exit
  s2:
    cmpl $2, t_op
    jne s3
    call get
    jmp s_exit
  s3:
#    cmpl $3, t_op
#    jne s4
#    call del
#    jmp s_exit
  s4:
#    cmpl $4, t_op
#    jne s_exit
#    call defrag
  s_exit:

  pop %ecx
  loop for_main
#end_for

exit:
  pushl $0
  call fflush
  popl %eax

  mov $1, %eax
  mov $0, %ebx
  int $0x80
