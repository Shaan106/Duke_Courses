#include <SoftwareSerial.h>

#define TxPin 14

SoftwareSerial mySerial = SoftwareSerial(255, TxPin);

#define num 17

#include <Wire.h> // I2C library, required for MLX90614
#include <SparkFunMLX90614.h> //Click here to get the library: http://librarymanager/All#Qwiic_IR_Thermometer by SparkFun

IRTherm therm; // Create an IRTherm object to interact with throughout

int durs[num]  = {211, 211, 211, 210, 210, 211, 211, 211, 211, 211, 211, 211, 210, 210, 211, 211, 212};


int octs[num]  = {216, 216, 216, 216, 216, 216, 215, 216, 216, 216, 216, 216, 216, 216, 216, 215, 216};

int notes[num] = {220, 220, 220, 220, 220, 220, 224, 232, 220, 220, 220, 220, 220, 220, 220, 224, 232};

void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
  delay(100);
  mySerial.write(12); // clear
  delay(10);
  mySerial.write(22); // no cursor no blink
  delay(10);
  mySerial.write(17); // backlight
  delay(10);
  // mySerial.print("Super Mario");
  // mySerial.write(13);
  // mySerial.print("Brothers!");


  Wire.begin(); //Joing I2C bus
  
  if (therm.begin() == false){ // Initialize thermal IR sensor
    Serial.println("Qwiic IR thermometer did not acknowledge! Freezing!");
    while(1);
  }
  Serial.println("Qwiic IR Thermometer did acknowledge.");
  
  therm.setUnit(TEMP_F); // Set the library's units to Farenheit (sic)
  // Alternatively, TEMP_F can be replaced with TEMP_C for Celsius or
  // TEMP_K for Kelvin.
  
  pinMode(LED_BUILTIN, OUTPUT); // LED pin as output

  // for(long k=0; k<num; k++){
    
  //   mySerial.write(durs[k]); mySerial.write(octs[k]); mySerial.write(notes[k]);
  //   int len = 214 - durs[k];
  //   float del = 2000 / pow(2, len);
  //   delay(int(del*1.1));
  // }

}

void loop() {

  digitalWrite(LED_BUILTIN, HIGH);
    
  // Call therm.read() to read object and ambient temperatures from the sensor.
  if (therm.read()) // On success, read() will return 1, on fail 0.
  {
    // Use the object() and ambient() functions to grab the object and ambient
	// temperatures.
	// They'll be floats, calculated out to the unit you set with setUnit().
    mySerial.print("Object: " + String(therm.object(), 2));
    mySerial.println("F");
    // mySerial.print("Ambient: " + String(therm.ambient(), 2));
    // mySerial.println("F");
    mySerial.println();
  }

  if (therm.object() < 50) {
    for(long k=0; k<num; k++){
      mySerial.write(durs[k]); mySerial.write(octs[k]); mySerial.write(notes[k]);
      int len = 214 - durs[k];
      float del = 2000 / pow(2, len);
      delay(int(del*1.1));
    }
  }

  digitalWrite(LED_BUILTIN, LOW);
  delay(10000);

}