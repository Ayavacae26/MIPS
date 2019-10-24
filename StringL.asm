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

string1: .asciiz "Erik" #String is 4. so in printout it should return 4 in console
string2: .asciiz "Ayavaca-Tirado"
Printout: .asciiz "The string length is: "
SLength: .word 0

#---------------
# PROGRAM section
#---------------
.text
main:
	addi $sp, $sp, -8 #Adjust stack to make room for 2 items. Not sure if truly needed.
  	sw $ra, 0($sp)	  #Save register $ra for use as return register.
  	sw	$s0, 4($sp)   #Save register $s0 to use in program.

	la $a0, string1    # Load address of string into register a0
	jal strlenprint        # Jump and link to the Strlen function
    jal print         # Jump and link to the print function
    
    la $a0, string2    # Load address of string into register a0
	jal strlenprint        # Jump and link to the Strlen function
    jal print         # Jump and link to the print function
    
    lw $ra, 0($sp)   #Restore the return address and pop it.
	lw $s0, 4($sp)   #Pop value from stack for $s0 register.
	
# strlen is the function,which will count the string length.
strlen:
	 addi $sp, $sp, -12 #Adjust stack to make room for 3 items.
  	 sw $ra, 0($sp)	  #Save register $ra for use as return register.
  	 sw	$s0, 4($sp)   #Save register $s0 to use in program.
  	 sw	$s1, 8($sp)   #Save register $s1 to use in program.
  	 
  	 addi $s0,$a0,0
  	 addi $s1,$zero,0 #counter

loop:

	lb $t0, 0($a0) # load the next character into t1
	beq $t0, 0, exit # checks for the null character
	addi $s1, $s1, 1 # increments the string pointer
	addi $s0, $s0, 1 # increments the counter
	j loop # returns to the top of the loop

print:
	li $v0, 1
	la $a0, printout
	
strlenprint:
	sw $v0, SLength
	jr $ra 

exit:
	addi $v0,$s1,0
	lw $ra, 0($sp)   #Restore the return address and pop it.
	lw $s0, 4($sp)   #Pop value from stack for $s0 register.
	lw  $s1, 8($sp)   #Pop value from stack for $s1 register.
	addi  $sp, $sp, 12  #Pop and delete the room of 3 items.
	jr $ra 







 
 
 
 
 
 