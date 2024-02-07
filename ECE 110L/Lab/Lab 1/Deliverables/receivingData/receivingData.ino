// Define pins for built-in RGB LED
#define redpin 45
#define greenpin 46
#define bluepin 44

void setup() {
  Serial.begin(9600); // initialize serial monitor 
  Serial2.begin(9600); // initialize Xbee Tx/Rx 
  // Set pin modes
  pinMode(redpin, OUTPUT);
  pinMode(greenpin, OUTPUT);
  pinMode(bluepin, OUTPUT);

  // start with light off
  analogWrite(redpin, 255);
  analogWrite(greenpin, 255);
  analogWrite(bluepin, 255);

  delay(500);
}

void loop() {

  if(Serial2.available()) { // Is XBee data available? 
    char incoming = Serial2.read(); // Read character 
    Serial.println(incoming); // Send to serial monitor

    delay(100);

    // Make bright red
    analogWrite(redpin, 0);
    analogWrite(greenpin, 0);
    analogWrite(bluepin, 0);

    delay(100);

    // Turn all off
    analogWrite(redpin, 255);
    analogWrite(greenpin, 255);
    analogWrite(bluepin, 255);
  }

  delay(50); 
}