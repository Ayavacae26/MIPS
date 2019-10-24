#--------------
# QuickSort.asm
# Erik Ayavaca-Tirado
# 12/15/17
# This is an assembly code will sort an unsorted array of numbers using the quicksort 
# algorithm 
#---------------

#---------------
# DATA section
#---------------
.data
array: .word    2 ,3 ,7 ,26 ,8 ,4   # these are the values of the array,
arraylength: .word 6     # array length or r


#---------------
# PROGRAM section
#---------------
.text
main:

	addi  $sp, $sp, -12 #Adjust stack to make room for 3 items.
	sw    $ra, 0($sp)   #Save register $ra for use as return register.
	sw    $s0, 4($sp)   #Save register $s0 to use in program.
	sw    $s1, 8($sp)   #Save register $s1 to use in program.

	la	$a0, array	# load array values
	li	$a1, 0		# load value p
	lw	$a2, arraylength	# load array length value (r)

	jal	quicksort	#jump and link to the  quicksort function

	lw	$s0, 0($sp)	#pop stack
	lw	$s1, 4($sp)	
	lw	$ra, 8($sp)	
	addi	$sp, $sp, 12	
	jr	$ra		
	
#----------
# quickSort function
#----------
quicksort:
addi	$sp, $sp, -20	#push onto stack for 5 ints
sw	$s0, 0($sp)		
sw	$s1, 4($sp)		
sw	$s2, 8($sp)		
sw	$s3, 12($sp)		
sw	$ra, 16($sp)		

addi	$s2, $a1, 0		# place p value into $s2 
addi	$s3, $a2, 0		# place r value into $s3
slt	$s0, $a1, $a2		# if p < r, $s0 == 1
beq	$s0, $zero, end	 # if $s0 = 0, end

jal	partition	#jump and link to partition

addi	$s1, $v0, 0	#place q value into $s1
addi	$a2, $s1, -1	#place q - 1 into $a2
addi	$a1, $s2, 0	#place p value into $a1

jal	quicksort	#jump and link quicksort(array, p, q-1)

addi	$a1, $s1, 1	#place q + 1 into $a1
addi	$a2, $s3, 0	#place r into $a2

jal	quicksort	#jump and link quicksort(array, q + 1, r)

end:
lw	$s0, 0($sp)	#pop the stack
lw	$s1, 4($sp)	
lw	$s2, 8($sp)	
lw	$s3, 12($sp)	
lw	$ra, 16($sp)	
addi	$sp, $sp, 20	

jr	$ra		# jump to previous address


#------------
# partition 
#------------
partition:
addi	$sp, $sp, -36	# push onto stack for 9 ints
sw	$s0, 0($sp)		
sw	$s1, 4($sp)		
sw	$s2, 8($sp)		
sw	$s3, 12($sp)		
sw	$s4, 16($sp)		
sw	$s5, 20($sp)		
sw	$s6, 24($sp)		
sw	$s7, 28($sp)		
sw	$ra, 32($sp)		

sll	$s7, $a2, 2	# place r * 4 shifted into $s7

add	$s0, $a0, $s7	# place array[r] value into $s0
lw	$s1, 0($s0)	#$s1 contains the pivot value
addi	$s2, $a1, -1	#place value i = p-1 into $s2
addi	$s3, $a1, 0	#place value j = p into $s3
addi	$s4, $a2, 0	#place value r into $s4

loop:
beq	$s3, $s4, end2	# if j == r, end2 
sll	$s6, $s3, 2	# place j * 4 shifted into $s6
add	$s0, $a0, $s6	# place array[j] into $s0
lw	$s5, 0($s0)	# place array[j] value into $s5
slt	$t0, $s5, $s1	# if array[j] <= pivot, $t0 = 1
beq	$s5, $s1, loop2	#if array[j] == pivot, loop2
beq	$t0, 1, loop2	# if array[j] < pivot, loop2
beq	$t0, 0, end1	# array[j] !<= pivot, end1

loop2:
addi	$s2, $s2, 1	#add 1 to i value in $s2
addi	$a1, $s2, 0	#place i value into $a1
addi	$a2, $s3, 0	#place j value into $a2
addi	$s3, $s3, 1	#increment j by 1
jal	swap			#jump and link swap function
j	loop			#jump to loop

end1:
addi	$s3, $s3, 1	#increment j by 1
j	loop			#jump to loop

end2:
addi	$a1, $s2, 1	#add 1 to i into $a1
addi	$a2, $s4, 0	#swap (array, i + 1, r) value
jal	swap			#jump and link swap function
addi	$v0, $s2, 1	#add 1 to i into $v0 to return

lw	$s0, 0($sp)	#pop the stack
lw	$s1, 4($sp)	
lw	$s2, 8($sp)	
lw	$s3, 12($sp)	
lw	$s4, 16($sp)	
lw	$s5, 20($sp)	
lw	$s6, 24($sp)	
lw	$s7, 28($sp)	
lw	$ra, 32($sp)	
addi	$sp, $sp, 36	
jr	$ra	
	

#---------
# swap function
#----------
# Assume that array address is in $a0, from index in $a1, and to index in $a2
swap:
  addi  $sp, $sp,  -28    # Push the stack pointer down to hold seven values
  sw    $ra, 0 ($sp)      # Store the return address and s registers on the stack
  sw    $s0, 4 ($sp)
  sw    $s1, 8 ($sp)
  sw    $s2, 12($sp)
  sw    $s3, 16($sp)
  sw    $s4, 20($sp)
  sw    $s5, 24($sp)
  # Done with protecting registers. Now for the real work:
  sll   $s0, $a1, 2       # from * 4 into $s0
  sll   $s1, $a2, 2       # to * 4 into $s1
  add   $s2, $a0, $s0     # Address of array[from] into $s2
  add   $s3, $a0, $s1     # Address of array[ to] int9 $s3
  lw    $s4, 0($s2)       # Value of array[from] into $s4
  lw    $s5, 0($s3)       # Value of array[to] into $s5
  sw    $s4, 0($s3)       # Value from $s4 into array[to]
  sw    $s5, 0($s2)       # Value from $s5 into array[from]
  # Done with the work. No return value.
  lw    $ra, 0 ($sp)      # Restore the $ra and $s registers from the stack
  lw    $s0, 4 ($sp)
  lw    $s1, 8 ($sp)
  lw    $s2, 12($sp)
  lw    $s3, 16($sp)
  lw    $s4, 20($sp)
  lw    $s5, 24($sp)
  addi  $sp, $sp, 28      # Pop the stack pointer
  
  
  
  
  
  jr    $ra