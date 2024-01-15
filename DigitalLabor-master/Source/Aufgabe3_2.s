/*
 * Aufgabe_3_2.S
 *
 *  Created on: <13.11.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Unterprogrammaufruf  mit Parametern
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
.equ delayTime, (8)
daten: //eine variable mit mehreren 32 bit wörtern 
  .word 4,3,6,7,9,8,1,5
.global delay
delay:
push {r0}
mov r0,r8
schleife:
subs r0,r0,#1
bne schleife
pop {r0}
bx lr
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
  mrs r9,CPSR //flags sichern für unabhängige flags in der delay function
  ldr r8,=delayTime //delay time
  bl delay //bl speichert den aktuellen wert des pc im link register
  msr CPSR,r9 //flags wieder laden
  bne loop //wenn die datenmenge 0 wird ist das programm fertig

stop:
	nop
	bal stop

.end