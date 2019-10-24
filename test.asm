.data
inputX: .word 5
inputY: .word 4
tempX: .word 0
constantOne: .word 1
finalX: .word 0

.text
main:

lw $t1, inputX
lw $t2, inputY
lw $t0, tempX
lw $t3, constantOne
lw $t4, finalX
beq $t2, $zero, Exit #when Y equals zero, X is already zero so exits.
Loop: beq $t2, $t3, yIsOne #when y is one skip rest of loop
add $t0, $t1, $t1 #actual "multiplication".
sub $t2, $t2, $t3 #what makes loop continue
bne $t2, $zero, Loop #while Y isnt yet 0.
yIsOne: add $t0, $t0, $t1 #adds X to 0 or the multiplied Xs
Exit:
sw $t4, finalX