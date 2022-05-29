org 0x0000

ori $1, $0, 0x0200
ori $2, $0, 0x0210
ori $3, $0, 0x0220 #addr

ori $4, $0, 0x4444
ori $5, $0, 0x5555
ori $6, $0, 0x6666 #data

sw $4, 0($1) #PrWr: I->M 
sw $5, 0($1) #PrWr: M->M
lw $6, 0($1) #PrRd: M->M


halt


