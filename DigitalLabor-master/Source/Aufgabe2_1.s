/*
 * Aufgabe_2_1.S
 *
 *	Aufgabe : 64 Bit Addition
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
  mov r0,#0xFFFFFFF //low half
  mov r1,#0xFFFFFFF //high half
  
  
  mov r2,#0xFFFFFF //low half
  mov r3,#0xFFFFFFFFFFF //high half
  
  
  adds r8,r0,r2 //Niederwertige stellen addieren
  adcs r9,r1,r3 //Höherwertige stellen mit carry addieren
  movcs r10,#1
  movcc r10,#0 
stop:
	nop
	bal stop

.end
