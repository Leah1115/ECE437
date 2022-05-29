org 0x0000
ori $1, $0, 0x0001
ori $2, $0, 0x0002
ori $3, $0, 0x0003
ori $4, $0, 0x0004
ori $5, $0, 0x0100


beq $0, $0, end
add $4, $1, $0
halt

end:
add $4, $3, $0
sw $4, 0($5)
lw $6, 0($5)
halt

