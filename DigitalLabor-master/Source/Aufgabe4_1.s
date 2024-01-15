/*
 * Aufgabe_4_1.S
 *
 *  Created on: <04.12.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Verwendung von Stack
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
  //Funktion 2
.global func2
func2:
  adds r0,r0,r1
  
  rsblt r0,r0,#0  //wenn ergebnis kleiner 0 absolut wert bilden

bx lr

.global func1 //Funktion 1

func1:
push {r0,r1,lr} //lr wird auch gespeichert damit jede func1 erreicht wird
add sp,#-8   //stack bereich für die variablen
ldr r0,=#5 //variable a erstellen und auf den stack laden
strb r0,[sp,#0]
ldr r0,=#-6 //variable b erstellen und auf den stack laden
strh r0,[sp,#2]

ldrb r0,[sp,#0] //variable a in r0 laden
ldrsh r1,[sp,#2] //variable b in r1 laden
bl func2 

str r0,[sp,#4] //ergebnis in variable c speichern
add sp,#8
pop {r0,r1,lr}
bx lr

main:
mov r0,#0x44 //testwerte laden
mov r1,#0x55
bl func1
bl func1
bl func1


stop:
	nop
	bal stop

.end