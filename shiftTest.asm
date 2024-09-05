.text

addi $t1, $t1, 33554440
sll $t1, $t1, 24
srl $t1, $t1, 24

li $v0, 10
syscall
