#+++++
# Multiplication by Addition
# Erik Ayavaca-Tirado 
# This program is used to multiply two integer numbers using assembly language.
#-----

#+++++
# Data Segment
#-----

.data
x:     .word    7
y:     .word   5
answer:      .word    0
counter:	 .word	  0

#+++++
# Program Segment
#-----

.text

main:
  lw   $t1,   x    
  lw   $t2,   y 
  lw   $t3,   counter
  lw   $a1,   answer
BeginLoop:         #Start of loop 
	beq $t2, $t3, EndLoop  # Loop counter
	add $t4, $t4, $t1
	addi $t3, $t3, 1   
	j BeginLoop   
EndLoop:
  sw    $t4,   answer
nop