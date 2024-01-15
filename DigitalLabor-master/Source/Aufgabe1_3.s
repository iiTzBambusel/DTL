/*
 * Aufgabe_1_3.S
 *
 *  Created on: <02.10.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Flags und bedingte Ausführung
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
mov r0,#25 //Var Threshold
mov r1,#20 //Var Value
subs r1,r0,r1 //Subtrahiere und update die Flags
bmi bigger //Springe zu "bigger" wenn Negativ flag gesetzt
mov r1,#0
b finish//Überspringe wenn "Value Größer als "Threshold"
bigger:
mov r1,#1
finish:

mov r0,#25 //Var Threshold
mov r1,#20 //Var Value
subs r1,r0,r1 //cmp würde das selbe tun nur ohne das ergebnis in ein register zu schreiben in diesem fall ändert sich das erg nicht
//Wenn Negativ flag gesetzt schreibe 1
movmi r1,#1
//Wenn Negativ flag nicht gesetzt schreibe 0 
movpl r1,#0
stop:
	nop
	bal stop


.end