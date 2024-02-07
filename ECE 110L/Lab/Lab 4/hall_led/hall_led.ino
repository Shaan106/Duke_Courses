// parts - two resistors, a red LED, a green LED, an A1324 Hall effect sensor, and wires as needed.

const int Hall_In = 0;
const float VCC = 5.0;
const float Hall_sensitivity = 0.005; // 5 mV/G

#define RED 6
#define GRN 2

void setup() {
  pinMode(RED, OUTPUT);
  pinMode(GRN, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  float Hall_Reading = analogRead(Hall_In);
  float Hall_Voltage = Hall_Reading * 5.0 / 1023.0;
  float Hall_Gauss = (Hall_Voltage - (VCC/2)) / 0.005;

  if (Hall_Gauss > 200) {
    digitalWrite(RED, HIGH);
    digitalWrite(GRN, LOW);
  } else if (Hall_Gauss < -200) {
    digitalWrite(RED, LOW);
    digitalWrite(GRN, HIGH);
  } else {
    digitalWrite(RED, LOW);
    digitalWrite(GRN, LOW);
  }


  Serial.print("Analog reading = ");
  Serial.print(Hall_Reading);
  Serial.print(" ");
  Serial.print("Analog voltage = ");
  Serial.print(Hall_Voltage);
  Serial.print(" ");
  Serial.print("Hall_Gauss = ");
  Serial.println(Hall_Gauss);
  delay(100);
}