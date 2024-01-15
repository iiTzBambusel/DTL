/*
 * Aufgabe_3_4.S
 *
 *  Created on: <20.11.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Unterprogrammaufruf mit Übergebe von mehreren Parametern - Division
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
.global division
division:
  push {r6,r7}
  mov r6,r0 //divident in r6
  mov r7,r1 //divisor in r7
  mov r8,#0 //ergebnis register
  mov r9,#0 //rest register
  cmp r7,#0 //Prüfen auf 0 divisor
  movle r8,#-1  //ergebnis = -1 wenn die berechnung nicht ausgeführt werden kann
  pople {r6,r7}
  bxle lr
loop:
  add r8,r8,#1 //ergebnis
  subs r6,r6,r7
  bge loop
  //Loop end
  add r6,r6,r7 // Korrigiere Divident
  sub r8,r8,#1 //korrigiere Ergebnis
  mov r9,r6 //rest in r9 speichern 
  pop {r6,r7}
  bx lr
main:
mov r0,#8 //Dividend
mov r1,#2 // Divisor
bl division
mov r4,r8 //ergebnis verwerten
mov r5,r9 // rest verwerten

stop:
	nop
	bal stop

.end
