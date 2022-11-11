int vermelho = 0;
int verde = 0;
int azul = 0;

void setup() {
  Serial.begin(9600);
  pinMode(A1, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  

}

void loop() {
  digitalWrite(A1, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, HIGH);
  digitalWrite(7, HIGH);
  delay(100);
  vermelho = 256*analogRead(A1)/10;
  delay(300);
  digitalWrite(A1, LOW);
  digitalWrite(6, LOW);
  digitalWrite(5, HIGH);
  digitalWrite(7, HIGH);
  delay(100);
  verde = 256*analogRead(A1)/10;
  delay(300);
  digitalWrite(A1, LOW);
  digitalWrite(7, LOW);
  digitalWrite(6, HIGH);
  digitalWrite(5, HIGH);
  delay(100);
  azul = 256*analogRead(A1)/10;
  delay(300);
  Serial.print(vermelho);
  Serial.print(", ");
  Serial.print(verde);
  Serial.print(", ");
  Serial.println(azul);

}
