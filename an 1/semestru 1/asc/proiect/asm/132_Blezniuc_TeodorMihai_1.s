.data
  v: .zero 1048576
  #extra 
  counter: .long 1
  
  enter: .asciz "\n"
  f_write_long: .asciz "%d\n"
  f_pv: .asciz "%hhu "
  #formats
  f_read_long:.asciz "%d"
  f_read_byte: .asciz "%hhu"
  f_write_fd: .asciz "%hhu: ((%d, %d), (%d, %d))\n"
  f_write_nofd: .asciz "((%d, %d), (%d, %d))\n"
  #constants
  full_size: .long 1048576
  line_size: .long 1024
  last_i: .long 1023
  bzero: .zero 1 #vezi 
  #variabile-returnabile
  start: .long 0
  end: .long 0
  linie: .long 0
  #atrocitate pe pamant
  fd_curent: .byte 0
  prim_gol: .space 4
  #read at runtime
  nr_op: .space 4
  t_op: .space 4
  nr_add: .space 4
  
  descriptor: .space 1
	dimensiune: .space 4
.text
.global main

# misc
calc_index:#in eax
	movl line_size, %eax
	mull linie
	add %ecx, %eax
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
# PRINT

print_vector:
  movl counter,%ebp
  pushl %ebp
	movl linie, %esi
	pushl %esi
	
  movl $0, linie
  for_linii_pv:
    movl linie, %edx 
    cmpl %edx, line_size
		je for_linii_pv_exit
		movl $1, %ebx #lo and behold folosesc ebx ca bool
		movl $0, %ecx
		for_pv:
			cmp %ecx, line_size
			je for_pv_exit
			
			call calc_index
			
			cmpb $0, (%edi,%eax,1)
			je pv_0
			movl $0, %ebx
			pv_0:
		
			pushl %ebx
			pushl %ecx
				
			pushl (%edi,%eax,1)
			pushl $f_pv
			call printf
			pop %ebx
			pop %ebx
			
			pop %ecx
			pop %ebx
			
			inc %ecx
			jmp for_pv
		for_pv_exit:
		push %ebx
		
		push $enter
  	call puts
 		pop %ebx

 		pop %ebx
		
		cmp $0, %ebx
		je nui_gol_pv 
		dec counter
		nui_gol_pv:
		
		cmp $0, counter
		je for_linii_pv_exit
		
		incl linie
		jmp for_linii_pv
	for_linii_pv_exit:
	pop %esi
  movl %esi, linie
  pop %ebp
  movl %ebp, counter
  ret

print_fd:
  pushl %eax
  pushl %edx
	pushl %ecx

	pushl end
	pushl linie
	pushl start
	pushl linie
	pushl descriptor
	pushl $f_write_fd
	call printf
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	
	pop %ecx
	pop %edx
	pop %eax
	#daca mai faci mvals registrii tre sa i salvezi aci
	ret
	
print_nofd:
  pushl %eax
  pushl %edx
	pushl %ecx

	pushl end
	pushl linie
	pushl start
	pushl linie
	pushl $f_write_nofd
	call printf
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	
	pop %ecx
	pop %edx
	pop %eax
	#daca mai faci mvals registrii tre sa i salvezi aci
	ret
	
print_mem:
	movb descriptor, %bl
	pushl %ebx
	
	movl $0, linie
	for_lpm:
		movl linie, %edx
		cmpl %edx, line_size
		je pm_exit
	
		movb $0, descriptor
		movl $-1, start
		
		movl $0, %ecx
		for_pm:
		cmp %ecx, line_size
		je for_pm_exit
		
		call calc_index
		movb (%edi,%eax,1), %dl
		
		cmpb $0, %dl
		jne if_pm_vi_non0
		cmpl $-1, start
		je if_pm_exit
			call print_fd	
			movl $-1, start
			
		jmp if_pm_exit
		if_pm_vi_non0:
		
		cmpl $-1, start
		jne if_pm_start_gasit
			movl %ecx, start
			movl %ecx, end
			movb %dl, descriptor
		jmp if_pm_exit
		if_pm_start_gasit:
				cmpb %dl, descriptor
				jne if_pm_vi_prost
					movl %ecx, end
				jmp if_pm_exit
				if_pm_vi_prost:
					call print_fd
					
					movl %ecx, start
					movl %ecx , end
					movb %dl, descriptor
		if_pm_exit:
		
		inc %ecx
		jmp for_pm
		for_pm_exit:
		
		movl end, %edx
		cmpl last_i, %edx
		jne vaide
		cmpl $-1, start
		je vaide
			call print_fd
		
		vaide:
		incl linie
		jmp for_lpm
		
  pm_exit:
	pop %ebx
	movb %bl, descriptor
	
	ret
