#--------------
# String.asm
# Erik Ayavaca-Tirado
# 11/27/17
# This assembly code taking in a string array and count length of the array. 
# An example is if the string is "Erik" then it should say the length is 4
#---------------

#---------------
# DATA section
#---------------
.data

string: .asciiz "Erik" #String is 4. so in printout it should return 4 in console
Printout: .asciiz "The string length is: "


#---------------
# PROGRAM section
#---------------
.text
main:

	la $a0, string    # Load address of string into register a0
	jal strlen        # Jump and link to the Strlen function
    jal print         # Jump and link to the print function
 	addi $a1, $a0, 0  # Move address of string to $a1
    addi $v1, $v0, 0  # Move length of string to $v1
    addi $v0, $0, 11  # System call code for message.
    la $a0, Printout  # loads address of printout into register a0
    syscall
    addi $v0, $0, 10        # System call code for exit.
    syscall

# strlen is the function,which will count the string length.
strlen:
li $t0, 0 # initialize the count to zero

loop:

lb $t1, 0($a0) # load the next character into t1
beq $t1, 0, exit # checks for the null character
addi $a0, $a0, 1 # increments the string pointer
addi $t0, $t0, 1 # increments the counter
j loop # returns to the top of the loop

exit:
jr $ra 

# print function is used to print the printout message "The string length is: "
print:
	li $v0, 4
	la $a0, Printout
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

jr $ra





 
 
 
 
 
 