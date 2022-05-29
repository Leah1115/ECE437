#---------------------------------------
#  unit test for branch
#---------------------------------------
 org 0x0000

 ori $8, $0, 0x00
 ori $7, $0, 0x00
 ori $6, $0, 0x00
 ori $5, $0, 0x00
 ori $4,$0,0x80
 start:
  ori $1, $0, 1
  ori $2, $0, 1
  ori $3, $0, 3
  beq $1, $3, E_beq

  ori $5, $0, 0x01   # beq branch correct
  beq $1, $2, test1 
  ori $6, $0, 0x02   # beq branch error
  halt

 test1:
  ori $6, $0, 0x01   # beq branch correct
  bne $1, $2, E_bne
  ori $7, $0, 0x01   # bne branch correct
  bne $1, $3, E_bne2
  ori $8, $0, 0x02   # bne branch error
  

  halt
 E_beq:
  ori $5, $0, 0x02   # beq branch error
  halt
E_bne:
  ori $7, $0, 0x02   # bne branch error
  halt
E_bne2:
  ori $8, $0, 0x01   # bne branch correct
  sw $6,0($4)   # memory[$4 + 0] = $1 
  sw $7,4($4)   # memory[$4 + 0] = $1 
  halt



