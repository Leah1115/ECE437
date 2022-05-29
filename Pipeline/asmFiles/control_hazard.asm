org 0x0000
ori $1, $0, 0x0001
ori $2, $0, 0x0002
ori $5, $0, 0x0005
ori $6, $0, 0x0006

beq $1, $1, end # control hazards
and $12,$2, $5
or  $13,$2, $6
add $14,$2, $2

end:
sw $4, 0($7)
halt
