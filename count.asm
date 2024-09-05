.data
prompt: .asciiz "enter a number: "

.text
la $a0, prompt
li $v0, 4	#print prompt
syscall

li $v0, 5	#read entered integer
syscall

move $s0, $v0

li $t0, 1

loop:
move $a0, $t0
li $v0, 1
syscall

addi $t0, $t0, 1

ble $t0, $s0, loop

li $v0, 10
syscall
