# Yousef Awad -- 06/08/2025
#
# part1a.asm
#
# A program that computes 
# the equations of F and G
# given the 4 user inputted
# variables. It then prints
# out both values in decimal
# and hexadecimal.
#
# Registers Used:
# $t0 - used to hold the first number
# $t1 - used to hold the second number
# $t2 - used to hold the third number
# $t3 - used to hold the fourth number
# $t4 - used to hold F
# $t5 - used to hold G
# $t6 - used to hold current loop counter
# $t7 - used to hold immediate for bge command
# $t8 - used to hold original value of multiplying number
#
# $v0 - syscall parameter and return value
# $a0 - syscall parameter (print value)

# For printing constant strings onto terminal
.data
intro: .asciiz "Enter 4 integers for A, B, C, D respectively:\n"
ften:  .asciiz "f_ten = "
ftwo:  .asciiz "f_two = "
gten:  .asciiz "g_ten = "
gtwo:  .asciiz "g_two = "
.text

main:

# Printing intro
li $v0, 4
la $a0, intro
syscall

# Getting A ($t0) from user
li $v0, 5 # 5 signifies read_int
syscall
move $t0, $v0

# Getting B ($t1) from user.
li $v0, 5
syscall
move $t1, $v0

# Getting C ($t2) from user.
li $v0, 5
syscall
move $t2, $v0

# Getting D ($t3) from user.
li $v0, 5
syscall
move $t3, $v0

# Computing F = 5*B*D + A
## computing B*D
li $t6, 0 # setting counter to 0
mulBD: bge $t6, $t3, mul5prep # if the counter is greater than D, go to label mul5prep
  # below is if not greater then
  add $t4, $t4, $t1 # add B to F
  addi $t6, $t6, 1 # add 1 to counter
  j mulBD # go back to "multiplying" B and D

mul5prep:
	## computing 5*(B*D)
	li $t6, 0 # setting counter to 0
	li $t7, 4 # setting secondary value to 5 for loop
	addi $t8, $t4, 0 # setting third value to t4 for easy math
	
mul5: bge $t6, $t7, exitmulF # if the counter is greater than 5, go to label exitmulF
  add $t4, $t4, $t8 # add on t4 to itself
  addi $t6, $t6, 1 # add 1 to counter
  j mul5
 
exitmulF:
# all multiplication was done
add $t4, $t4, $t0 # adding A to the current value of F


# Computing G = D*D - C*A
## computing D*D
li $t6, 0 # setting counter to 0
mulDD: bge $t6, $t3, mulsubprep # if counter > D, go to mulsubCA
  add $t5, $t5, $t3 # add D to G
  addi $t6, $t6, 1 # add 1 to counter
  j mulDD # loop back

mulsubprep:
li $t6, 0 # setting counter to 0
mulsubCA: bge $t6, $t0, printRes # if counter > A, go print results
  sub $t5, $t5, $t2 # subtracting C from D*D, A times
  addi $t6, $t6, 1 # add 1 to counter
  j mulsubCA # loop back to check if counter is greater


printRes:
# Printing text before F value
li $v0, 4
la $a0, ften
syscall
# Printing out F ($t4) in decimal
li $v0, 1
la $a0, ($t4)
syscall

# Printing newline
li $v0, 11
li $a0, 10
syscall
# Printing text before F value
li $v0, 4
la $a0, ftwo
syscall
# Printing out F ($t4) in binary
li $v0, 35
la $a0, ($t4)
syscall

# Printing newline
li $v0, 11
li $a0, 10
syscall

# Printing text before G value
li $v0, 4
la $a0, gten
syscall
# Printing out G ($t5) in decimal
li $v0, 1
la $a0, ($t5)
syscall

# Printing newline
li $v0, 11
li $a0, 10
syscall
# Printing text before G value
li $v0, 4
la $a0, gtwo
syscall
# Printing out G ($t5) in binary
li $v0, 35
la $a0, ($t5)
syscall

# Ending program
li $v0, 10
syscall
