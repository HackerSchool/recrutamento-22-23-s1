#define VRX_PIN A0                // Analog read from VRX pin
#define VRY_PIN A1                // Analog read from VRY pin
#define SW_PIN  12                // Digital read from SW pin

#define CURSOR_MAX 1000           // Coordinate values obtained from the joystick will range from 0 to this
#define CURSOR_MARGIN 100         // If cursor is off the considered end by no more than this margin, we consider that it moved

#define LED_PIN_MORSE 2           // Pin for the LED that sends the message
#define LED_PIN_CURSOR 3          // Pin for the navigation LED

#define DIT_TIME 200              // Duration of each Morse code unit. One dit (dot) lasts one.
#define PRESS_TIME 1000           // Time for a button press to be considered
#define POSITION_CHANGE_DELAY 200 // Minimum time between two position changes

/* JOYSTICK COORDINATION */
int xValue = 0;                   // X axis (Left: 0, Middle: 500, Right: 1000)
int yValue = 0;                   // Y axis (Top: 0, Middle: 500, Down: 1000)
int swValue = 0;                  // Whether it's pressed down (1: Up [not pressed], 0: Down [pressed])

bool cursor_led_on = false;       // Navigation LED status


/** MORSE CODE CHARACTERS AND COMMANDS
*   This table can be navigated with the joystick
*   Special strings that code subroutines instead of characters are in CAPS
**/
String codes[5][8] = {
  {".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "...."},
  {"..", ".---", "-.-", ".-..", "--", "-.", "---", ".--."},
  {"--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-"},
  {"-.--", "--..", "-----", ".----", "..---", "...--", "....-", "....."},
  {"-....", "--...", "---..", "----.", "/", "ERASE", "CLEAR", "ENTER"}
};

// coordinates where we are in the table
int letter_pos_x = 0;
int letter_pos_y = 0;

// message to be sent, constructed from the various characters
String messageToSend = "";

// index of the last character of the message, to be used for the ERASE subroutine
int last_char_index = 0;


/* FUNCTIONS BEGIN HERE */

void setup() {
  pinMode(LED_PIN_MORSE, OUTPUT);
  pinMode(LED_PIN_CURSOR, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // read analog X and Y analog values and SW digital value, for later processing
  xValue = analogRead(VRX_PIN);
  yValue = analogRead(VRY_PIN);
  swValue = digitalRead(SW_PIN);

  // move within the table according to the joystick
  // (also inverts the navigation LED)
  if(xValue < CURSOR_MARGIN && letter_pos_x > 0){
    letter_pos_x--;
    invertCursorLED();
    Serial.println(codes[letter_pos_y][letter_pos_x]);
  }
  else if(xValue > CURSOR_MAX - CURSOR_MARGIN && letter_pos_x < 7){
    letter_pos_x++;
    invertCursorLED();
    Serial.println(codes[letter_pos_y][letter_pos_x]);
  }
  if(yValue < CURSOR_MARGIN && letter_pos_y > 0){
    letter_pos_y--;
    invertCursorLED();
    Serial.println(codes[letter_pos_y][letter_pos_x]);
  }
  else if(yValue > CURSOR_MAX - CURSOR_MARGIN && letter_pos_y < 4){
    letter_pos_y++;
    invertCursorLED();
    Serial.println(codes[letter_pos_y][letter_pos_x]);
  }

  if(swValue == 0){                                           // if joystick is pressed down...
    delay(PRESS_TIME);                                        // ...we want to first make sure it wasn't an accident by waiting a bit!
    if(digitalRead(SW_PIN) == 0){                             // now yes

      String character = codes[letter_pos_y][letter_pos_x];   // extract from table @ the cursed position of (y,x)

      // Erase last character, if there is one
      if(character == "ERASE"){
        if((last_char_index = messageToSend.length() - 1) != -1){
          while(messageToSend[last_char_index] != ' ' && last_char_index != 0){
            last_char_index--;
          }
          messageToSend.remove(last_char_index);
          Serial.println(messageToSend);
        }
      }

      // Clear message
      else if(character == "CLEAR"){
        messageToSend = "";
        Serial.println(messageToSend);
      }

      // Send message (and don't clear since we might want to repeat it)
      else if(character == "ENTER"){
        blink_morse(messageToSend);
      }

      // Or add more to the message, with an extra space before any new character
      else{
        if(messageToSend != "")
          messageToSend += " ";
        
        messageToSend += character;
        Serial.println(messageToSend);
      }
    }
  }
  delay(POSITION_CHANGE_DELAY);
}

/* SWITCH THE NAVIGATION LED */
void invertCursorLED() {
  if(cursor_led_on)
    digitalWrite(LED_PIN_CURSOR, LOW);  
  else
    digitalWrite(LED_PIN_CURSOR, HIGH);
  
  cursor_led_on = !cursor_led_on;
  Serial.println(cursor_led_on);
}

/** EXECUTE THE MESSAGE 
*   Number of units:
*     Dot: 1
*     Dash: 3
*     Interval in letter: 1
*     Interval between letters in word: 3
*     Interval between words: 7
*/
void blink_morse(String message) {
  for(int i = 0; i < message.length(); i++){
    if(message[i] == '.'){
      blink(DIT_TIME);
    }
    else if(message[i] == '-'){
      blink(3*DIT_TIME);
    }
    else if(message[i] == '/' || message[i] == ' '){
      delay(2*DIT_TIME);
    }
  }
}

/* INDIVIDUAL BLINK */
void blink(int time) {
  digitalWrite(LED_PIN_MORSE, HIGH);
  delay(time);
  digitalWrite(LED_PIN_MORSE, LOW);  
  delay(DIT_TIME);
}