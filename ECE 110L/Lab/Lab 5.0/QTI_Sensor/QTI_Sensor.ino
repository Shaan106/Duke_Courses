//Pins for QTI connections on board
#define lineSensor1 51 



void setup() {
  Serial.begin(9600); //start the serial monitor so we can view the output
}
void loop() {
  int qti1 = rcTime(lineSensor1); 
  delay(200);
  Serial.println(qti1);  
}

//Defines funtion 'rcTime' to read value from QTI sensor
// From Ch. 6 Activity 2 of Robotics with the BOE Shield for Arduino
long rcTime(int pin)
{
  pinMode(pin, OUTPUT);    // Sets pin as OUTPUT
  digitalWrite(pin, HIGH); // Pin HIGH
  delay(1);                // Waits for 1 millisecond
  pinMode(pin, INPUT);     // Sets pin as INPUT
  digitalWrite(pin, LOW);  // Pin LOW
  long time = micros();    // Tracks starting time
  while(digitalRead(pin)); // Loops while voltage is high
  time = micros() - time;  // Calculate decay time
  return time;             // Return decay time
}