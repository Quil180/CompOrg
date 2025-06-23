# Yousef Awad -- 06/23/2025
#
# strlen.asm
#
# A program that computes 
# the length of a string
# similar to the strlen
# found in the C stdlib
#
# Registers Used:
# $t0 - used to hold the loop counter
# $a0 - used to hold the address of the string
# $v0 - syscall parameter and return value

.data
string: .asciiz "This is a sample, find the length of this interesting and null terminating string!"
.text


main:


la $a0, string # string* = string
li $t0, 0 # counter = 0

loop:
lb $t1, 0($a0) # loading next character into t1
beqz $t1, exit # if null, exit

addi $t0, $t0, 1 # counter += 1
addi $a0, $a0, 1 # move string pointer up one
j loop



exit:
# printing amount of characters
li $v0, 1
move $a0, $t0
syscall

# Ending program succesfully
li $v0, 10
syscall
