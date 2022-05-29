#---------------------------------------
#  unit test for jump
#---------------------------------------
 org 0x0000

ori $29, $0, 0xFFFC

 ori $4, $0, 0x00  # j
 ori $6, $0, 0x00  # jr
 ori $5, $0, 0x00  # jal
 ori $8,$0,0x80

j jump_test
ori $4,$0,0x0002  #  jump error
halt

jump_test:
    ori $4,$0,0x0001   # jump correct
    # sw $4, 0($8)
    jal jal_test
    # ori $8, $0, 0x002  # jal error
    ori $6,$0,0x0001     # jr correct   
    sw $6,4($8)   # memory[$4 + 0] = $1 
    halt

jal_test:
    ori $5,$0,0x0001     # jal correct
    sw $5,8($8)   # memory[$4 + 0] = $1 
    jr $31
    halt



