#+++++++++
# LargestNumInArray.asm
# Erik Ayavaca-Tirado
# This code will find the largest number in an array and return it
#---------


#+++++++++
#Data Segment
#---------

.data
array: 	.word 	-15, 15, -30, 2, 4
arraylength: 	.word 	5
largestNumber: 	.word 	0

#+++++++++
#Program Segment
#---------
.text
main: 
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp) 
	
	la $s0, array
	lw $s1, arraylength
	
	jal findLargest
	
	sw $v0, largestNumber
	
	add   $a0, $v0, $zero  	#Put the answer into $a0 in prep for syscall print_int
	li    $v0, 1           	#1 in $v0 will make syscall to print_int
	syscall
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
	
	jr    $ra			 #Return to caller
	
findLargest:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp) 
	
	lw $s1, arraylength
	la $s0, array
	
	addi $t0, $zero, 1				#counter
	addi $t6, $zero, 1				#stays at one -- used as checker

	lw $t7, 0($s0)
	addi $v0, $t7, 0				#first number in array is consider the largest
	
beginloop:
	beq $s1, $t0, endloop
	sll $t2, $t0, 2					#multiply by 4 (used to find the next number in the array) --> example, first position is 0 x 4 = 0 
	add $t3, $t2, $s0				#$t3 has the address of the next number in the array
	lw $t4, 0($t3)					#grab next number in array
	
	slt $t5, $v0, $t4				#if current greatest number is less than the next number in the array 
	
	addi $t0, $t0, 1				#increment the counter
	beq $t5, $t6, updateLargest 
	j beginloop
endloop:
	j restoreAndReturn				#finish off the function call

updateLargest:						#updates the largest number
	add $v0, $t4, $zero
	j beginloop
	
restoreAndReturn:					#Put things back into registers from the stack
  lw    $ra, 0($sp)
  lw    $s0, 4($sp)
  lw    $s1, 8($sp)
  addi  $sp, $sp, 12     			#Pop the stack (restore the stack pointer)
  jr    $ra
