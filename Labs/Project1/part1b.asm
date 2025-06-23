# Yousef Awad -- 06/16/2025
#
# part1b.asm
#
# A program that computes 
# the equations of F and 
# G as well as now a new
# equations of H and I
# given the 4 user inputted
# variables from part A.
# It then prints out their 
# values in decimal.
#
# Registers Used:
# $t0 - used to hold the first number, and later on H's remainder
# $t1 - used to hold the second number, and later on I's value
# $t2 - used to hold the third number, and later on H's value
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
gten:  .asciiz "g_ten = "
hquot: .asciiz "h_quotient = "
hrem:  .asciiz "h_remainder = "
imod:  .asciiz "i_mod = "
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
mulsubCA: bge $t6, $t0, doneA # if counter > A, go print results
  sub $t5, $t5, $t2 # subtracting C from D*D, A times
  addi $t6, $t6, 1 # add 1 to counter
  j mulsubCA # loop back to check if counter is greater




doneA:
# Computing H = f+2 / g-2
li $t6, 0 # counter = 0
addi $t0, $t4, 2 # using $t0 for temp value to store ften+2
subi $t1, $t5, 2 # using $t1 for temp value to store gten-2

# doing the division
divFG: bgt $t1, $t0, donDiv
	sub $t0, $t0, $t1
	addi $t6, $t6, 1
	j divFG

donDiv:
# whatever is left in t0 is the remainder, while counter is the division count
move $t2, $t6 # $t2 will now signify the quotient for H

# now to calculate I = ften-25 % hrem (of which is $t2)
sub $t1, $t4, 25 # using $t1 to store ften-25
li $t6, 0 # counter = 0
modI: bgt $t0, $t1, printRes # if the remainder of h is greater than the current value, jump
	sub $t1, $t1, $t0
	addi $t6, $t6, 1
	j modI


printRes:
# Printing newline
li $v0, 11
li $a0, 10
syscall

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
# Printing newline
li $v0, 11
li $a0, 10
syscall

# Printing text before H value
li $v0, 4
la $a0, hquot
syscall
# Printing out H ($t2) in decimal
li $v0, 1
la $a0, ($t2)
syscall

# Printing newline
li $v0, 11
li $a0, 10
syscall
# Printing newline
li $v0, 11
li $a0, 10
syscall

# Printing text before H's remainder value
li $v0, 4
la $a0, hrem
syscall
# Printing it out ($t0) in decimal
li $v0, 1
la $a0, ($t0)
syscall

# Printing newline
li $v0, 11
li $a0, 10
syscall
# Printing newline
li $v0, 11
li $a0, 10
syscall

# Printing text before I value
li $v0, 4
la $a0, imod
syscall
# Printing it out ($t6) in decimal
li $v0, 1
la $a0, ($t1)
syscall


# Ending program
li $v0, 10
syscall
