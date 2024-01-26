/*
 * Aufgabe_5_1.S
 *
 *	Aufgabe : Fortschrittsanzeige
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
.equ delayTime, (8000000)
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

ldr r0,=IODIR1 //adresse für richtung laden
ldr r1,=IOSET1 //adresse für an oder aus laden

mov r6,#8 //schleifen zähler 8 weil 8 leds

mov r4,#0b11111111<<16 //maske um alle pins 16-23 als ausgang zu setzen

ldr r5,[r0] //aktuelle richtung lesen
orr r5,r4 //richtung verändern
str r4,[r0] //richtung wieder speichern

ldr r8,=delayTime //wartezeit laden

mov r4,#1<<16 //maske für einzelne leds 

loop:
//led anschalten
str r4,[r1] 

//maske auf die nächste led schieben
lsl r4,#1 

//delay aufrufen
  push {r8} 
  bl delay
  pop {r8} 

subs r6,#1 //schleifenzähler dekrementieren
bne loop
stop:
	nop
	bal stop

.end