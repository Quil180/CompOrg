# Yousef Awad -- 06/23/2025
#
# StrtoLowerCase.asm
#
# A program that shifts
# a given string to lower
# case characters and returns
# it to the user via the console.
#
# Registers Used:
# $t0 - holds address of input string
# $t1 - holds current character
# $v0 - syscall parameter and return value
# $a0 - holds what to print

.data
string:  .asciiz "computer OrGANIzatioN"
newline: .asciiz "\n"
.text


main:

la $t0, string # string* = string

loop:
lb $t1, 0($t0) # loading next character into t1
beqz $t1, exit # if null, exit

# if t1 >= A
bge $t1, 65, testCase2
j nextChar


testCase2:
# if t1 > a, nextChar
bge $t1, 97, nextChar
# t1 is therefore less than a
addi $t1, $t1, 32 # making it lowercase


nextChar:
sb $t1, 0($t0)
addi $t0, $t0, 1 # move string pointer up one
j loop



exit:
# printing amount of characters
li $v0, 4
la $a0, string
syscall

# printing newline
li $v0, 4
la $a0, newline
syscall

# Ending program succesfully
li $v0, 10
syscall
