int LDRPin = A0;     
int threshold = 500; 

#include "pitches.h"

int melody[] = {
  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
};


// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 8, 8, 4, 4, 4, 4, 4
};

int melody1[] = {
  NOTE_E7, NOTE_E7, 0, NOTE_E7,
  0, NOTE_C7, NOTE_E7, 0,
  NOTE_G7, 0, 0,  0,
  NOTE_G6, 0, 0, 0,

  NOTE_C7, 0, 0, NOTE_G6,
  0, 0, NOTE_E6, 0,
  0, NOTE_A6, 0, NOTE_B6,
  0, NOTE_AS6, NOTE_A6, 0,

  NOTE_G6, NOTE_E7, NOTE_G7,
  NOTE_A7, 0, NOTE_F7, NOTE_G7,
  0, NOTE_E7, 0, NOTE_C7,
  NOTE_D7, NOTE_B6, 0, 0,

  NOTE_C7, 0, 0, NOTE_G6,
  0, 0, NOTE_E6, 0,
  0, NOTE_A6, 0, NOTE_B6,
  0, NOTE_AS6, NOTE_A6, 0,

  NOTE_G6, NOTE_E7, NOTE_G7,
  NOTE_A7, 0, NOTE_F7, NOTE_G7,
  0, NOTE_E7, 0, NOTE_C7,
  NOTE_D7, NOTE_B6, 0, 0
};

int tempo1[] = {
  12, 12, 12, 12,
  12, 12, 12, 12,
  12, 12, 12, 12,
  12, 12, 12, 12,

  12, 12, 12, 12,
  12, 12, 12, 12,
  12, 12, 12, 12,
  12, 12, 12, 12,

  9, 9, 9,
  12, 12, 12, 12,
  12, 12, 12, 12,
  12, 12, 12, 12,

  12, 12, 12, 12,
  12, 12, 12, 12,
  12, 12, 12, 12,
  12, 12, 12, 12,

  9, 9, 9,
  12, 12, 12, 12,
  12, 12, 12, 12,
  12, 12, 12, 12,
};


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  randomSeed(analogRead(0));

  //pinMode(3, INPUT_PULLUP);
  // put your main code here, to run repeatedly:
  //bool button = digitalRead(8);
  //Serial.println(button);
  
  Serial.println("=======================WELCOME TO THE LIGHT MACHINE======================");
  int size = sizeof(melody1) / sizeof(int);

    for (int thisNote = 0; thisNote < size; thisNote++) {
      int rnd = random(4,9);
      int noteDuration = 1000 / tempo1[thisNote];

      tone(9, melody1[thisNote], noteDuration);
      digitalWrite(rnd, HIGH);
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
      
      tone(9, 0, noteDuration);
      digitalWrite(rnd, LOW);

    }
 ;
  Serial.println("==IF YOU LIGHT UP THREE CONSECUTIVE LEDS, YOU WIN. OTHERWISE, YOU LOSE.==");
  delay(3000);
  Serial.println("=========Touch the sensor for a few seconds if you want to play==========");
  delay(6000);
  int input = analogRead(LDRPin);
  if(input > threshold){
    Serial.println("=======================FIRST ROUND=======================================");
    delay(1000);
    tone(9,NOTE_E5);
    delay(500);
    tone(9,NOTE_D5);
    delay(500);
    noTone(9);
    delay(500);
    Serial.println("=======================THE FIRST COLOR IS================================");
    int led1 = random(4,9);
    tone(9,NOTE_B5);
    delay(1000);
    noTone(9);
    digitalWrite(led1, HIGH);
    delay(1500);
    digitalWrite(led1, LOW);
    delay(1000);
    digitalWrite(led1, HIGH);
    delay(1500);
    digitalWrite(led1, LOW);
    delay(2000);
    Serial.println("=======================SECOND ROUND======================================");
    delay(1000);
    tone(9,NOTE_E5);
    delay(500);
    tone(9,NOTE_D5);
    delay(500);
    noTone(9);
    delay(500);
    Serial.println("=======================THE SECOND COLOR IS===============================");
    int led2 = random(4,9);
    tone(9,NOTE_B5);
    delay(1000);
    noTone(9);
    digitalWrite(led2, HIGH);
    delay(1500);
    digitalWrite(led2, LOW);
    delay(1000);
    digitalWrite(led2, HIGH);
    delay(1500);
    digitalWrite(led2, LOW);
    delay(2000);
    Serial.println("=======================THIRD ROUND=======================================");
    delay(1000);
    tone(9,NOTE_E5);
    delay(500);
    tone(9,NOTE_D5);
    delay(500);
    noTone(9);
    delay(500);
    Serial.println("=======================THE THIRD COLOR IS================================");
    int led3 = random(4,9);
    tone(9,NOTE_B5);
    delay(1000);
    noTone(9);
    digitalWrite(led3, HIGH);
    delay(1500);
    digitalWrite(led3, LOW);
    delay(1000);
    digitalWrite(led3, HIGH);
    delay(1500);
    digitalWrite(led3, LOW);
    delay(2000);
    int min1 = min(led1,led2);
    int min2 = min(led3,led2);
    int min3 = min(min1, min2);
    if(led1+led2+led3==3+min3*3){
      Serial.println("=======================YOU WON===========================================");
        for (int thisNote = 0; thisNote < 8; thisNote++) {
            int noteDuration = 1000 / noteDurations[thisNote];
            tone(9, melody[thisNote], noteDuration);
            int pauseBetweenNotes = noteDuration * 1.30;
            delay(pauseBetweenNotes);
            noTone(9);
          }
      }
     else{
      Serial.println("=======================YOU LOST==========================================");
           tone(9,NOTE_G4);
           delay(250);
           tone(9,NOTE_C4);
           delay(500);
           noTone(9);

  }
  Serial.println("=======================GAME OVER=========================================");
  }
  else{
    
    Serial.println("===================OH WELL... GOODBYE. GAME OVER.========================");
    delay(1000);
  }
}
void loop() {

}
