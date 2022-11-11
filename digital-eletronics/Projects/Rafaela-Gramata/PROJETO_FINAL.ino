#define echoPin 2 
#define trigPin 3
#define buzzer 9
#define LED1 7
#define LED2 6
#define LED3 5
#define buttonPin 8

long duration; 
int distance;
int buttonState = 0;


void setup() {
  // put your setup code here, to run once:
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(buzzer, OUTPUT);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  pinMode(buttonPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2;
  Serial.println(distance); 
  buttonState = digitalRead(buttonPin);
  if (distance < 50) {
    if (buttonState == LOW) {
      tone(buzzer, 1000); 
      digitalWrite(LED1, HIGH);   
      digitalWrite(LED2, HIGH);
      digitalWrite(LED3, HIGH);
      delay(1000);        
      noTone(buzzer); 
      digitalWrite(LED1, LOW);    
      digitalWrite(LED2, LOW);
      digitalWrite(LED3, LOW);
      delay(1000);
    }
  }
}
