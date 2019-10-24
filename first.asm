# first.asm
# Erik Ayavaca
# Adding two numbers

.data
x: .word 3417
y: .word -179
z: .word 0

.text 
main:
lw $t0,x
lw $t1,y
add $t7,$t0,$t1
sw $t7,z
nop