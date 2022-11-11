

int index = 0;                                        //onde na matriz de leds ta
int leds[] = {3, 4, 5, 6, 7, 8, 9, 10, 11 };          //ports das leds

bool Simbolo = false;                                 //pôr simbolo = carregar no botao 2
bool end_game = false;                                //acabar jogo

int P1[] = {20,21,22,23,24};                          //vetores para por a localizaçao (index) das leds dos jogadores
int P2[] = {30,31,32,33,34};

int VecIndex = 0;                                     //index dos vetores
int player = 1;
int jogada = 0;                                            

void setup()
{
  Serial.begin(9600);

  pinMode(12, INPUT);
  pinMode(13, INPUT);

  for (int n=0; n < 9; n++) pinMode(leds[n], OUTPUT);
}
 
int botao1(int pos){
  int BotaoPremido = 0;
  BotaoPremido = digitalRead(12);

  if (BotaoPremido != 0){
    if(pos == 8){
      pos = 0;
    }
    else{
      pos++; 
    }
        
    while (in(P1, pos) || in(P2, pos)){
      pos++;
    }
    BotaoPremido = 0;
  }
  return pos;
}

bool botao2(int pos, int player, int id, int jogada){
  int BotaoPremido = 0;
  BotaoPremido = digitalRead(13);
  
  if (BotaoPremido !=0) {
    
    if (!in(P1, pos) && !in(P2, pos) && jogada < 9){
      
      if (player == 1){
        P1[id] = pos;
      }
      if (player == 2){
        P2[id] = pos;
      }
      return true;
    } 
    BotaoPremido = 0;
  }
  return false;
}

bool in(int vec[], int pos){
  int n = 0;
  while(n < 5) {
    if (vec[n] == pos) {
      return true;
    }
    n++;
  }
  return false;
}

bool check_win(int vec[]){
  if (in(vec, 0) && in(vec, 1) && in(vec, 2)){
    return true;
  }  else if (in(vec, 3) && in(vec, 4) && in(vec, 5)){
    return true;
  }  else if (in(vec, 6) && in(vec, 7) && in(vec, 8)){
    return true;
  }  else if (in(vec, 0) && in(vec, 3) && in(vec, 6)){
    return true;
  }  else if (in(vec, 1) && in(vec, 4) && in(vec, 7)){
    return true;
  }  else if (in(vec, 2) && in(vec, 5) && in(vec, 8)){
    return true;
  }  else if (in(vec, 0) && in(vec, 4) && in(vec, 8)){
    return true;
  }  else if (in(vec, 2) && in(vec, 4) && in(vec, 6)){
    return true;
  }  else return false;
}

void loop(){
  

  for (int i=0; i<5; i++){
    digitalWrite(P1[i]+3, LOW);
  } 
  
  delay(200);
  
  digitalWrite(leds[index], LOW);
  
  for (int i=1; i <3 ; i++) {
    for (int j = 0;j < 5; j++){
      digitalWrite(P1[j]+3, HIGH);
    }
   delay(200);
    for (int j = 0; j <5; j++){
    digitalWrite(P1[j]+3, LOW);
    }
  }


  if (!end_game){
    index = botao1(index);
    Simbolo = botao2(index, player, VecIndex, jogada);
  
    if (Simbolo){
      if (player == 1){
        player = 2;
      }
      else if (player == 2){
       player = 1;
       VecIndex++;
      }
    jogada++;
    }
  }

  delay(200);
  for (int i = 0; i <5; i++){
    digitalWrite(P1[i]+3, HIGH);
    digitalWrite(P2[i]+3, HIGH);
  }

  if(index == 9) index = 0;

  while (in(P1, index) || in(P2, index)){
    index++;
  }

  digitalWrite(leds[index], HIGH);
  delay(200);
  
  if (check_win(P1) || check_win(P2)){
    end_game = true;
  }

  if (digitalRead(12) == HIGH  && digitalRead(13) == HIGH){
    digitalWrite(leds[index], LOW);
    index = 0;
    for (int i = 0; i<5; i++){
      digitalWrite(P1[i]+3, LOW);
      digitalWrite(P2[i]+3, LOW);
      P1[i] = 20;
      P2[i] = 30;
    }
    delay (3000);
  }

}