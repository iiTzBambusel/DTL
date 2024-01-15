/*
 * Aufgabe_2_3.S
 *
 *  Created on: <06.11.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Werte Binarisieren
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
  daten: //eine variable mit mehreren 32 bit wörtern 
  .word 4,3,6,7,9,8,1,5

main:

  
  mov r0,#0b0 //Ausgaberegister
  mov r1,#8 //Datenmenge
  mov r3,#3 //Schwellwert
  ldr r4,=daten //addresse der daten in register r4 laden
  
  cmp r1,#0 //bei datenmenge 0 bricht das programm 
  beq stop // vor der schleife ab
  
  loop:
  ldr r2,[r4],#4 //datenzeiger updaten und wert laden
  
  cmp r3,r2 //vergleich ob wert in r2 größer als der schwellwert ist
  
  movmi r2,#1 //wenn negativ flag gesetzt schreibe 1
  movpl r2,#0 //wenn negativ nicht gesetzt schreibe 0
  mov r0,r0,lsl#1 // r0 um ein byte logisch links verschieben
  orr r0,r0,r2 //r0 mit r2 verodern und in r0 schreiben
  
  subs r1,r1,#1 //datenmenge dekrementieren
  bne loop //wenn die datenmenge 0 wird ist das programm fertig
stop:
	nop
	bal stop

.end