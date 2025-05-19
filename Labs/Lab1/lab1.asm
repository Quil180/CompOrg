.data
out: .asciiz "\nHello, Word!\n"
.text
li $v0, 4
la $a0, out
syscall
li $v0, 10
syscall