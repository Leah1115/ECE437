org 0x0000

main:
  ori $29, $0, 0xfffc    #top stack pointer
  ori $28, $0, 0xfff8    #bot sp
  ori $1, $0, 0x0001     #reg1=1
  ori $2, $0, 0x0002   #oprand1
  ori $3, $0, 0x0003     #oprand2
  ori $4, $0, 0x0004     #oprand3
  ori $5, $0, 0x0005     #oprand4
  ori $9, $0, 0x0000     #accumulator

beq $2, $0, end0
beq $3, $0, end0
beq $4, $0, end0
beq $5, $0, end0
  push $2
  push $3
  push $4
  push $5
  j multp

multp:
  beq $28, $29, done     #if(sp.top == sp.bot)
  jal prepare

done:
  halt

prepare:
  pop $6
  pop $7
  ori $8, $0, 0x0000     #compare container
  ori $9, $0, 0x0000     #accumulator


mult:
  beq $7, $1, exit
    srlv $8, $1, $7      #cc = oprand1 >> 1
    sllv $8, $1, $8
  beq $8, $7, case0
    add $9, $6, $9
    sllv $6, $1, $6
    srlv $7, $1, $7
j mult

case0:
  sllv $6, $1, $6
  srlv $7, $1, $7
j mult

exit:
  add $9, $6, $9
  push $9
j multp

end0:
  add $9,$0,$0
halt

