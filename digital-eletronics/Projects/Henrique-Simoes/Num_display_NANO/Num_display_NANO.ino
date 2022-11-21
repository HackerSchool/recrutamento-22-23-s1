int d1 = 13;
int A = 2;
int B = 4;
int C = 7;
int D = 6;
int E = 5;
int F = 3;
int G = 8;
int OutB = A4;
int bit0;
int bit1;
int bit2;

void setup() {
  // put your setup code here, to run once:
pinMode(d1,OUTPUT);
pinMode(A,OUTPUT);
pinMode(B,OUTPUT);
pinMode(C,OUTPUT);
pinMode(D,OUTPUT);
pinMode(E,OUTPUT);
pinMode(F,OUTPUT);
pinMode(G,OUTPUT);
pinMode(10,INPUT);
pinMode(11,INPUT);
pinMode(12,INPUT);
digitalWrite (d1,LOW);
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
bit0 = digitalRead(10);
bit1 = digitalRead(11);
bit2 = digitalRead(12);
if (bit0 && !(bit1) && !(bit2))
  one();
else if (!(bit0) && bit1 && !(bit2))
  two();

else if (bit0 && bit1 && !(bit2))
  three();
else if (!(bit0) && !(bit1) && bit2)
  four();
else if (bit0 && !(bit1) && bit2)
  five();
else if (!(bit0) && bit2 && bit2)
  six();
else if (bit0 && bit1 && bit2)
  rear();
else
  zero();
delay(0.05);
}
void zero(){
  digitalWrite(A,LOW);
  digitalWrite(B,LOW);
  digitalWrite(C,LOW);
  digitalWrite(D,LOW);
  digitalWrite(E,LOW);
  digitalWrite(F,LOW);
  digitalWrite(G,LOW);
}

void one(){
  digitalWrite(A,LOW);
  digitalWrite(B,HIGH);
  digitalWrite(C,HIGH);
  digitalWrite(D,LOW);
  digitalWrite(E,LOW);
  digitalWrite(F,LOW);
  digitalWrite(G,LOW);
}
void two(){
  digitalWrite(A,HIGH);
  digitalWrite(B,HIGH);
  digitalWrite(C,LOW);
  digitalWrite(D,HIGH);
  digitalWrite(E,HIGH);
  digitalWrite(F,LOW);
  digitalWrite(G,HIGH);
}
void three(){
  digitalWrite(A,HIGH);
  digitalWrite(B,HIGH);
  digitalWrite(C,HIGH);
  digitalWrite(D,HIGH);
  digitalWrite(E,LOW);
  digitalWrite(F,LOW);
  digitalWrite(G,HIGH);
}
void four(){
  digitalWrite(A,LOW);
  digitalWrite(B,HIGH);
  digitalWrite(C,HIGH);
  digitalWrite(D,LOW);
  digitalWrite(E,LOW);
  digitalWrite(F,HIGH);
  digitalWrite(G,HIGH);
}
void five(){
  digitalWrite(A,HIGH);
  digitalWrite(B,LOW);
  digitalWrite(C,HIGH);
  digitalWrite(D,HIGH);
  digitalWrite(E,LOW);
  digitalWrite(F,HIGH);
  digitalWrite(G,HIGH);
}
void six(){
  digitalWrite(A,HIGH);
  digitalWrite(B,LOW);
  digitalWrite(C,HIGH);
  digitalWrite(D,HIGH);
  digitalWrite(E,HIGH);
  digitalWrite(F,HIGH);
  digitalWrite(G,HIGH);
}
void rear(){
  digitalWrite(A,HIGH);
  digitalWrite(B,HIGH);
  digitalWrite(C,HIGH);
  digitalWrite(D,LOW);
  digitalWrite(E,HIGH);
  digitalWrite(F,HIGH);
  digitalWrite(G,HIGH);
}
