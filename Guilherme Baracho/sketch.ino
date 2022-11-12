#include <Servo.h>
int switchState[5];
Servo myServo;
int r = 0;
int score = 0;
int time;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(12,OUTPUT);
  pinMode(11,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(8,OUTPUT);
  pinMode(7,INPUT);
  pinMode(6,INPUT);
  pinMode(5,INPUT);
  pinMode(4,INPUT);
  pinMode(3,INPUT);
  myServo.attach(2);
  for (int i = 0; i < 5; i++) {
    switchState[i] = 0;
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  time = 1000;
  r = random(8,13);
  digitalWrite(r,HIGH);

  while(true){
    for (int i = 0; i < 5; i++) {
      switchState[i] = digitalRead(i+3);
    }
    if (switchState[r-8] == HIGH) {
      score++;
      break;
    }
    delay(10);
    time = time - 10;
    if(time <= 0){
      break;
    }
  }
  delay(time);
  


  for (int i = 0; i < 5; i++) {
    digitalWrite(i+8, LOW);
  }

  if (score >= 10) {
    myServo.write(map(0, 0, 1023, 0, 179));
    delay(100);
    exit(0);
  }
  delay(100);
}
