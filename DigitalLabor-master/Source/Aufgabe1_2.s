/*
 * Aufgabe_1_2.S
 *
 *  Created on: <02.10.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Addition von Zahlen
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
//Aufgabe a:
  mov r0,#4294967295 // Positiv 4294967295 ist in dem 32 bit register gleich "-1" + 1 also "0"
  mov r1,#1
  add r2,r0,r1
//Aufgabe b:
  mov r3,#~0
  mov r4,#1
  add r5,r3,r4
//aufgabe c:
  mov r0,#2147483648//Bei 32 bit ist die Groeßst moegliche zahl "4.294.967.295" = (2^32)-1 wegen der "0" 
  add r1,r0,r0  //Wenn man also die haelfte von 4.294.967.296 auf sich selbst addiert erhaelt man als ergebnis "0"
  //Weil das register wieder bei 0 anfaengt

stop:
	nop
	bal stop

.end
