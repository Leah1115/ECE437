# Multicore coherence test
# Each core stores to values that exist on the same block in the cache

# core 1
org 0x0000

  ori $t0, $0, data1
  ori $t1, $t1, 0xFFFF
  sw  $t1, 0($t0)
  nop   #
  nop   #core2 is loading the word
  nop

  halt

# core 2
org 0x0200


  nop   
  nop  
  nop
  ori $t0, $0, data1
  ori $t1, $t1, 0xAAAA
  sw  $t1, 0($t0)
  halt

org 0x0400
data1:
  cfw 0xBAD0BAD0
data2:
  cfw 0xBAD0BAD0
data3:
  cfw 0xBAD0BAD0
data4:
  cfw 0xBAD0BAD0
