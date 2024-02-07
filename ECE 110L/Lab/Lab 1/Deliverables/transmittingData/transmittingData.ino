const int buttonPin = 3;  // the number of the pushbutton pin
const int ledPin = 13;    // the number of the LED pin

int buttonState = 0;  // variable for reading the pushbutton status

void setup() {
  Serial.begin(9600); // initialize serial monitor 
  Serial2.begin(9600); // initialize Xbee Tx/Rx 

  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);

  delay(500);
}

void loop() {

  buttonState = digitalRead(buttonPin);

  // check if the pushbutton is pressed. If it is, the buttonState is HIGH:
  if (buttonState == HIGH) {
    Serial.println(buttonState);
    // turn LED on:
    digitalWrite(ledPin, HIGH);

    char outgoing = 'q'; // Read character
    Serial2.print(outgoing); // Send to XBee 
  } else {
    
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }

  // if(Serial2.available()) { // Is XBee data available? 
  // char incoming = Serial2.read(); // Read 
  // char Serial.println(incoming); // Send to serial monitor
  // }

delay(50); 
}