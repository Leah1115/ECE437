org 0x0000
ori $1, $0, 0x0001
ori $2, $0, 0x0002 
ori $3, $0, 0x0003
jal end
end:
lw  $5, 0($6)
halt
