.data
  v: .zero 1048576
  #extra 
  enter: .asciz "\n"
  f_write_long: .asciz "%d\n"
  f_pv: .asciz "%hhu "
  counter: .long 1
  #formats
  f_read_long:.asciz "%d"
  f_read_byte: .asciz "%hhu"
  f_write_fd: .asciz "%hhu: ((%d, %d),(%d, %d))\n"
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

#misc

print_vector:
	#in %esi e linie
  movl $0, %esi
  for_linii_pv:
    cmp %esi, line_size
		je for_linii_pv_exit
		movl $0, %ecx
		for_pv:
			cmp %ecx, line_size
			je for_pv_exit
			
			pushl %ecx
			pushl %esi
			
			movl %ecx,%eax
			mul %esi
			pushl (%edi,%eax,1)
			pushl $f_pv
			call printf
			pop %ebx
			pop %ebx
			
			pop %esi
			pop %ecx
			
			inc %ecx
			jmp for_pv
		for_pv_exit:
		push $enter
  	call puts
 		pop %ebx
		inc %esi
		jmp for_linii_pv
	for_linii_pv_exit:
 
  ret

print_fd:
  pushl %eax
	pushl %ecx

	pushl end
	pushl linie
	pushl start
	pushl linie
	pushl fd_curent
	pushl $f_write_fd
	call printf
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	
	pop %ecx
	pop %eax
	#daca mai faci mvals registrii tre sa i salvezi aci
	ret


main:


exit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
