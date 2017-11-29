#include <avr/io.h>
#include "asmMacros.s"  // Include macros to print log messages or a single register
.text


.global updateGlobal
updateGlobal:
  // TODO: void updateGlobal(byte a)
  ret


.global getGlobal
getGlobal:
  // TODO: uint8_t getGlobal()
  ret


.global cStringLength
cStringLength:
  // TODO: uint8_t cStringLength(const char aString[])
  ret

.global sumArrays
sumArrays:
  // TODO: void sumArrays(uint8_t *a, uint8_t *b, uint8_t *c, byte length)
  ret

.global dot
dot:
  // TODO uint16_t dot(uint8_t *a, uint8_t *b, byte length)
  ret

