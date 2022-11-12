#include <Joystick.h>

#define joyThrottle A3
#define joyButton1 13
#define joyButton2 12
#define joyButton3 11
#define joyButton4 10
#define joyButton5 9
#define joyButton6 8
#define joyButton7 2

Joystick_ Joystick(0x15, JOYSTICK_TYPE_JOYSTICK, 7, 0, false, false, false, false, false, false, false, true, false, false, false);
const bool initAutoSendState = true;

int throttle_ = 0;
int lastButton1State = 0;
int lastButton2State = 0;
int lastButton3State = 0;
int lastButton4State = 0;
int lastButton5State = 0;
int lastButton6State = 0;
int lastButton7State = 0;

void setup() {
  // put your setup code here, to run once:
pinMode(joyButton1, INPUT_PULLUP);
pinMode(joyButton2, INPUT_PULLUP);
pinMode(joyButton3, INPUT_PULLUP);
pinMode(joyButton4, INPUT_PULLUP);
pinMode(joyButton5, INPUT_PULLUP);
pinMode(joyButton6, INPUT_PULLUP);
pinMode(joyButton7, INPUT_PULLUP);

pinMode(4,OUTPUT);
pinMode(5,OUTPUT);
pinMode(6,OUTPUT);

digitalWrite(joyButton1,HIGH);
digitalWrite(joyButton2,HIGH);
digitalWrite(joyButton3,HIGH);
digitalWrite(joyButton4,HIGH);
digitalWrite(joyButton5,HIGH);
digitalWrite(joyButton6,HIGH);
digitalWrite(joyButton7,HIGH);

digitalWrite(4,LOW);
  digitalWrite(5,LOW);
  digitalWrite(6,LOW);
  
Joystick.begin();

}

void loop() {
  // put your main code here, to run repeatedly:
  //Axis Runtime
  throttle_ = analogRead(joyThrottle);
  throttle_ = map(throttle_, 0, 1023., 0, 2047);
  Joystick.setThrottle(throttle_);
  
    
  int currentButton1State = !digitalRead(joyButton1);
  if (currentButton1State != lastButton1State){
    digitalWrite(4,HIGH);
    digitalWrite(5,LOW);
    digitalWrite(6,LOW);
    Joystick.setButton(0,currentButton1State);
    lastButton1State = currentButton1State;
  }
  
  int currentButton2State = !digitalRead(joyButton2);
  if (currentButton2State != lastButton2State){
    digitalWrite(4,LOW);
    digitalWrite(5,HIGH);
    digitalWrite(6,LOW);
    Joystick.setButton(1,currentButton2State);
    lastButton2State = currentButton2State;
  }
  
  int currentButton3State = !digitalRead(joyButton3);
  if (currentButton3State != lastButton3State){
    digitalWrite(4,HIGH);
    digitalWrite(5,HIGH);
    digitalWrite(6,LOW);
    Joystick.setButton(2,currentButton3State);
    lastButton3State = currentButton3State;
  }

  int currentButton4State = !digitalRead(joyButton4);
  if (currentButton4State != lastButton4State){
    digitalWrite(4,LOW);
    digitalWrite(5,LOW);
    digitalWrite(6,HIGH);
    Joystick.setButton(3,currentButton4State);
    lastButton4State = currentButton4State;
  }
  
  int currentButton5State = !digitalRead(joyButton5);
  if (currentButton5State != lastButton5State){
    digitalWrite(4,HIGH);
    digitalWrite(5,LOW);
    digitalWrite(6,HIGH);
    Joystick.setButton(4,currentButton5State);
    lastButton5State = currentButton5State;
  }
  
  int currentButton6State = !digitalRead(joyButton6);
  if (currentButton6State != lastButton6State){
    digitalWrite(4,LOW);
    digitalWrite(5,HIGH);
    digitalWrite(6,HIGH);
    Joystick.setButton(5,currentButton6State);
    lastButton6State = currentButton6State;
  }

  int currentButton7State = !digitalRead(joyButton7);
  if (currentButton7State != lastButton7State){
    digitalWrite(4,HIGH);
    digitalWrite(5,HIGH);
    digitalWrite(6,HIGH);
    Joystick.setButton(6,currentButton7State);
    lastButton7State = currentButton7State;
  }

delay(0.05 );

  
}
