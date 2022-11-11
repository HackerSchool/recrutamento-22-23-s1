
#define lblue     5
#define lgreen    6
#define lyellow   7
#define lred      8

#define bblue     9
#define bgreen    10
#define byellow   11
#define bred      12

#define levels 60

int level[levels];

void setup() {
  // put your setup code here, to run once:
  pinMode (lblue, OUTPUT);
  pinMode (lgreen, OUTPUT);
  pinMode (lyellow, OUTPUT);
  pinMode (lred, OUTPUT);

  digitalWrite (lblue, LOW);
  digitalWrite (lgreen, LOW);
  digitalWrite (lyellow, LOW);
  digitalWrite (lred, LOW);

  pinMode(bblue, INPUT_PULLUP);
  pinMode(bgreen, INPUT_PULLUP);
  pinMode(byellow, INPUT_PULLUP);
  pinMode(bred, INPUT_PULLUP);

  randomSeed(analogRead(0));

  for (int i=0; i<levels+1; i++){
    level[i] = random(5,9);
  }
  
}

void loop() {
    int i=0;
    int g=0;
    int j=0;
    int bb=1;
    int bg=1;
    int by=1;
    int br=1;

    int b=0;
  // put your main code here, to run repeatedly:
  bool game_over = 0;
  digitalWrite(lblue, HIGH);
  digitalWrite(lyellow, HIGH);
  digitalWrite(lgreen, HIGH);
  digitalWrite(lred, HIGH);

  delay (500);

  digitalWrite(lblue, LOW);
  digitalWrite(lyellow, LOW);
  digitalWrite(lgreen, LOW);
  digitalWrite(lred, LOW);

    delay(500);

  while (game_over == 0){


    for(i=1; i<levels+1; i++){

      for (g = 0; g < i; g++) {                               //dá a sequencia do nível
        if (level[g]==5){
          digitalWrite(lblue, HIGH);
          delay(200);
          digitalWrite(lblue, LOW);
          delay(500);
        }
        if (level[g]==6){
          digitalWrite(lgreen, HIGH);
          delay(200);
          digitalWrite(lgreen, LOW);
          delay(500);
        }
        if (level[g]==7){
          digitalWrite(lyellow, HIGH);
          delay(200);
          digitalWrite(lyellow, LOW);
          delay(500);
        }
        if (level[g]==8){
          digitalWrite(lred, HIGH);
          delay(200);
          digitalWrite(lred, LOW);
          delay(500);
        }

      }

      for (g=0; g<i; g++){
        bb=1;
        bg=1;
        by=1;
        br=1;

        b=0;

        while (bb == HIGH && by == HIGH && bg == HIGH && br == HIGH) {                          //esperar até primir um botão
          bb = digitalRead(bblue);
          by = digitalRead(byellow);
          bg = digitalRead(bgreen);
          br = digitalRead(bred);
        }

        delay (200);

        if (bb == 0){
          b=5;
        }
        else if (bg == 0){
          b=6;
        }
        else if (by == 0){
          b=7;
        }
        else if (br == 0){
          b=8;
        }

        digitalWrite(b, HIGH);
        delay (200);
        digitalWrite(b,LOW);
        delay (50);

        if(b!=level[g]){
          for (j=0; j<5; j++){
            digitalWrite(lblue, HIGH);
            digitalWrite(lyellow, HIGH);
            digitalWrite(lgreen, HIGH);
            digitalWrite(lred, HIGH);

            delay (500);

            digitalWrite(lblue, LOW);
            digitalWrite(lyellow, LOW);
            digitalWrite(lgreen, LOW);
            digitalWrite(lred, LOW);

            delay (500);

            game_over=1;

          }
        }
      }
      delay (1000);
    }
  }
}