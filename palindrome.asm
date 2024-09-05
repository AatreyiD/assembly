.data
prompt: .asciiz "\n Enter a string of 50 characters or less :"
buffer: .space 51	#including \n
errormsg: .asciiz "\n string incorrect"
rightmsg: .asciiz "\n this is a palindrome"

.text
la $a0, prompt
li $v0, 4	#print prompt
syscall

li $v0, 8	#get entered string
la $a0, buffer	#string in a0
li $a1, 51
syscall

la $s0, ($a0)	#s0 has starting pointer of str


checkend:
lb $t0, 0($a0)
beq $t0, $0, finishstr
addi $a0, $a0, 1	#go to next byte
j checkend

finishstr:
addi $a0, $a0, -2	#minus eos, minus \n
			#a0 points to last char of string
			
addi $s1, $s1, 32	#asc for space
lb $t1, ($s0)
beq $t1, $s1, adjustfront	#check if starts with space
lb $t2, ($a0)
beq $t2, $s1, adjustback	#check if ends with space
j checkstr

adjustback:
addi $a0, $a0, -1
j checkstr

adjustfront:
addi $s0, $s0, 1
j checkstr


checkstr:
lb $t1, ($s0)	#1st char
lb $t2, ($a0)	#last char
bge $s0, $a0, pali	#both reached midway
bne $t1, $t2, allcheck
incr:
addi $s0, $s0, 1	#go to next char
addi $a0, $a0, -1	#go to prev char
j checkstr

allcheck:
addi $t1, $t1, 32	#make 1st capital
beq $t1, $t2, orflag
addi $t1, $t1, -64	#make 1st lower
beq $t1, $t2, orflag
j notpali

orflag:
j incr	#letters match, go back to increment

pali:
la $a0, rightmsg
li $v0, 4	#this is a palindrome
syscall
j exit

notpali:
la $a0, errormsg
li $v0, 4	#not a palindrome
syscall
j exit

exit:
li $v0, 10	#end program
syscall