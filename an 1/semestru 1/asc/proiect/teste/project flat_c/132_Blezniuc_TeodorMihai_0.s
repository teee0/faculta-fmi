.data

.text
.global main

ask:
  ret
put:
  ret
add:
  ret
get:
  ret
del:
  ret
defrag:
  ret
main:

exit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
