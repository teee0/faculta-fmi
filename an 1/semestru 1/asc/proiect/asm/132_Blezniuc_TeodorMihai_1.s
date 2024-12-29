.data
  format_intervale: .asciz "%d: ((%d, %d),(%d, %d))\n"
.text
.global main
main:


exit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
