org 0x0000           #Initialize
ori $29, $0, 0xFFFC  #Init sp
ori $1, $0, 0x0001   #1
ori $2, $0, 0x0002   #oprand 1
ori $3, $0, 0x0005   #oprand 2
# ori $6, $0, 0x0002


push $2              #push the oprand1 in reg2 into stack
push $3              #push the oprand2 in reg3 into stack


pop $4               #pop the value to $4 //oprand2
pop $5               #pop the value to $5 //oprand1
ori $7, $0, 0x0000   #compare container cc
ori $8, $0, 0x0000   #accumulator 
beq $4, $0, end0
beq $5, $0, end0
mult:
  beq $5, $1, end     #if(oprand1 == 1) do below 
    srlv $7, $1, $5      #cc = oprand1 >> 1
    sllv $7, $1, $7      #cc = cc << 1
  beq $7, $5, case0    #if(oprand1 == cc) do below
    add $8, $4, $8       #cc += oprand2 
    sllv $4, $1, $4      #oprand2 = oprand2 << 1
    srlv $5, $1, $5      #oprand1 = oprand1 >> 1
j mult

case0:
  sllv $4, $1, $4      #oprand2 = oprand2 << 1
  srlv $5, $1, $5      #oprand1 = oprand1 << 1
j mult

end:
  add $8, $4, $0
  push $8
halt

end0:
  add $8, $0, $0
  push $8
halt



