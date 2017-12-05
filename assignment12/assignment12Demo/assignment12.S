#include <avr/io.h>
#include "asmMacros.s"  // Include macros to print log messages or a single register
.data

globalasm: .byte 0

.text

//adds input to global variable
.global updateGlobal
updateGlobal:
  ldi r30, lo8(globalasm)
  ldi r31, hi8(globalasm)
  ld r18, Z
  add r24, r18
  st Z, r24
  ret

//returns current value in global
.global getGlobal
getGlobal:
  ld r24, Z
  ret

//returns the length of a string inputed as array of chars
.global cStringLength
cStringLength:
  // TODO: uint8_t cStringLength(const char aString[])
  movw r26, r24 //pointer from input registers to X
  ldi r18, 0 //counter
  jmp strLoop
  
  strLoop:
    ld r20, X+ //inc Y after loading into r20
    cp r20, r1 //compare pointer with 0
    breq endStrLoop //branch to end of func
    inc r18
    jmp strLoop

  endStrLoop: //end
    mov r24, r18
    ret
    

.global sumArrays
sumArrays:
  // TODO: void sumArrays(uint8_t *a, uint8_t *b, uint8_t *c, byte length)
  push r29 //save y register
  push r28
  push r17
  push r16
  push r15
//  push r14
  
  movw r26, r24 //*a to X
  movw r28, r22 //*b to Y
  movw r30, r20 //*c to Z ====sum====
  mov r16, r18 //length to r16
  jmp sumLoop

sumLoop:
  cp r16, r1 //check if length is 0 (empty)
  breq endSumLoop

  ld r17, X+ //load then inc
  ld r15, Y+
  add r17, r15 //sum of *X + *Y
  
  st Z+, r17 //store then inc

  dec r16 // length--
  jmp sumLoop
  
endSumLoop:
  movw r24, r30

//  push r14
  pop r15
  pop r16
  pop r17
  pop r28
  pop r29

  ret


.global dot
dot:
  // TODO uint16_t dot(uint8_t *a, uint8_t *b, byte length)
  push r17
  push r3
  push r1

  movw r30, r24 //*a to Z
  movw r26, r22 //*b to X
  mov r17, r20 // length to r17
  ldi r24, 0  //r24,25 reset for sum
  ldi r25, 0
  ldi r16, 0 //const 0
  jmp dpLoop

dpLoop:
  cp r16, r17 //lenght >= 0
  breq endDpLoop //end func: length < 0

  ld r20, Z+
  ld r18, X+
  mul r18, r20 //multiple X Z, STORED in r0,r1 
  movw r18, r0 //product transferred in to r18

  add r24, r18 //product added to sum
  adc r25, r19

  dec r17 //length --
  jmp dpLoop

endDpLoop:
  pop r16
  pop r2
  pop r17
  ret

