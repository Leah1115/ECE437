org 0x0000
ori $1, $0, 0x0001
ori $2, $0, 0x0002
ori $3, $0, 0x0003 
nop

sw $3, 0($7)
halt

# org 0x0200
# ori $4, $0, 0x0004
# ori $5, $0, 0x0005
# ori $6, $0, 0x0006
# lw $6, 0($8)
# halt
