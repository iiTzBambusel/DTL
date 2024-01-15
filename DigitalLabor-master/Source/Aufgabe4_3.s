/*
 * Aufgabe_2_3.S
 *
 *  Created on: <10.12.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Datenstrom Binarisieren
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
//daten 1
daten_1: //eine variable mit mehreren 32 bit wörtern 
  .byte 4 //datenmenge
  .byte 0 //Status 5=bearbeitet,0=nicht bearbeitet
  .byte 1,2,3,4 //daten
//daten 2
daten_2:
  .byte 4 //datenmenge
  .byte 5 //Status 5=bearbeitet,0=nicht bearbeitet
  .byte 0,1,0,1 //daten
//daten 3
daten_3:
  .byte 4 //datenmenge
  .byte 0 //Status 5=bearbeitet,0=nicht bearbeitet
  .byte 8,7,4,2 //daten

.global binarisieren
binarisieren:
  push {r1,r2,r3,r4,r5,r9}
  mov r4,r0 //pointer kopieren
  
  ldrb r1,[r0,#1] //status in r1 laden
  cmp r1,#5
  beq done //wenn status == 5 an das ende der funktion springen 
  
  ldrb r2,[r0],#2 //datenmenge laden

loop:

  ldrb r3,[r0] //aktuelle daten in r3 laden
  cmp r9,r3 //r3 mit threshold vergleichen
  movpl r3,#0 //wenn r3 kleiner gleich threshold schreibe 0 in r3
  movmi r3,#1 //wenn r3 größer als threshold schreibe 1 in r3

  strb r3,[r0],#1 //ergebnis wieder in den speicher schreiben und zeiger erhöhen


  subs r2,r2,#1 //datenmenge dekrementieren
  bne loop //wenn die datenmenge 0 wird ist das programm fertig 

  mov r5,#5 //status byte im speicher auf 5 setzen für bearbeitet
  strb r5,[r4,#1] 

done:
  
  pop {r1,r2,r3,r4,r5,r9}
  bx lr

main:
  ldr r9,=#2 //threshold
  ldr r0,=daten_1
  bl binarisieren
  ldr r0,=daten_2
  bl binarisieren
  ldr r0,=daten_3
  bl binarisieren
stop:
	nop
	bal stop

.end