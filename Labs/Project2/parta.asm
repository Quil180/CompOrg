# Yousef Awad -- 06/29/2025
#
# parta.asm
#
# A program that computes 
# the number of times in a
# user inputted string for
# the following letters:
# K, N, I, G, H, T, S.
# After that it then shows
# a histogram of the results.
#
# Registers Used:
# $t0 - used to hold the user's string
# $t1 - used to hold # of K
# $t2 - used to hold # of N
# $t3 - used to hold # of I
# $t4 - used to hold # of G
# $t5 - used to hold # of H
# $t6 - used to hold # of T
# $t7 - used to hold # of S
# $t8 - used to hold current character/loop counter
#
# $v0 - syscall parameter and return value
# $a0 - syscall parameter (print value)

# to print out string inputted:
# la   $a0, buffer # reload byte space to primary address
# move $a0, $t0    # primary address = t0 address (load pointer of string)
# li   $v0, 4      # print string
# syscall

.data
intro:    .asciiz "Enter a string, under 1024 characters, below!\n"
youwrote: .asciiz "You entered in:"
newline:  .asciiz "\n"
hash:     .asciiz "#"
k:        .asciiz "K: "
n:        .asciiz "N: "
i:        .asciiz "I: "
g:        .asciiz "G: "
h:        .asciiz "H: "
t:        .asciiz "T: "
s:        .asciiz "S: "

# buffer is the string output
buffer:  .space 1024
.text

main:

# Printing intro
li $v0, 4
la $a0, intro
syscall

# Taking in input string
li   $v0, 8      #take in input from user
la   $a0, buffer #load byte space into address
li   $a1, 1024     # allocate the byte space for string
move $t0, $a0    # saving string to t0
syscall          # actually reading the string.

# calculating amount of stuff

# while not at end of string
calcagain:
lb   $t8, 0($t0)  # load current char into $t7
beqz $t8, endcalc # if at end of string, end while loop

# finding current value
beq $t8, 'k', foundK
beq $t8, 'K', foundK
beq $t8, 'n', foundN
beq $t8, 'N', foundN
beq $t8, 'i', foundI
beq $t8, 'I', foundI
beq $t8, 'g', foundG
beq $t8, 'G', foundG
beq $t8, 'h', foundH
beq $t8, 'H', foundH
beq $t8, 't', foundT
beq $t8, 'T', foundT
beq $t8, 's', foundS
beq $t8, 'S', foundS

found: # for if a letter is found
# moving string pointer up one
addi $t0, $t0, 1
j    calcagain

# at end of string
endcalc:

#################################################

# Printing out result in integers
# printing string
li $v0, 4      # print string
la $a0, k      # printing text for k
syscall
# printing value
li $v0, 1
la $a0, ($t1)
syscall
# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4      # print string
la $a0, n      # printing text
syscall
# printing value
li $v0, 1
la $a0, ($t2)
syscall
# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4      # print string
la $a0, i      # printing text
syscall
# printing value
li $v0, 1
la $a0, ($t3)
syscall
# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4      # print string
la $a0, g      # printing text
syscall
# printing value
li $v0, 1
la $a0, ($t4)
syscall
# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4      # print string
la $a0, h      # printing text
syscall
# printing value
li $v0, 1
la $a0, ($t5)
syscall
# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4      # print string
la $a0, t      # printing text
syscall
# printing value
li $v0, 1
la $a0, ($t6)
syscall
# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4      # print string
la $a0, s      # printing text
syscall
# printing value
li $v0, 1
la $a0, ($t7)
syscall
# printing newline
li $v0, 4
la $a0, newline
syscall

#################################################

# PRINTING THE HISTOGRAMMMM

li $t8, 0    # resetting counter

# printing string
li $v0, 4    # print string
la $a0, k    # printing text for k
syscall

hashK:
bge $t8, $t1, endHashK
li $v0, 4    # print string
la $a0, hash # printing hashtag
syscall
addi $t8, $t8, 1
j hashK
endHashK:
li $t8, 0    # resetting counter

# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4    # print string
la $a0, n    # printing text
syscall

hashN:
bge $t8, $t2, endHashN
li $v0, 4    # print string
la $a0, hash # printing hashtag
syscall
addi $t8, $t8, 1
j hashN
endHashN:
li $t8, 0    # resetting counter

# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4      # print string
la $a0, i      # printing text
syscall

hashI:
bge $t8, $t3, endHashI
li $v0, 4    # print string
la $a0, hash # printing hashtag
syscall
addi $t8, $t8, 1
j hashI
endHashI:
li $t8, 0    # resetting counter

# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4    # print string
la $a0, g    # printing text
syscall

hashG:
bge $t8, $t4, endHashG
li $v0, 4    # print string
la $a0, hash # printing hashtag
syscall
addi $t8, $t8, 1
j hashG
endHashG:
li $t8, 0    # resetting counter

# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4    # print string
la $a0, h    # printing text
syscall

hashH:
bge $t8, $t5, endHashH
li $v0, 4    # print string
la $a0, hash # printing hashtag
syscall
addi $t8, $t8, 1
j hashH
endHashH:
li $t8, 0    # resetting counter

# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4    # print string
la $a0, t    # printing text
syscall

hashT:
bge $t8, $t6, endHashT
li $v0, 4    # print string
la $a0, hash # printing hashtag
syscall
addi $t8, $t8, 1
j hashT
endHashT:
li $t8, 0    # resetting counter

# printing newline
li $v0, 4
la $a0, newline
syscall

# printing string
li $v0, 4    # print string
la $a0, s    # printing text
syscall

hashS:
bge $t8, $t7, endHashS
li $v0, 4    # print string
la $a0, hash # printing hashtag
syscall
addi $t8, $t8, 1
j hashS
endHashS:

# printing newline
li $v0, 4
la $a0, newline
syscall

#################################################

# end program succesfully
li $v0, 10 #end program
syscall

#################################################

# needed for if letter found
foundK:
addi $t1, $t1, 1
j    found

foundN:
addi $t2, $t2, 1
j    found

foundI:
addi $t3, $t3, 1
j    found

foundG:
addi $t4, $t4, 1
j    found

foundH:
addi $t5, $t5, 1
j    found

foundT:
addi $t6, $t6, 1
j    found

foundS:
addi $t7, $t7, 1
j    found
