# Yousef Awad -- 06/02/2025
#
# counter.asm
#
# A program that counts
# from 5 to 20 while 
# displaying such to
# the user in binary.
#
# Registers Used:
# $t0 - Current Number
# $t1 - Max Number
# $v0 - Syscall/Return Parameter
# $a0 - Syscall Parameter (print)

main:

# initializing current and max
li $t0, 5
li $t1, 21 # must be one greater than wanted value

# loop proper
loop: bge $t0, $t1, exit

	# printing current number ($t0)
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	# printing newline
	li $v0, 11
	li $a0, 10
	syscall
	
	# incrementing current by 1
	addi $t0, $t0, 1
	
	# jump to check if $t0 > $t1 - 1
	j loop

# exit branch (if $t0 > $t1 - 1)
exit:
li $v0, 10
syscall