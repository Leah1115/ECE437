  #------------------------------------------------------------------
  # Tests ihit dhit same clock
  #------------------------------------------------------------------
    ori   $1, $zero, 0xF0
    ori   $2, $zero, 0x001
    ori   $3, $zero, 0x002
    ori   $4, $zero, 0x003
    ori   $5, $zero, 0x000
    ori   $6, $zero, 0x004


branch:
    lw    $1,0($5)
    addi $3,$3, 1
    addi $2,$2, 1
    addi $4,$4, 1     # dhit
    bne $2, $6 , branch
    sw  $3, 0($5)
  halt    

  org   0x00F0
  cfw   0x7337
  cfw   0x2701
  cfw   0x1337
