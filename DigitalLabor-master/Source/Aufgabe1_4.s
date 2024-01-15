/*
 * Aufgabe_1_4.S
 *
 *  Created on: <09.10.2023>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Maskenoperationen
 */
.text /* Specify that code goes in text segment */
.code 32 /* Select ARM instruction set */
.global main /* Specify global symbol */
main:
  .equ BREAD_bm, (0b0001 <<0)  //FOODS bleiben im Nibble 0
  .equ BUTTER_bm, (0b0010 <<0)
  .equ CHEESE_bm, (0b0100 <<0)
  
  .equ ORANGE_bm, (0b0001 <<4) //FRUITS werden in Nibble 1 Verschoben indem alle bits um 4 nach links geshiftet werden
  .equ BANANA_bm, (0b0010 <<4)
  .equ KIWI_bm, (0b0100 <<4)
  
  .equ WATER_bm, (0b0001 <<8) //DRINKS werden in Byte 1 verschoben indem alle bits um 8 nach links geshiftet werden
  .equ MILK_bm, (0b0010 <<8)
  .equ FANTA_bm, (0b0100 <<8)
  
  .equ FOODS_bm, (BREAD_bm | BUTTER_bm | CHEESE_bm) //Bitmaske für FOODS Bestehend aus Bitmasken "BREAD_bm | BUTTER_bm |CHEESE_bm"
  
  .equ FRUITS_bm, (ORANGE_bm | BANANA_bm | KIWI_bm)//Bitmaske für FRUITS Bestehend aus Bitmasken "ORANGE_bm | BANANA_bm |KIWI_bm"
  
  .equ DRINKS_bm, (WATER_bm | MILK_bm | FANTA_bm)//Bitmaske für FOODS Bestehend aus Bitmasken "WATER_bm | MILK_bm |FANTA_bm"
  
  .equ BREAKFAST_bm, (FOODS_bm | MILK_bm| KIWI_bm) //Bitmaske für BREAKFAST Bestehend aus Bitmasken "FOODS_bm | MILK_bm |KIWI_bm"
  
  ldr r0,=BREAKFAST_bm
  ldr r1,=BREAKFAST_bm |FRUITS_bm 
  ldr r2,=BREAKFAST_bm &~MILK_bm|FANTA_bm
  .equ TABLETT_bm, FRUITS_bm
  ldr r3,=TABLETT_bm << 16 | TABLETT_bm |MILK_bm //tablett wird mit << 16 in das high half word geschoben
  ldr r4,=BREAKFAST_bm & ~MILK_bm & ~CHEESE_bm
stop:
	nop
	bal stop

.end
