/*
 * Aufgabe_7_3.S
 *
 *	Aufgabe : Umschaltbares Lauflicht
 */
#include <stdint.h>
//#include "Aufgabe7_3.h"
#include "LPC21XX.H"
#include "stdbool.h"

#define DELAY_TIME 2000000
#define INIT_MASKE (0xff << 16) //maske für 8 pins 16 bits verschieben um bit 16 bis 23 zu beschreiben

#define BUTTON0_bm (1 << 10)
#define BUTTON1_bm (1 << 11)
#define BUTTON2_bm (1 << 12)
#define SWAP_BUTTON_bm (BUTTON0_bm | BUTTON1_bm)

void delay (int delayTime){
  while (delayTime > 0){
  delayTime--;
  }
}

int lauflicht(int ledmaske){
  // immer von dem aktuellen lauflicht ausgehend
  if(ledmaske == (0b1 << 24)){ //prüfen ob die maske auf der letzten led steht
  ledmaske = (0b1 << 16); //wenn ja maske auf die erste led setzen
  }
  
  IOSET1 = ledmaske; //aktuelle led auf an setzen
  
  delay(DELAY_TIME); 
  
  IOCLR1 = ledmaske; //aktuelle led aus setzen
  
  ledmaske = ledmaske << 1; //maske auf die nächste led schieben
  
  return ledmaske; //maske für die nächste iteration zurückgeben 
}

int lauflichtAlt(int ledmaske){    
  //immer von dem aktuellen lauflicht ausgehend
  if(ledmaske == (0b1 << 15)){ //prüfe ob die maske auf der letzten led steht
  ledmaske = (0b1 << 23); //wenn ja maske auf die erste led setzen
 }
  
  IOSET1 = ledmaske; //aktuelle led auf an setzen
  
  delay(DELAY_TIME); //delay 100% Phase
  
  IOCLR1 = ledmaske; //aktuelle led aus setzen
  
  ledmaske = ledmaske >> 1; //maske auf die nächste led schieben
  
  return ledmaske; //maske für die nächste iteration zurückgeben
} 

int testeButton(){
//zu erst button 0 und 1 prüfen bevor button 0 geprüft wird da sonst nie "swap" zurückgegeben wird
//Bitmaske von button 0 und 1 verodern und mit IOPIN0 vergleichen
if((IOPIN0 & (BUTTON0_bm | BUTTON1_bm)) == !(BUTTON0_bm |BUTTON1_bm)){return 4;} //swap

//Bitmaske von button 0 mit IOPIN0 vergleichen
if((IOPIN0 & BUTTON0_bm) == !BUTTON0_bm){return 1;} //start

//Bitmaske von button 0 mit IOPIN0 vergleichen
if((IOPIN0 & BUTTON1_bm) == !BUTTON1_bm){return 2;} //pause : continue

//Bitmaske von button 0 mit IOPIN0 vergleichen
if((IOPIN0 & BUTTON2_bm) == !BUTTON2_bm){return 3;} //reset

return 0;
}

int main(void) {

IODIR1 = INIT_MASKE; //alle leds als ausgang definieren
    
    bool pausiert = true; // wenn pausiert = true lauflicht aus
    
    bool lauflichtAuswahl = false; //false == lauflicht ; true == lauflichtAlt
    
    int maske = (0b1 << 16); //bitmaske auf die erste led setzen
    
    while(1){
    
    int button = testeButton(); // prüfen welche button gedrückt ist
        
    if(button == 1){pausiert = false;} //button start

    else if(button == 2){pausiert = !pausiert;} //button pause : continue
    
    else if(button == 3){pausiert = true; maske = (0b1 << 16); IOCLR1 = INIT_MASKE; lauflichtAuswahl = false;} //button reset
    
    else if(button == 4){lauflichtAuswahl = !lauflichtAuswahl;} //button swap lauflicht
    
    if(pausiert == false){

        if(lauflichtAuswahl == true){
    
           //funktion nimmt die bitmaske der aktuellen led entgegen und gibt die aktualisierte bitmaske zurück
           maske = lauflichtAlt(maske); 
    
        }else{
    
           //funktion nimmt die bitmaske der aktuellen led entgegen und gibt die aktualisierte bitmaske zurück
           maske = lauflicht(maske);}
        
    }else{delay(DELAY_TIME);}
        
}
}