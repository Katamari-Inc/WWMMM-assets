#include <SPI.h>
#include "L6470.h"


#define PIN_RESET 2


L6470 stepper(10);

int numBytesWait = 0;
int lastCommand = 0;
long receivedData = 0;
unsigned long t = 0;

long destination = 0;


void setup() {
  pinMode(PIN_RESET, INPUT_PULLUP); 

  Serial.begin(115200);

  stepper.init();
  stepper.setAcc(5000);
  stepper.setDec(5000);
  stepper.setMaxSpeed(600);
  stepper.setMinSpeed(1);
  stepper.setMicroSteps(128);
  stepper.setThresholdSpeed(1000);
  stepper.setOverCurrent(6000);
  stepper.setStallCurrent(3000);
  stepper.setMark(25600);
}


void loop() {
  while (Serial.available() > 0) {
    byte b = Serial.read();
    if ((b & 0x80) == 0x80) { // command
      lastCommand = b;
      receivedData = 0;
      numBytesWait = 0;
      switch (b) {
        case 0x81: // set speed
          numBytesWait = 2;
          break;
        case 0x82: // set position
          numBytesWait = 4;
          break;
        case 0x83: // set current position as home
          stepper.setAsHome();
          break;
        case 0x84: // go home
          stepper.goHome();
          break;
        case 0x85: // set mark
          stepper.setMark();
          break;
        case 0x86: // go mark
          stepper.goMark();
          break;
      }
    } else if (numBytesWait > 0) {
      numBytesWait--;
      receivedData |= long(b) << (numBytesWait * 7);
      if (numBytesWait == 0) {
        switch (lastCommand) {
          case 0x81: // set speed
            if (receivedData & 0x2000) {
              receivedData = -(0x4000 - receivedData);
            }
            if (receivedData > 0) {
              stepper.run(FWD, (float)receivedData);
            } else {
              stepper.run(REV, (float)-receivedData);
            }
            break;
          case 0x82: // set position
            destination = receivedData;
            if (destination & 0x8000000) {
              destination = -(0x10000000 - receivedData);
            }
            // Serial.print("OK ");
            // Serial.print(receivedData);
            // Serial.print(" ");
            // Serial.print(destination);
            // Serial.write(byte(0));
            // Serial.flush();
            break;
        }
      }
    }
  }

  long current = stepper.getPos();
  float speed = float(destination - current) * 0.1;
  if (fabs(speed) > 0.5) {
    if (speed > 0) {
      stepper.run(FWD, speed);
    } else {
      stepper.run(REV, -speed);
    }
  } else {
    stepper.hardStop();
  }

  if (digitalRead(PIN_RESET) == LOW) {
    stepper.softStop();
  }

  unsigned long now = millis();
  if (now - t > 100) {
    t = now;
    Serial.print(current);
    Serial.write(byte(0));
    Serial.flush();
  }
}
