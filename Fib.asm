#+++++
# Fib.asm
# Erik Ayavaca-Tirado
# This program is used to calculate fibonacci sequence using double recursion, and then prints them in the console.
#-----

#+++++
# Data Segment
#-----

.data
	fibonacci:     .word    10  # used to tell the program how many fibonacci numbers the user wants.
	answer:     .word     0      # used to store the answer from the fibonacci function.
	comma:	.asciiz  ", "        # used to print out the commas between the printed numbers.
	periods:	.asciiz  "... "  # used to add periods to the end of the printed line to show that the proogram is finished.

#+++++
# Program Segment
#-----

.text

#+++++      
# Main Function  
# This part has a loop that will iterate over the number in the fibonacci data value.
# Through each iteration it will get the fibonacci value and print it out to the console.
# To get this fibonacci value the program must call the function fib to get the value of the function. 
#-----

main:
	addi  $sp, $sp, -16    #Adjust stack to make room for 4 items.
	sw	$s2, 12($sp)       #Save register $s2 to use in program.
	sw	$s1, 8($sp)        #Save register $s1 to use in program.
	sw	$s0, 4($sp)        #Save register $s0 to use in program.
	sw	$ra, 0($sp)        #Save register $ra for use as return register.
	lw	$s1, fibonacci    #Loads the value of fibonacci into the $s1 register.
	add $s2, $zero, $zero  #Sets the $s2 register to zero using the add command and the $zero register.

#+++++      
# Loop Function  
# This function loops from 0 to the value of fibonacci so that it can get all the fibonacci values in between inclusive.
# It will then print out the values onto the console with some commas and periods to make it look pretty. 
#-----

beginloop:                 #This is where the loop function begins.
	beq $s1, $s2, endloop  #This is to check if the current position of the fibonacci number is the same as the value in fibonacci. If true it jumps to the end.
	addi $a0, $s2, 1       #This adds the current value of $s2 to the $ao register so that it can be used in the fib function. The reason one is added because the program actually starts 0 and ends before if hits value of fibonacci.
	jal fib                #Calls the fib function.
	sw	$v0, answer        #Takes the return value of the fib function and stores it in the answer memory location
	lw	$s0, answer        #Takes the vvalue from the answer memory location and puts it into the $s0 register, so that it can beprinted out.

#+++++
# This part of the loop is used to return the values of the fib function to the console and adda a comma to it.
#-----
 
    #Prints out the value of answer to the console.
	li $v0, 1
	addi $a0, $s0, 0
	syscall
	
	#Prints out the string ", " to the console.
	li $v0, 4
	la $a0, comma
	syscall
	
	addi $s2, $s2, 1       #Increments the value of $s2 by one so that it can be used to get the next fibonacci value.
	j beginloop            #Jump to the beginning of the loop.
endloop:                   #End of the loop function.

	#Prints out the string "... " to the console.
	li $v0, 4
	la $a0, periods
	syscall

	lw	$s2, 12($sp)       #Pop value from stack for $s2 register.
	lw	$s1, 8($sp)        #Pop value from stack for $s1 register.
	lw	$s0, 4($sp)        #Pop value from stack for $s0 register.
	lw	$ra, 0($sp)        #Restore the return address and pop it.
	addi  $sp, $sp, 16     #Pop and delete the room of 4 items.
	jr	$ra                #Returns us back to the caller.

#+++++      
# Fib Function  
# This is used to calculate the value of a fibonacci number at a given postion in the set.
# double recursion is used to complete the task and after completion it returns the value of the fibonacci number. 
#-----
	
fib:	
	addi  $sp, $sp, -16    ##Adjust stack to make room for 4 items.
	sw	$s2, 12($sp)       #Save register $s2 to use in program.
	sw	$s1, 8($sp)        #Save register $s1 to use in program.
	sw	$s0, 4($sp)        #Save register $s0 to use in program.
	sw	$ra, 0($sp)        #Save register $ra for use as return register.
	
	addi $s1, $zero, 1     #Sets value of $s1 to zero so it can be used for the base case checks.
	add $s0, $a0, $zero    #Puts the value from the $a0 register into the $s0 register. 
	
	slti $t0, $s0, 1       #Compares the value of $s0 and checks if it is less than 1. Sets value of $t0 to 1 if true.
	beq $t0, $s1, zero     #If $t0 is true, then the we use a beq and compares it to $s1 so that we can jump to the base case.
	
	slti $t1, $s0, 3       #Compares the value of $s0 and checks if it is less than 3. Sets value of $t1 to 1 if true.
	beq $t1, $s1, one      #If $t1 is true, then the we use a beq and compares it to $s1 so that we can jump to the base case.
	
	addi $a0, $s0, -1      # calculates the n-1 part of the fibonacci sequence.
	jal fib                # calls the fib function with the n-1, so that we get the value for fib(n-1)
	
	add $s2, $v0, $zero    # saves the value of fib(n-1) into a register so we can use it later.
 	
	addi $a0, $s0, -2      # calculates the n-2 part of the fibonacci sequence.
	jal fib                # calls the fib function with the n-2, so that we get the value for fib(n-2)
	
	add $v0, $v0, $s2      # adds the value of fib(n-1) and fib(n-2) to get the value of the current fibonacci number.
	j return               #Jump to the end of the function.
	
#+++++
# These are the base cases if the value of fibonacci is less than 1 or less than 3.
#-----
	
zero:                      #Beggining of the base case if fibonnachi is less than 1.
  add   $v0, $zero, $zero  #Sets $v0 to the value of 0.
  j return                 #Jump to the end of the function.
  
one:                       #Beggining of the base case if fibonnachi is less than 3.
  addi   $v0, $zero, 1     #Sets $v0 to the value of 1.
  j return                 #Jump to the end of the function.

return:
	lw	$s2, 12($sp)       #Pop value from stack for $s2 register.
	lw	$s1, 8($sp)        #Pop value from stack for $s1 register.
	lw	$s0, 4($sp)        #Pop value from stack for $s0 register.
	lw	$ra, 0($sp)        #Restore the return address and pop it.
	addi  $sp, $sp, 16     #Pop and delete the room of 4 items.
	jr	$ra                #Returns us back to the caller, in this case Main.