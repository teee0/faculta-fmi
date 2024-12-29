.data
  extra: .byte 0

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
  f_read_byte: .asciz "%hhu"
  f_write_nofd: .asciz "(%d, %d)\n"
  f_write_fd: .asciz "%hhu: (%d, %d)\n"
  #constants
  size: .long 1024
  last_i: .long 1023
  #variabile-returnabile
  start: .long 0
  end: .long 0
  #read at runtime
  nr_op: .space 4
  t_op: .space 4
  nr_add: .space 4
  
  descriptor: .space 1
	dimensiune: .space 4
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
    
    movb (%edi,%ecx,1), %ah
    cmpb %ah, descriptor    
    jne for_gi_post
    
    cmpl $-1, start
    jne for_gi_deja_gasit
    movl %ecx, start
    for_gi_deja_gasit:
    movl %ecx, end
    
    for_gi_post:
    inc %ecx
    jmp for_gi
  for_gi_exit:    
  cmpl $-1, start
  jne gi_exit
  movl $0,start
  movl $0,end
  gi_exit:
  ret
get:
  pushl $descriptor
  pushl $f_read_byte
  call scanf
  popl %ebx
  popl %ebx
  
  #pushl $descriptor
  call get_intern
  #popl %ebx
  
  pushl end
  pushl start
  pushl $f_write_nofd
  call printf
  pop %ebx
  pop %ebx
  pop %ebx
  
  ret

abstractizeaza:
  movl dimensiune, %eax
  movl $8, %ebx
  xorl %edx, %edx
  
  sub $1, %eax
  div %ebx
  add $1, %eax
  movl %eax, dimensiune
  ret
  
ask:
  movl $-1, start
  movl $-1, end
  
  movl $0, %ecx
  for_ask:
    cmpl size, %ecx
    je for_ask_exit
    #for body
    
    cmpb $0, (%edi,%ecx,1)
    jne if_vi_non0
    
    if_vi_0:
		  cmpl $-1, start
		  jne for_ask_deja_gasit
		  movl %ecx, start
		  for_ask_deja_gasit:
		  movl %ecx, end
    jmp for_ask_post
    
    if_vi_non0:
    	cmpl $-1, start
    	je for_ask_post
    	#spatiu=end-start+1
    	movl end, %eax
    	sub start, %eax
    	add $1, %eax
    		
    	#if minim<=spatiu (optimizare)
    	cmp %eax, 4(%esp)
    	jle ask_exit
    	movl $-1, start
    	movl $-1, end
    for_ask_post:
    inc %ecx
    jmp for_ask
  for_ask_exit:  

	#if minim <= spatiu
	
	movl end, %eax
	sub start, %eax
	add $1, %eax
    	
	cmp %eax, 4(%esp)
  jle ask_exit
  movl $0, start
  movl $0, end
  ask_exit:

  ret
  
add_intern:
  pushl dimensiune
	call ask
	pop %ebx
	
	cmpl $0, end
	je ai_exit
	
	#daca se ajuge aici incape
	#daca nu start==0 si end==0
	
	movl start, %eax#ce kkt
	add dimensiune, %eax
	sub $1, %eax
	movl %eax, end#vezi asta
	
	movl start, %ecx
	for_ai:
    movb descriptor, %al
    movb %al, (%edi,%ecx,1)
    
    cmpl end, %ecx
    je for_ai_exit
    
    inc %ecx
    jmp for_ai
  for_ai_exit:    
	
	ai_exit:
  ret

add:
	pushl $nr_add
	pushl $f_read_long
	call scanf
	popl %ebx
	popl %ebx
	
	movl $0, %ecx
  for_a:
    cmpl %ecx, nr_add
    je for_a_exit
  	pushl %ecx
  
		pushl $descriptor
		pushl $f_read_byte
		call scanf
		popl %ebx
		popl %ebx
		
		pushl $dimensiune
		pushl $f_read_long
		call scanf
		popl %ebx
		popl %ebx
		
		call abstractizeaza
		
		#pushl $dimensiune
		#pushl $descriptor
		call add_intern
		#pop %ebx
		#pop %ebx
		
		pushl end
		pushl start
		pushl descriptor
		pushl $f_write_fd
		call printf
		pop %ebx
		pop %ebx
		pop %ebx
		pop %ebx
  
  	pop %ecx
  	inc %ecx
  	jmp for_a
  for_a_exit:
  ret



citeste_nr_op:
  pushl $nr_op
  pushl $f_read_long
  call scanf
  popl %ebx
  popl %ebx
  ret

citeste_t_op:
  pushl $t_op
  pushl $f_read_long
  call scanf
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
