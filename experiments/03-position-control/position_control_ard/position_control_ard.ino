#include <SPI.h>
#include "L6470.h"

#define PIN_SPI_MOSI 11
#define PIN_SPI_MISO 12
#define PIN_SPI_SCK 13
#define PIN_SPI_SS 10
#define PIN_BUSY 9
#define PIN_RESET 2

L6470 stepper(10);

unsigned long t = 0;

void setup() {
  pinMode(PIN_RESET, INPUT_PULLUP); 

  Serial.begin(57600);

  stepper.init();
  stepper.setAcc(600);
  stepper.setMaxSpeed(600);

  stepper.setMinSpeed(1);
  stepper.setMicroSteps(128);
  stepper.setThresholdSpeed(1000);
  stepper.setOverCurrent(6000);
  stepper.setStallCurrent(3000);

  // stepper.run(REV, 1);

  Serial.print("OK");
  Serial.write(byte(0));
}

int numBytesWait = 0;
int lastCommand = 0;
int receivedData = 0;

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
        case 0x82: // get position
          Serial.write(stepper.getPos());
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
            Serial.print("OK 0x");
            Serial.print(lastCommand, HEX);
            // Serial.print(" 0x");
            // Serial.print(receivedData, HEX);
            // Serial.print(" ");
            // Serial.print(receivedData);
            if (receivedData & 0x2000) {
              receivedData = -(0x4000 - receivedData);
            }
            Serial.print(" ");
            Serial.print(receivedData);
            Serial.write(byte(0));
            Serial.flush();
            if (receivedData > 0) {
              stepper.run(FWD, (float)receivedData);
            } else {
              stepper.run(REV, (float)-receivedData);
            }
            break;
        }
      }
    }
  }
  // while (Serial.available() >= 5) {
  //   byte command = Serial.read();
  //   long l = 0;
  //   for (int i = 0; i < 4; i++) {
  //     l = l | Serial.read();
  //     if (i < 3) {
  //       l = l << 8;
  //     }
  //   }
  //   Serial.print("OK ");
  //   Serial.print(command);
  //   Serial.print(" ");
  //   switch (command) {
  //     case 0x01: // set speed
  //       if (l > 0) {
  //         stepper.run(FWD, (float)l);
  //       } else {
  //         stepper.run(REV, (float)-l);
  //       }
  //       Serial.print(l);
  //       break;
  //     case 0x02: // get position
  //       Serial.write(stepper.getPos());
  //       break;
  //     case 0x03: // set current position as home
  //       stepper.setAsHome();
  //       break;
  //     case 0x04: // go home
  //       stepper.goHome();
  //       break;
  //     case 0x05: // set mark
  //       stepper.setMark();
  //       break;
  //     case 0x06: // go mark
  //       stepper.goMark();
  //       break;
  //   }
  //   Serial.write(byte(0));
  // }
  delay(10);

  if (digitalRead(PIN_RESET) == LOW) {
    stepper.softStop();
    // stepper.setAsHome();
  }

  unsigned long now = millis();
  if (now - t > 100) {
    t = now;
    // Serial.print("0x");
    Serial.print(stepper.getPos());
    Serial.write(byte(0));
    Serial.flush();
  }
}
