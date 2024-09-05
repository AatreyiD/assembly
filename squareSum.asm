.data
prompt: .asciiz "\n Enter a positive number"
warning: .asciiz "\n Input is erroneous"
naivetext: .asciiz "\n Naive : "
interestingtext: .asciiz "\n Interesting : "

.text
la $a0, prompt
li $v0, 4	#print prompt
syscall

li $v0, 5	#get entered num
syscall
add $s0, $s0, $v0	#s0 contains num

addi $t0, $t0, 1	#put 1 in t0
blt $s0, $t0, error	#leave if num<1

addi $s1, $s1, 0	#s1 contains 0

naive:
mul $s2, $s1, $s1	#multiply num with num and keep in $s2
add $s3, $s3, $s2	#add square to $s3
beq $s1, $s0, interesting	#move to interesting if counter has reached
addi $s1, $s1, 1
j naive

interesting:
addi $s4, $s0, 1	#s4 contains n+1
add $s5, $s0, $s0	#s5 contains n+n
addi $s5, $s5, 1	#s5 contains 2n+1
addi $s6, $s6, 6	#s6 contains 6
mul $s7, $s0, $s4	#s7 = n(n+1)
mul $s7, $s7, $s5	#s7 = n(n+1)(2n+1)
div $s7, $s6		#lo contains s7/s6
mflo $t8		#s8 contains ans
j exit

print:
la $a0, naivetext
li $v0, 4
syscall 
move $a0, $s3
li $v0, 1	#print naive
syscall

la $a0, interestingtext
li $v0, 4
syscall
move $a0, $t8
li $v0, 1	#print interesting
syscall

j exit

error:
la $a0, warning
li $v0, 4	#print error
syscall

exit:
li $v0, 10	#end program
syscall