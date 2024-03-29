#counts length of a string

.data
 .data
string: .asciiz "Hello"

printedMessage: .asciiz "The length of the string: "

    .text
main:
  la $a0, string             # Load address of string.
        jal strlen              # Call strlen procedure.
        jal print
        addi $a1, $a0, 0        # Move address of string to $a1
        addi $v1, $v0, 0        # Move length of string to $v1
        addi $v0, $0, 11        # System call code for message.
        la $a0, printedMessage            # Address of message.
        syscall
        addi $v0, $0, 10        # System call code for exit.
        syscall


strlen:
li $t0, 0 # initialize the count to zero
loop:
lb $t1, 0($a0) # load the next character into t1
beq $t1, 0, exit # check for the null character
addi $a0, $a0, 1 # increment the string pointer
addi $t0, $t0, 1 # increment the count
j loop # return to the top of the loop
exit:
jr $ra

print:
li $v0, 4
  la $a0, printedMessage
  syscall

  li $v0, 1
  move $a0, $t0
  syscall


jr $ra