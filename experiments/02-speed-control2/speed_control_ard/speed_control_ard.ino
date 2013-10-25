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

  Serial.begin(115200);

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

void loop() {
  if (Serial.available() >= 4) {
    long l = 0;
    for (int i = 0; i < 4; i++) {
      l = l | Serial.read();
      if (i < 3) {
        l = l << 8;
      }
    }

    if (l == 0) {
      stepper.softStop();
    } else if (l > 0) {
      stepper.run(FWD, (float)l);
    } else {
      stepper.run(REV, (float)-l);
    }
    Serial.print("OK ");
    Serial.print(l);
    Serial.write(byte(0));
  }
  delay(10);

  if (digitalRead(PIN_RESET) == LOW) {
    // stepper.softStop();
    stepper.setAsHome();
  }

  unsigned long now = millis();
  if (now - t > 100) {
    t = now;
    Serial.print("0x");
    Serial.print(L6470_getparam_abspos(), HEX);
    Serial.print(", 0x");
    Serial.print(stepper.getPos(), HEX);
    Serial.write(byte(0));
    Serial.flush();
  }
}
