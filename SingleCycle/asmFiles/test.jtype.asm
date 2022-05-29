org 0x0000
ori $2, $0, 0x0002
ori $3, $0, 0x0003
jal multi
halt

multi:
ori $4, $0, 0x0000
ori $5, $0, 0x0000

loop:
beq $4, $3, end
add $5, $5, $2
addi $4, $4, 1
j loop

end:
sw $5, 0($6)
lw $7, 0($6)
jr $31
