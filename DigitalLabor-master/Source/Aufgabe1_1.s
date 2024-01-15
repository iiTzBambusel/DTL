/*
 * Aufgabe_1_1.S
 *
 *  Created on: <02.10.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Zahlendarstellung
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
  mov r0,#0xFFFFFFF5
  mov r1,#4294967285
  mov r2,#-11
  mov r3,#-0xB
  mov r4,#~10
  mov r5,#0b11111111111111111111111111110101
stop:
	nop
	bal stop

.end
