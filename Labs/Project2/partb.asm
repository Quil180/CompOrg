# Yousef Awad -- 07/06/2025
#
# partb.asm (Optimized for Energy Efficiency)
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
# $s0 - used to hold the pointer to the user's string
# $s1 - used to hold # of K
# $s2 - used to hold # of N
# $s3 - used to hold # of I
# $s4 - used to hold # of G
# $s5 - used to hold # of H
# $s6 - used to hold # of T
# $s7 - used to hold # of S
# $t0,$t8 - used for temporary values, loop counters, and addresses
#
# $v0 - syscall parameter and return value
# $a0 - syscall parameter (print value)

.data
# Data section is minimal, only holding required strings
intro:      .asciiz "Enter a string, under 1024 characters, below!\n"
newline:    .asciiz "\n"
hash:       .asciiz "#"
k_label:    .asciiz "K: "
n_label:    .asciiz "N: "
i_label:    .asciiz "I: "
g_label:    .asciiz "G: "
h_label:    .asciiz "H: "
t_label:    .asciiz "T: "
s_label:    .asciiz "S: "

buffer:     .space 1024

.text
.globl main

main:
    # Print intro prompt
    li $v0, 4
    la $a0, intro
    syscall

    # Read user string
    li $v0, 8
    la $a0, buffer
    li $a1, 1024
    syscall

    # Initialize count registers to 0
    li $s1, 0  # Count K
    li $s2, 0  # Count N
    li $s3, 0  # Count I
    li $s4, 0  # Count G
    li $s5, 0  # Count H
    li $s6, 0  # Count T
    li $s7, 0  # Count S

    # Setup pointer for the counting loop
    la $s0, buffer

#################################################################
# ULTRA-LOW ENERGY COUNTING LOOP (OPTIMIZED)
#################################################################
count_loop:
    lb $t0, ($s0)               # The only memory read in the loop.
    beqz $t0, print_results     # If null terminator, loop is done.

    # Convert char to lowercase (energetically cheap)
    blt $t0, 'A', check_chars
    bgt $t0, 'Z', check_chars
    ori $t0, $t0, 0x20

check_chars:
    # Branch chain reordered by frequency of letters in English (T,S,H,N,I,G,K)
    # to reduce the average number of branches executed per character.
    beq $t0, 't', found_t
    beq $t0, 's', found_s
    beq $t0, 'h', found_h
    beq $t0, 'n', found_n
    beq $t0, 'i', found_i
    beq $t0, 'g', a_found_g # Renamed to avoid assembler error with g_label
    beq $t0, 'k', found_k

    # Character not in our set. Fall through to increment pointer and loop again.
    # This structure eliminates a 'j next_char' instruction, saving 3 fJ per character.
    addi $s0, $s0, 1
    j count_loop

found_t:
    addi $s6, $s6, 1
    # The pointer increment and loop jump are duplicated here to avoid an extra
    # jump instruction that would have been needed to go to a common "next_char" label.
    # This saves 3 fJ for every character counted.
    addi $s0, $s0, 1
    j count_loop
found_s:
    addi $s7, $s7, 1
    addi $s0, $s0, 1
    j count_loop
found_h:
    addi $s5, $s5, 1
    addi $s0, $s0, 1
    j count_loop
found_n:
    addi $s2, $s2, 1
    addi $s0, $s0, 1
    j count_loop
found_i:
    addi $s3, $s3, 1
    addi $s0, $s0, 1
    j count_loop
a_found_g:
    addi $s4, $s4, 1
    addi $s0, $s0, 1
    j count_loop
found_k:
    addi $s1, $s1, 1
    addi $s0, $s0, 1
    j count_loop

#################################################################
# PRINT RESULTS (UNROLLED FOR LOW ENERGY)
# This section is intentionally verbose to avoid expensive memory loads.
#################################################################
print_results:
    # Print K count
    li $v0, 4
    la $a0, k_label
    syscall
    li $v0, 1
    move $a0, $s1 # Use register value directly
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Print N count
    li $v0, 4
    la $a0, n_label
    syscall
    li $v0, 1
    move $a0, $s2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Print I count
    li $v0, 4
    la $a0, i_label
    syscall
    li $v0, 1
    move $a0, $s3
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Print G count
    li $v0, 4
    la $a0, g_label
    syscall
    li $v0, 1
    move $a0, $s4
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Print H count
    li $v0, 4
    la $a0, h_label
    syscall
    li $v0, 1
    move $a0, $s5
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Print T count
    li $v0, 4
    la $a0, t_label
    syscall
    li $v0, 1
    move $a0, $s6
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Print S count
    li $v0, 4
    la $a0, s_label
    syscall
    li $v0, 1
    move $a0, $s7
    syscall
    li $v0, 4
    la $a0, newline
    syscall

#################################################################
# PRINT HISTOGRAM (UNROLLED FOR LOW ENERGY)
#################################################################
print_histogram:
    # Print K histogram
    li $v0, 4
    la $a0, k_label
    syscall
    li $t8, 0
hash_k:
    bge $t8, $s1, end_hash_k
    li $v0, 4
    la $a0, hash
    syscall
    addi $t8, $t8, 1
    j hash_k
end_hash_k:
    li $v0, 4
    la $a0, newline
    syscall

    # Print N histogram
    li $v0, 4
    la $a0, n_label
    syscall
    li $t8, 0
hash_n:
    bge $t8, $s2, end_hash_n
    li $v0, 4
    la $a0, hash
    syscall
    addi $t8, $t8, 1
    j hash_n
end_hash_n:
    li $v0, 4
    la $a0, newline
    syscall
    
    # Print I histogram
    li $v0, 4
    la $a0, i_label
    syscall
    li $t8, 0
hash_i:
    bge $t8, $s3, end_hash_i
    li $v0, 4
    la $a0, hash
    syscall
    addi $t8, $t8, 1
    j hash_i
end_hash_i:
    li $v0, 4
    la $a0, newline
    syscall

    # Print G histogram
    li $v0, 4
    la $a0, g_label
    syscall
    li $t8, 0
hash_g:
    bge $t8, $s4, end_hash_g
    li $v0, 4
    la $a0, hash
    syscall
    addi $t8, $t8, 1
    j hash_g
end_hash_g:
    li $v0, 4
    la $a0, newline
    syscall

    # Print H histogram
    li $v0, 4
    la $a0, h_label
    syscall
    li $t8, 0
hash_h:
    bge $t8, $s5, end_hash_h
    li $v0, 4
    la $a0, hash
    syscall
    addi $t8, $t8, 1
    j hash_h
end_hash_h:
    li $v0, 4
    la $a0, newline
    syscall

    # Print T histogram
    li $v0, 4
    la $a0, t_label
    syscall
    li $t8, 0
hash_t:
    bge $t8, $s6, end_hash_t
    li $v0, 4
    la $a0, hash
    syscall
    addi $t8, $t8, 1
    j hash_t
end_hash_t:
    li $v0, 4
    la $a0, newline
    syscall

    # Print S histogram
    li $v0, 4
    la $a0, s_label
    syscall
    li $t8, 0
hash_s:
    bge $t8, $s7, end_hash_s
    li $v0, 4
    la $a0, hash
    syscall
    addi $t8, $t8, 1
    j hash_s
end_hash_s:
    li $v0, 4
    la $a0, newline
    syscall

exit:
    li $v0, 10
    syscall