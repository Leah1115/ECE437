
  #------------------------------------------------------------------
  # Tests lui
  #------------------------------------------------------------------

  org   0x0000
  ori   $1,$zero,0xF0
  ori   $2,$zero,0x80


  lui   $7,0xdead
  ori   $9,$zero,0x80
  ori   $7,$7,0xbeef
  sw    $7,0($2)

  lui   $7,0xdead
  ori   $16,$7,0xbeef
  sw    $16,4($2)

  lui   $7,0xdead
  lui   $15,0xdead
  ori   $9,$zero,0x80
  ori   $7,$15,0xbeef
  sw    $7,8($2)

  lui   $7,0xdead
  lui   $15,0xdead
  ori   $7,$15,0xbeef
  sw    $7,12($2)

  lui   $7,0xdead
  #ori   $7,$7,0xbeef
  sw    $7,16($2)


  halt      # that's all
 
  

