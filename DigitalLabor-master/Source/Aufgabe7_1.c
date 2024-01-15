/*
 * Aufgabe_7_1.S
 *
 *  Created on: <08.01.2024>
 *      Author: <Torben Lamers>
 *
 *	Aufgabe : Bitmanipulation in C
 */
#include <stdint.h>
#include "Aufgabe7_1.h"


int main(void) {
    //Ausgehend von CONSTANT_A
    //value_a
    //8bit variable enthält den wert des 3. nibble
    uint8_t value_a = (CONSTANT_A >> 8) & 0xF; // schiebe nibble n0 und n1 "rechts raus" 
    
    //value_b
    //binär inverser wert
    uint32_t value_b = ~CONSTANT_A;
    
    //value_c
    //höchster nibble invertiert rest unverändert
    uint32_t value_c = CONSTANT_A ^ 0xf0000000; // xor mit dem höchsten nibble invertiert diesen der rest bleibt unverändert
    
    //value_d
    //alle bits auf "1" bis auf nibble 2 und 3
    uint32_t value_d = CONSTANT_A | ~0x0000ff00; //or mit der inversen maske um alle bits außer nibble 2 und 3 auf 1 zu setzen
    
    //Ausgehend von CONSTANT_HIGH und CONSTANT_LOW
    
    //8 bit low und high in 16 bit in big endian anordnung
    uint16_t big_endian_variable_8_8 = CONSTANT_LOW | (CONSTANT_HIGH << 8);
    
    //16 bit low und high in big endian anordnung
    uint32_t big_endian_variable_16_16 = CONSTANT_LOW | (CONSTANT_HIGH << 16);
    
    //8 bit low und high in 16 bit in little endian anordnung
    uint16_t little_endian_variable_8_8 = (CONSTANT_LOW << 8) | CONSTANT_HIGH;
}
