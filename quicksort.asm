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

array:	.word		5 ,2 ,88 ,33 ,15 ,90 ,7 ,8
arraylength:	.word		8



#---------------
# PROGRAM section
#---------------

.text
main:

addi	$sp, $sp, -12	# Adjust stack to make room for 3 items.
sw	$s0, 0($sp)			#Save register $ra for use as return register.
sw	$s1, 4($sp)			#Save register $s0 to use in program.
sw	$ra, 8($sp)			#Save register $s1 to use in program.


la	$a0, array	# load array values
li	$a1, 0		# load value p
lw	$a2, arraylength	#load array length value

jal	quicksort	# jump and link quicksort function

lw	$s0, 0($sp)	#pops stack
lw	$s1, 4($sp)	
lw	$ra, 8($sp)	
addi	$sp, $sp, 12	
jr	$ra		# jump to caller

quicksort:
addi	$sp, $sp, -20	#Adjust stack to make room for 5 items.
sw	$s0, 0($sp)		
sw	$s1, 4($sp)		
sw	$s2, 8($sp)		
sw	$s3, 12($sp)		
sw	$ra, 16($sp)		

addi	$s2, $a1, 0		# places the  p value into $s2 
addi	$s3, $a2, 0		# places the r value into $s3
slt	$s0, $a1, $a2		# if p < r, $s0 == 1
beq	$s0, $zero, end	 # if value in $s0 = 0, go to end

jal	partition	# jump and link to partition

addi	$s1, $v0, 0	# places the q value into $s1
addi	$a2, $s1, -1	# places the value of q - 1 into $a2
addi	$a1, $s2, 0	# places the  p value into $a1

jal	quicksort	# jump and link quicksort(array, p, q-1)

addi	$a1, $s1, 1	# places q + 1 into $a1
addi	$a2, $s3, 0	# places r into $a2

jal	quicksort	# jump and link quicksort(array, q + 1, r)

end:
lw	$s0, 0($sp)	#pops the stack
lw	$s1, 4($sp)	
lw	$s2, 8($sp)	
lw	$s3, 12($sp)	
lw	$ra, 16($sp)	
addi	$sp, $sp, 20	

jr	$ra		# returns to caller

partition:
addi	$sp, $sp, -36	#Adjust stack to make room for 9 items.
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
lw	$s1, 0($s0)	# $s1 contains pivot value
addi	$s2, $a1, -1	#places the value i = p-1 into $s2
addi	$s3, $a1, 0	# places the value j = p into $s3
addi	$s4, $a2, 0	# places the value r into $s4

loop:
beq	$s3, $s4, end2	# if j is equal to  r, jump to end2 
sll	$s6, $s3, 2	# places j * 4 shifted into $s6
add	$s0, $a0, $s6	# places the array[j] into $s0
lw	$s5, 0($s0)	# places the array[j] value into $s5
slt	$t0, $s5, $s1	# if array[j] <= pivot then $t0 = 1
beq	$s5, $s1, loop2	#if array[j] == pivot then jump to loop2
beq	$t0, 1, loop2	# if array[j] less tahn pivot then jump toloop2
beq	$t0, 0, end1	# if array[j] not less than or equal than pivot then jump toend1

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
jr	$ra			#jump to previous address


swap:
  addi  $sp, $sp,  -28    #Adjust stack to make room for 7items.
  sw    $ra, 0 ($sp)       
  sw    $s0, 4 ($sp)
  sw    $s1, 8 ($sp)
  sw    $s2, 12($sp)
  sw    $s3, 16($sp)
  sw    $s4, 20($sp)
  sw    $s5, 24($sp)

  sll   $s0, $a1, 2         # from * 4 into $s0
  sll   $s1, $a2, 2         # to * 4 into $s1
  add   $s2, $a0, $s0    # Address of array[from] into $s2
  add   $s3, $a0, $s1    # Address of array[ to] into $s3
  lw    $s4, 0($s2)        # Value of array[from] into $s4
  lw    $s5, 0($s3)        # Value of array[to] into $s5
  sw    $s4, 0($s3)        # Value from $s4 into array[to]
  sw    $s5, 0($s2)        # Value from $s5 into array[from]


  lw    $ra, 0 ($sp)      
  lw    $s0, 4 ($sp)
  lw    $s1, 8 ($sp)
  lw    $s2, 12($sp)
  lw    $s3, 16($sp)
  lw    $s4, 20($sp)
  lw    $s5, 24($sp)
  addi  $sp, $sp, 28      # Pop the stack pointer
  jr	$ra