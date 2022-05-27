#include <WiFi.h>

#define XAXIS 33
#define YAXIS 32
#define BUTTON 21
#define RED_BUTTON 26
#define GREEN_BUTTON 25

const char *ssid = "ssid";
const char *pw = "password";



WiFiServer server(80);

void setup() {
  Serial.begin(9600);
  pinMode (BUTTON, INPUT_PULLUP);
  pinMode (RED_BUTTON, INPUT_PULLUP);
  pinMode (GREEN_BUTTON, INPUT_PULLUP);

  delay(1000);

  WiFi.begin(ssid, pw);
  Serial.print("Conectando.");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");


  }
  Serial.print("\n");
  Serial.print("Conectado ao IP: ");
  Serial.print(WiFi.localIP());

  server.begin();



}

void loop() {




  WiFiClient client = server.available();
  if (client) {
    while (client.connected()) {



      int x_axis = analogRead(XAXIS);
      int y_axis = analogRead(YAXIS);

      x_axis = map(x_axis, 0, 4095, 0, 2);
      y_axis = map(y_axis, 0, 4095, 0, 2);

      const char* X = joystickUpdateAxis_X(x_axis);
      const char* Y = joystickUpdateAxis_Y(y_axis);
      const char* Botao = joystickUpdateButton(BUTTON);
      const char* BotaoVermelho = joystickUpdateButton(RED_BUTTON);
      const char* BotaoVerde = joystickUpdateButton(GREEN_BUTTON);



      client.print(X);
      client.print(Y);
      client.print(Botao);
      client.print(BotaoVermelho);
      client.print(BotaoVerde);
      client.print("\n");

      Serial.print(X);
      Serial.print(Y);
      Serial.print(Botao);
      Serial.print(BotaoVermelho);
      Serial.println(BotaoVerde);

      delay(150);
    }
  }

}

const char* joystickUpdateAxis_X(int eixo_X) {
  const char* joystickController;
  switch (eixo_X) {
    case 2:
      joystickController = "Up-";
      break;
    case 0:
      joystickController = "Down-";
      break;
    default:
      joystickController = "Idle-";
      break;
  }
  return joystickController;
}

const char* joystickUpdateAxis_Y(int eixo_Y) {
  const char* joystickController;
  switch (eixo_Y) {
    case 2:
      joystickController = "Right-";
      break;
    case 0:
      joystickController = "Left-";
      break;
    default:
      joystickController = "Idle-";
      break;
  }
  return joystickController;
}

const char* joystickUpdateButton(int botao) {
  const char* joystickController;
  if (digitalRead(botao) == LOW) {
    joystickController = "1-";
  } else {
    joystickController = "0-";
  }
  return joystickController;
}
