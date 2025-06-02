# Yousef Awad -- 06/02/2025
# add.asm -- A program that computes the sum of 4 and 1,
# leaving the result in the register $t0.
# Registers Used:
# t0 - used to hold the result

# main signifies where the program starts
main:
# t1 - used to hold the constant 4
li $t1, 4

# adding 1 to 4
addi $t0, $t1, 1 # $t0 = $t1 + 1

# exiting
li $v0, 10 # 10 is the exit syscall
syscall

# end of add.asm