#define XAXIS 33
#define YAXIS 32
#define BUTTON 14
#define RED_BUTTON 26
#define GREEN_BUTTON 25

void setup() {
  Serial.begin(9600);
  pinMode (BUTTON, INPUT_PULLUP);
  pinMode (RED_BUTTON, INPUT_PULLUP);
  pinMode (GREEN_BUTTON, INPUT_PULLUP);

}

void loop() {
  int x_axis = analogRead(XAXIS);
  int y_axis = analogRead(YAXIS);

  x_axis = map(x_axis, 0, 4095, 0, 2);
  y_axis = map(y_axis, 0, 4095, 0, 2);

  const char* X = joystickUpdateAxis_X(x_axis);
  const char* Y = joystickUpdateAxis_Y(y_axis);
  const char* btn = joystickUpdateButton(BUTTON);
  const char* btn_red = joystickUpdateButton(RED_BUTTON);
  const char* btn_green = joystickUpdateButton(GREEN_BUTTON);
  
  Serial.print(X);
  Serial.print(Y);
  Serial.print(btn);
  Serial.print(btn_red);
  Serial.println(btn_green);

  delay(50);
  
}

const char* joystickUpdateAxis_X(int eixo_X) {
  const char* joystickController;
  switch (eixo_X) {
    case 2:
      joystickController = "1.";
      break;
    case 0:
      joystickController = "-1.";
      break;
    default:
      joystickController = "0.";
      break;
  }
  return joystickController;
}

const char* joystickUpdateAxis_Y(int eixo_Y) {
  const char* joystickController;
  switch (eixo_Y) {
      case 2:
        joystickController = "1.";
        break;
      case 0:
        joystickController = "-1.";
        break;
      default:
        joystickController = "0.";
        break;
    }
   return joystickController;
}

const char* joystickUpdateButton(int btn) {
  const char* joystickController;
  if (digitalRead(btn) == LOW) {
    joystickController = "1.";
  } else {
    joystickController = "0.";
  }
  return joystickController;
}
