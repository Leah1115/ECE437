org 0x0000
ori $29, $0, 0xFFFC
ori $1, $0, 0x0001
ori $2, $0, 0x0002
ori $3, $0, 0x0003

bne $0, $0, end
add $4, $2, $0
halt

end:
add $4, $3, $0
sw $4, 0($5)
lw $6, 0($5)
halt
