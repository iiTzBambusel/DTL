/*
 * Aufgabe_2_2.S
 *
 *	Aufgabe : Multiplikation
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
  mov r0,#0 //Ergebnis Register Initialisieren
  mov r1,#5 //Multiplikant
  mov r2,#4 //Multiplikator
  mov r3,#0 //Carry Zähler
  /*Multiplikation 5 mal 4 */
  cmp r1,#0
  beq stop
mul:
  adds r0,r0,r2 //Addiere Multiplikator auf ergebnis
  addcs r3,#1 //Wenn carry bit gesetzt addiere eins auf carry zähler
  subs r1,#1  //Subtrahiere den Multiplikant um eins
  //cmp r1,#0 Wenn Multipliknant ungleich 0 springe zum schleifen anfang
  bne mul

stop:
	nop
	bal stop

.end
