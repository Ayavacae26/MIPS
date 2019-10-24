#-----------                    
# LargestNumArraay.asm
# Erik Ayavaca-Tirado
# This is an assembly code that will determine the largest number in an array and return that value to the console. 
#----------

#------------
# DATA Section
#------------

.data
array: .word    2 ,3 ,7 ,26 ,8 ,4   # these are the values of the array,Largest is 26
arraylength: .word 6     # array length of 6 elements
largestNum: .word 0

#----------
# PROGRAM Section
#----------
.text
main:
	addi  $sp, $sp, -12 # Adjust stack to store in 3 items 
	sw    $ra, 0($sp)   # Saves register $ra for a return register
	sw    $s0, 4($sp)   # Saves register $s0 for use in program.
	sw    $s1, 8($sp)   # Saves register $s1 for use in program.
	la $s0, array       #loads array 
	lw $s1, arraylength
	jal findLargest     # jump and link to the findLargest function
	sw $v0, largestNum
	add   $a0, $v0, $zero  # Puts Largest into $a0 in prep for syscall print
	li    $v0, 1           # the use of 1 in $v0 will make syscall to print
	syscall
	lw    $ra, 0($sp)   # Restore the return address and pop it.
	lw    $s0, 4($sp)   # Pop value from stack for $s0 register.
	lw    $s1, 8($sp)   # Pop value from stack for $s1 register.
	addi  $sp, $sp, 12  # Pop and deletes the room of 3 items.
	jr    $ra           

# Function used to find the Largest Number in the array--------------------------	
findLargest:   
	addi  $sp, $sp, -12 # Adjust stack to store in 3 items 
	sw    $ra, 0($sp)   # Saves register $ra for return register
	sw    $s0, 4($sp)   # Saves register $s0 for use in program.
	sw    $s1, 8($sp)   # Saves register $s1 for use in program.
	lw $s1, arraylength # loads arraylenght into resgister $s1
	la $s0, array		#loads array address into register $s0
	addi $t0, $zero, 1	# counter++			
	addi $t6, $zero, 1				
	lw $t7, 0($s0)
	addi $v0, $t7, 0	#first number in array is consider the largest
	
beginloop:
	beq $s1, $t0, endloop
	sll $t2, $t0, 2			# multiply by 4; used to find the next num in array
	add $t3, $t2, $s0		# register $t3 has the address of the next number in the array
	lw $t4, 0($t3)			# grabs the next number in array
	slt $t5, $v0, $t4		# if current greatest number is less than the next number in the array 
	addi $t0, $t0, 1		# increment the counter 
	beq $t5, $t6, updateLargest
	j beginloop

# finish off the function call--------------------------------------------------------
endloop:
	j restoreAndReturn				
	
# function used to update the largest number-----------------------------------------
updateLargest:						
	add $v0, $t4, $zero
	j beginloop

# Puts values back into registers from the stack--------------------------------------	
restoreAndReturn:	  
  lw    $ra, 0($sp)   # Restore the return address and pop it.
  lw    $s0, 4($sp)   # Pop value from stack for $s0 register.
  lw    $s1, 8($sp)   # Pop value from stack for $s1 register.
  addi  $sp, $sp, 12  # Pop and deletes the room of 3 items.
  jr    $ra           # Returns us back to the caller