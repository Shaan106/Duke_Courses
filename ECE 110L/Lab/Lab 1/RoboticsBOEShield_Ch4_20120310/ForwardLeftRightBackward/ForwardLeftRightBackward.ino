// Robotics with the BOE Shield - ForwardLeftRightBackward
// Move forward, left, right, then backward for testing and tuning.

#include <Servo.h>                           // Include servo library

Servo servoLeft;                             // Declare left and right servos
Servo servoRight;
 
void setup()                                 // Built-in initialization block
{ 
  tone(4, 3000, 1000);                       // Play tone for 1 second
  delay(5000);                               // Delay to finish tone

  servoLeft.attach(12);                      // Attach left signal to P13 
  servoRight.attach(11);                     // Attach right signal to P12
  
  // Turn left in place
  servoLeft.writeMicroseconds(1300);         // Left wheel clockwise
  servoRight.writeMicroseconds(1300);        // Right wheel clockwise
  delay(605);                                // ...for 0.6 seconds

  // Turn right in place
  servoLeft.writeMicroseconds(1700);         // Left wheel counterclockwise
  servoRight.writeMicroseconds(1700);        // Right wheel counterclockwise
  delay(550);

  // Full speed forward
  servoLeft.writeMicroseconds(1625);         // Left wheel counterclockwise
  servoRight.writeMicroseconds(1300);        // Right wheel clockwise
  delay(10500);                               // ...for 2 seconds

  // // Full speed forward
  // servoLeft.writeMicroseconds(1700);         // Left wheel counterclockwise
  // servoRight.writeMicroseconds(1300);        // Right wheel clockwise
  // delay(2000);                               // ...for 2 seconds

  // // Turn left in place
  // servoLeft.writeMicroseconds(1300);         // Left wheel clockwise
  // servoRight.writeMicroseconds(1300);        // Right wheel clockwise
  // delay(600);                                // ...for 0.6 seconds

  // // Turn right in place
  // servoLeft.writeMicroseconds(1700);         // Left wheel counterclockwise
  // servoRight.writeMicroseconds(1700);        // Right wheel counterclockwise
  // delay(600);                                // ...for 0.6 seconds

  // // Full speed backward
  // servoLeft.writeMicroseconds(1300);         // Left wheel clockwise
  // servoRight.writeMicroseconds(1700);        // Right wheel counterclockwise
  // delay(2000);                               // ...for 2 seconds

  servoLeft.detach();                        // Stop sending servo signals
  servoRight.detach(); 
}  

void loop()                                  // Main loop auto-repeats
{                                            // Empty, nothing needs repeating
} 

