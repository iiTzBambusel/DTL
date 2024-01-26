/*
 * Aufgabe_4_2.S
 *
 *	Aufgabe : Addition von zwei 8 stelligen BCD Zahlen
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
.global addBCD
addBCD:
//die funktion erwartet die beiden zahlen in r2 und r3 und liefert das ergebnis in r9
push {r0,r1,r4,r5,r6,r8} //arbeitsregister sichern
mov r0,#8 //stellenzähler und carry flag in cspr rücksetzen
mov r1,#0xF //stellenmaske
mov r8,#0 //zwischen ergebnis
mov r9,#0 //rückgabe
mov r4,#0 //carry initialisieren

loop:
and r5,r2,r1 //stellen isolieren
and r6,r3,r1

add r8,r5,r6 // niederwertige stellen addieren
add r8,r8,r4 //carry addieren

subs r8,#10 //uberlauf prüfen
movlt r4,#0 //carry rücksetzen wenn ergbnis < 10

addlt r8,#10 //ergebnis korrigieren wenn < 10 
movge r4,#1 //wenn ergebnis >= 10 carry setzen

add r9,r9,r8 //ergbnis aktualliesieren

mov r2, r2,ror #4 //zahlen rotieren
mov r3, r3,ror #4
mov r9, r9,ror #4



subs r0,#1 //stellenzähler dekrementieren
bgt loop
pop {r0,r1,r4,r5,r6,r8} //arbeits register wiederherstellen
bx lr

main:

ldr r2,=#0x12345678
ldr r3,=#0x55555555
bl addBCD


stop:
	nop
	bal stop
.end