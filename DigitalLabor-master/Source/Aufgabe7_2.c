/*
 * Aufgabe_7_2.S
 *
 *	Aufgabe : GPIO in C
 */
#include <stdint.h>
//#include "Aufgabe7_2.h"
#include "LPC21XX.H"

#define DELAY_TIME_2_3 2000000
#define INIT_MASKE (0xff << 16) //maske für 8 pins 16 bits verschieben um bit 16 bis 23 zu beschreiben

void delay (int delayTime){
  while (delayTime > 0){
  delayTime--;
  }
}

int main(void) {
  //alle leds als ausgang setzen
  IODIR1 = INIT_MASKE;
    
  //dauerschleife
  while (1){
  // maske für einzelne leds setzen
  int maske = (0b1 << 16);

  //schleife für acht leds 
  for(int loopCount = 0; loopCount< 8; loopCount++){
  IOSET1 = maske; //aktuelle led auf an setzen

  delay(DELAY_TIME_2_3); //delay für 2/3

  IOCLR1 = maske; //aktuelle led aus setzen
  
  maske = maske << 1; //maske auf die nächste led schieben
  }
    }
}