# GET

get_intern_linie: #schimbi tu descriptor inainte
  movl $-1, start
  movl $-1, end
  
  movl $0, %ecx

  
  for_gil:
    cmpl line_size, %ecx
    je for_gil_exit
    #for body
    call calc_index
    movb (%edi,%eax,1), %dl
    cmpb %dl, descriptor    
    jne for_gil_post
    
    cmpl $-1, start
    jne for_gil_deja_gasit
    movl %ecx, start
    for_gil_deja_gasit:
    movl %ecx, end
    
    for_gil_post:
    inc %ecx
    jmp for_gil
  for_gil_exit:    
  cmpl $-1, start
  jne gil_exit
  movl $0,start
  movl $0,end
  gil_exit:
  ret
get_intern:
	movl $0, linie
	for_gi:
		movl linie, %edx
		cmpl %edx, line_size
		je for_gi_exit
		
		call get_intern_linie
		cmpl $0, end
		jne gi_exit
		
		incl linie
		jmp for_gi
	for_gi_exit:
	movl $0, linie
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
  
  call print_nofd


# ADD

ask_linie:
  movl $-1, start
  movl $-1, end
  
  movl $0, %ecx

  for_ask:
    cmpl line_size, %ecx
    je for_ask_exit
    #for body
   	call calc_index
    cmpb $0, (%edi,%eax,1)
    jne if_ask_vi_non0
    
		  cmpl $-1, start
		  jne for_ask_deja_gasit
		  movl %ecx, start
		  for_ask_deja_gasit:
		  movl %ecx, end
    jmp for_ask_post
    
    if_ask_vi_non0:
    	cmpl $-1, start
    	je for_ask_post
    	#spatiu=end-start+1
    	movl end, %edx
    	sub start, %edx
    	add $1, %edx
    		
    	#if minim<=spatiu (optimizare)
    	cmp %edx, 4(%esp)
    	jle ask_exit
    	movl $-1, start
    	movl $-1, end
    for_ask_post:
    inc %ecx
    jmp for_ask
  for_ask_exit:  

	#if minim <= spatiu
	
	movl end, %edx
	sub start, %edx
	add $1, %edx
  
  cmpl $-1, start
  je nui_bun
	cmp %edx, 4(%esp)
  jle ask_exit
  
  nui_bun:
  movl $0, start
  movl $0, end
  
  ask_exit:
  ret
  
put:
	movl 4(%esp), %edx
  movl (%edx), %edx
  movb %dl, fd_curent #don t ask lol
  #dc nu vrea sa citeasca parametru calumea

  movl start, %ecx
	for_p:
	  call calc_index
	  
    movb fd_curent, %dl
    movb %dl, (%edi,%eax,1)
    
    cmpl end, %ecx
    je for_p_exit
    
    inc %ecx
    jmp for_p
  for_p_exit:   
  ret

add_intern_linie:
  pushl dimensiune
	call ask_linie
	pop %ebx
	
	cmpl $0, end
	je ail_exit
	
	#end = start+dimensiune-1
	movl start, %eax
	add dimensiune, %eax
	sub $1, %eax
	movl %eax, end
	
	push $descriptor
	call put
	pop %ebx
	
	ail_exit:
  ret
add_intern:
	movl $0, linie
	for_ai:
		movl linie, %edx
		cmpl %edx, line_size
		je for_ai_exit
		
		call add_intern_linie
		cmpl $0, end
		jne ai_exit
		
		incl linie
		jmp for_ai
	for_ai_exit:
	movl $0, linie
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
		
		call print_fd
		
  
  	pop %ecx
  	inc %ecx
  	jmp for_a
  for_a_exit:
  ret

# DEL

del_intern:
  #pushl $descriptor
  call get_intern
  #popl %ebx
  
  cmpl $0, end
  je di_exit
		pushl $bzero#vezi
		call put
		pop %ebx
  
  di_exit:
  ret

del:
  pushl $descriptor
  pushl $f_read_byte
  call scanf
  popl %ebx
  popl %ebx
  
  #pushl descriptor
  call del_intern 
  #pop %ebx
  
  call print_mem
  
  ret


# MAIN

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

  for_main:
  
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
    cmpl $3, t_op
    jne s4
    call del
    jmp s_exit
  s4:
    cmpl $4, t_op
    #jne s_exit
    #call defrag
  s_exit:
  
  #call print_vector
  
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
