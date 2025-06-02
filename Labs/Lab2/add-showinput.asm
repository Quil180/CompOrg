# Yousef Awad -- 06/02/2025
#
# add-showinput.asm
#
# A program that computes 
# and prints the
# summation of three
# numbers specficied at
# runtime by the user.
#
# Program also shows 
# the user's inputted
# three numbers unlike
# add.asm
#
# Registers Used:
# $t0 - used to hold the first number
# $t1 - used to hold the second number
# $t2 - used to hold the third number
# $t3 - used to hold the sum
# $v0 - syscall parameter and return value
# $a0 - syscall parameter (print value)

.data
# holds user inputted string
plus: .asciiz "+"
equal: .asciiz "="
.text

main:

# Getting first number ($t0) from user
li $v0, 5 # 5 signifies read_int
syscall
move $t0, $v0

# Getting second number ($t1) from user.
li $v0, 5
syscall
move $t1, $v0

# Getting third number ($t2) from user.
li $v0, 5
syscall
move $t2, $v0

# Printing out user input
#
# Printing first number
li $v0, 1
la $a0, ($t0)
syscall
# Printing '+'
li $v0, 4
la $a0, plus
syscall
# Printing second number
li $v0, 1
la $a0, ($t1)
syscall
# Printing '+'
li $v0, 4
la $a0, plus
syscall
# Printing third number
li $v0, 1
la $a0, ($t2)
syscall
# Printing '='
li $v0, 4
la $a0, equal
syscall
# Printing newline
li $v0, 11
li $a0, 10
syscall

# Computing triple sum
add $t3, $t0, $t1
add $t3, $t2, $t3

# Printing out $t3 (sum)
li $v0, 1
la $a0, ($t3)
syscall

# Ending program
li $v0, 10
syscall