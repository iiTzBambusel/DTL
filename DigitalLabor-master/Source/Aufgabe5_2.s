/*
 * Aufgabe_5_2.S
 *
 *  Created on: <19.12.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Permanentes Lauflicht
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
.equ delayTime2_3, (4000000)
.equ delayTime1_3, (2000000)
.global delay

delay:
push {r0}
ldr r0,[sp,#4]

schleife:
subs r0,r0,#1
bne schleife

pop {r0}
bx lr

main:
.equ IODIR1,0xE0028018
.equ IOSET1,0xE0028014
.equ IOCLR1,0xE002801C

ldr r0,=IODIR1 //adresse für port direction in r0 
ldr r1,=IOSET1 //adresse für port set in r1
ldr r2,=IOCLR1 //adresse für port clear in r2

mov r4,#0b11111111<<16 //maske um alle pins 16-23 als ausgang zu setzen

ldr r5,[r0] //aktuelle richtung lesen
orr r5,r4   //richtung verändern
str r4,[r0] //richtung wieder speichern

ldr r8,=delayTime2_3 //wartezeit 2/3
ldr r9,=delayTime1_3 //wartezeit 1/3

mov r4,#1<<16 //maske für einzelne leds 

mov r6,#8 //schleifen zähler initialisieren

loop:
//led an
str r4,[r1] 

//delay für 2/3
push {r8} 
bl delay
pop {r8} 

//led aus
str r4,[r2]

//delay für 1/3
push {r9} 
bl delay
pop {r9} 

//maske auf die nächste led schieben
lsl r4,#1 

subs r6,#1 //acht durchläufe weil 8 leds
bne loop

lsr r4,#8 //bitmaske wieder auf die erste led setzen
add r6,#8 //schleifen zähler zurücksetzen

bal loop //endlos nach oben springen
stop:
	nop
	bal stop

.end