/*
 * Aufgabe_5_3.S
 *
 *  Created on: <20.12.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Ein- und Ausgabe über Taster und LEDs
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */

//Subroutine zum verabeiten von Button 0
.global checkButton
checkButton:
push {r1}

ldr r1,[r0] // status der buttons in r1 laden

ands r1,r2,r1 //filtern ob button 1 gedrückt
bne noled

str r4,[r6] //led aus 
lsl r4,#4 //maske auf geparte led schieben
str r4,[r5] //led an

pop {r1}
bx lr

// Subroutine zum verarbeiten wenn kein button gedrückt wurde
noled: //button nicht gedrückt

str r4,[r5]//aktuelle led anschalten
lsl r4,#4//maske der gepaarten led laden
str r4,[r6]//gepaarte led ausschalten

pop {r1}
bx lr

main:
  //Adressen für die pins
  .equ IOPIN0,0xE0028000
  .equ IOPIN1,0xE0028010

  //offset für die register
  .equ IODIR,0x08
  .equ IOSET,0x04
  .equ IOCLR,0x0C
  
  //Bitmasken für die buttons
  .equ BUTTON_0_bm,(1<<10) //bitmaske für button 1
  .equ BUTTON_1_bm,(1<<11) //bitmaske für button 2
  .equ BUTTON_2_bm,(1<<12) //bitmaske für button 3
  .equ BUTTON_3_bm,(1<<13) //bitmaske für button 4

  //Bitmasken für die Leds
  .equ LEDALL_bm,(0b11111111 << 16)
  .equ LED0_bm,(1 << 16)
  .equ LED1_bm,(1 << 17)
  .equ LED2_bm,(1 << 18)
  .equ LED3_bm,(1 << 19)

ldr r0,=IOPIN0 //Adresse für die buttons laden

//Alle leds als ausgang setzen
mov r9,#0b11111111 << 16
ldr r1,=(IOPIN1 | IODIR) //IODIR1 zusammenbauen
str r9,[r1]

//Led Steuerungs register
ldr r5,=(IOPIN1 | IOSET) //IOSET1 zusammenbauen
ldr r6,=(IOPIN1 | IOCLR) //IOCLR1 zusammenbauen

//Endlosschleife um die buttons abzufragen
loop:

ldr r4,=LED0_bm
ldr r2,=BUTTON_0_bm
  bl checkButton

ldr r4,=LED1_bm
ldr r2,=BUTTON_1_bm
  bl checkButton

ldr r4,=LED2_bm
ldr r2,=BUTTON_2_bm
  bl checkButton

ldr r4,=LED3_bm
ldr r2,=BUTTON_3_bm
  bl checkButton

bal loop

stop:
	nop
	bal stop

.end