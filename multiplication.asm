# Multiplication by addition
# Erik Ayavaca-Tirado
# CSC 345-Computer org
# 9/1/17
# Multiplication using a loop to multiply 2 numbers using addition 

.data
x: .word 7
y: .word 5
z: .word 0
final: .word 0  
g: .word 1
.text 
main:
lw $t0,x   # x variable 
lw $t1,y   # y variable 
lw $t2,z   
lw $t3,g
lw $t4, final # where final answer is stored 
beq $t1, $zero, Exit #when Y equals zero, X is already zero so exits.
Loop: beq $t1, $t3, yIsOne #when y is one skip rest of loop
add $t2, $t0, $t0 #actual "multiplication".
sub $t1, $t1, $t3 #what makes loop continue
bne $t1, $zero, Loop #while Y isnt yet 0.
yIsOne: add $t2, $t2, $t0 #adds X to 0 or the multiplied Xs
Exit:
sw $t4, final
nop 
