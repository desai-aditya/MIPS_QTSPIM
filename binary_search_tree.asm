.data
	space: .asciiz " "  # spaces
.text
main:

	li $s0,0  #$s0 always points to the root node of binary tree, initially NULL
	get_input: # infinite loop for getting input, 0 terminates loop
	
	li $v0,5 # take input
	syscall 	
	
	beq $v0,$zero,break_of_loop

	move $a0,$v0 # $a0 = number to be inserted
	move $a1,$s0 #$a1 = ptr to root, initially NULL
	jal insert_in_tree
	move $s0,$v0  # $v0 address to the root , storing it in $s0
	j get_input


break_of_loop:
	move $a0,$s0
	jal inorder_traversal
	
	li $v0,10
	syscall

insert_in_tree:
	bne $a1,$zero,not_base_case   # check for base case i.e. whether ptr == NULL

	move $t0,$a0  #temporarily storing the argument

	li $a0,12 # allocating 3 words , 1 for val, 1 for left ptr, 1 for right ptr
	li $v0,9 #sbrk
	syscall

	move $a0,$t0 #getting the number back
	sw $a0,($v0)  #storing the val
	sw $zero,4($v0)		# set left ptr to NULL
	sw $zero,8($v0)		# set  right ptr to NULL
	
		
	jr $ra
	
not_base_case:
	addi $sp,$sp,-12
	sw $ra,($sp)
	sw $a1,4($sp)
	sw $s0,8($sp)
	
	lw $t0,($a1)
	bge $a0,$t0,right  #compare current node value with the input value
	
	left:
		addi $a1,$a1,4
		move $s0,$a1
		lw $a1,($a1)  # now we are pointing to the left value (which could be NULL too)
		jal insert_in_tree
		j return_non_base
	
	right:
		addi $a1,$a1,8
		move $s0,$a1
		lw $a1,($a1)  # now we are pointing to the right value (which could be NULL too)
		jal insert_in_tree  
		j return_non_base		
	
return_non_base:
	sw $v0,($s0)
	lw $ra,($sp)
	lw $a1,4($sp)
	lw $s0,8($sp)	
	
	addi $sp,$sp,12
	move $v0,$a1
	jr $ra
	
	
	
##################### END OF INSERT TREE ###################

inorder_traversal:    #$a0, is the argument and holds the address of the root initially
	beq $a0,$zero,return_inorder
	
	addi $sp,$sp,-8		
	sw $ra,($sp)
	sw $a0,4($sp)	
	
	addi $a0,$a0,4   # inorder traversal of left
	lw $a0,($a0)
	jal inorder_traversal
	
	lw $a0,4($sp)	# loading and printing the middle value
	lw $a0,($a0)
	
	li $v0,1
	syscall

	
	la $a0,space
	li $v0,4
	syscall
	
	lw $a0,4($sp)	
	
	addi $a0,$a0,8 # inorder traversal of right
	lw $a0,($a0)	
	jal inorder_traversal
	
	
	lw $ra,($sp)
	lw $a0,4($sp)	
	addi $sp,$sp,8
	
	
	return_inorder:
	
	jr $ra


	
