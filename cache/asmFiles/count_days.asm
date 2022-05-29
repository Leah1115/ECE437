org 0x0000
ori $29, $0, 0xfffc
ori $28, $0, 0xfff8

main:
ori $1, $0, 1      #1
ori $2, $0, 21     #reg2 = CurrentDay
ori $3, $0, 1      #reg3 = CurrentMonth 
ori $4, $0, 2022   #reg4 = CurrentYear

ori $5, $0, 2000   #reg5 = 2000
ori $6, $0, 365    #reg6 = 365
ori $7, $0, 30     #reg7 = 30

ori $15, $0, 0     #store 30*
ori $16, $0, 0     #store 365*
ori $17, $0, 0
ori $18, $0, 0

subu $9, $4, $5    #reg9 = CurrentYear - 2000
subu $10, $3, $1   #reg19 = CurrentMonth - 1

push $6            #365
push $9            #CurrentYear - 2000
push $7            #30
push $10           #Currentmon - 1

pop $11            #get CurrentMonth -1
pop $12            #get 30
ori $13, $0, 0
ori $14, $0, 0

mult:
  beq $12, $1, end1
    srlv $13, $1, $12
    sllv $13, $1, $13
  beq $13, $12, case0
    add $14, $14, $11
    sllv $11, $1, $11
    srlv $12, $1, $12
j mult

case0:
  sllv $11, $1, $11
  srlv $12, $1, $12
j mult
end1:
  add $14, $14, $11
  add $15, $15, $14

pop $11            #get CurrentMonth -1
pop $12            #get 30
ori $13, $0, 0
ori $14, $0, 0

mult2:
  beq $12, $1, end2
    srlv $13, $1, $12
    sllv $13, $1, $13
  beq $13, $12, case02
    add $14, $14, $11
    sllv $11, $1, $11
    srlv $12, $1, $12
j mult2

case02:
  sllv $11, $1, $11
  srlv $12, $1, $12
j mult2
end2:
  add $14, $14, $11
  add $16, $16, $14
  add $17, $15, $16
  add $18, $17, $2
  halt
