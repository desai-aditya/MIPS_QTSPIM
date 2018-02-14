.data
arr : .word 17, 18, 32, 13
space : .asciiz " "
.text
main:

li $s0,4      
li $s1,4
addi $s0,$s0,-1	# length -1






############### bubble sort
li $t5,0

outer:
	li $t6,0
	la $t0,arr		
	inner:
		lw $t1,($t0)		
		lw $t2,4($t0)		
		
		lw $a0,4($t0) 
		
		bgt $t1,$t2,swap
		returnswap:
		
		addi $t0,$t0,4
		
		addi $t6,$t6,1
		bne $t6,$s0,inner
	
	addi $t5,$t5,1
	bne $t5,$s0,outer
	
	
############# print array
move $t7,$s1 # t7 loop counter
la $t0,arr
print:
	
	lw $a0,($t0)

	li $v0,1
	syscall
	
	la $a0,space
	li $v0,4
	syscall
	
	addi $t7,$t7,-1
	addi $t0,$t0,4
	
	bne $t7,$zero,print


###############
	
	


li $v0,10
syscall



swap:
	sw $t2,($t0)
	sw $t1,4($t0)		
	j returnswap




