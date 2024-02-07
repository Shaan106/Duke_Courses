// Based on colorview.ino from Adafruit_TCS34725 library
// Simplified and modified to work with CX-Bot

#include "Adafruit_TCS34725.h"
#define redpin 45
#define greenpin 46
#define bluepin 44


// Initialize color sensor
Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_50MS, TCS34725_GAIN_4X);

void setup() {

  pinMode(redpin, OUTPUT);
  pinMode(greenpin, OUTPUT);
  pinMode(bluepin, OUTPUT);

  Serial.begin(9600);
  Serial.println("Sensor Test!");

  if (tcs.begin()) {
    Serial.println("Found sensor");
  } else {
    Serial.println("No TCS34725 found ... check your connections");
    while (1); // halt!
  }
}

void loop() {
  float red, green, blue;

  delay(60);  // takes 50ms to read
  tcs.getRGB(&red, &green, &blue);

  analogWrite(redpin, 255 - int(red));
  analogWrite(greenpin, 255 - int(green));
  analogWrite(bluepin, 255 - int(blue));
  delay(100);

  Serial.print("R:\t"); Serial.print(int(red)); 
  Serial.print("\tG:\t"); Serial.print(int(green)); 
  Serial.print("\tB:\t"); Serial.print(int(blue));
  Serial.print("\n");
}