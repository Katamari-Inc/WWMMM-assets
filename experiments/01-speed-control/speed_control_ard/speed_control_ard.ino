#include <SPI.h>
#include "MsTimer2.h"


#define PIN_SPI_MOSI 11
#define PIN_SPI_MISO 12
#define PIN_SPI_SCK 13
#define PIN_SPI_SS 10
#define PIN_BUSY 9

#define PIN_RESET 2

float currentSpeed = 0.0;
float targetSpeed = 0.0;

void setup() {
  pinMode(PIN_SPI_MOSI, OUTPUT);
  pinMode(PIN_SPI_MISO, INPUT);
  pinMode(PIN_SPI_SCK, OUTPUT);
  pinMode(PIN_SPI_SS, OUTPUT);
  pinMode(PIN_BUSY, INPUT);

  pinMode(PIN_RESET, INPUT_PULLUP); 

  SPI.begin();
  SPI.setDataMode(SPI_MODE3);
  SPI.setBitOrder(MSBFIRST);

  Serial.begin(115200);
  digitalWrite(PIN_SPI_SS, HIGH);
  
  L6470_resetdevice();

  L6470_setparam_acc(0x40); //default 0x08A (12bit) (14.55*val+14.55[step/s^2])
  L6470_setparam_dec(0x40); //default 0x08A (12bit) (14.55*val+14.55[step/s^2])
  L6470_setparam_maxspeed(0x20); //default 0x041 (10bit) (15.25*val+15.25[step/s])
  L6470_setparam_minspeed(0x00); //default 0x000 (1+12bit) (0.238*val[step/s])
  L6470_setparam_fsspd(0x3ff); //default 0x027 (10bit) (15.25*val+7.63[step/s])
  L6470_setparam_kvalhold(0x80); //default 0x29 (8bit) (Vs[V]*val/256)
  L6470_setparam_kvalrun(0xff); //default 0x29 (8bit) (Vs[V]*val/256)
  L6470_setparam_kvalacc(0xff); //default 0x29 (8bit) (Vs[V]*val/256)
  L6470_setparam_kvaldec(0xff); //default 0x29 (8bit) (Vs[V]*val/256)
  L6470_setparam_stepmood(0x07); //default 0x07 (1+3+1+3bit)
  
  L6470_hardstop();
  
  MsTimer2::set(50, report);
  MsTimer2::start();

  delay(100);
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

    currentSpeed = l;
    if (l == 0) {
      L6470_hardstop();
    } else if (l > 0) {
      L6470_run(1, l);
    } else {
      L6470_run(0, -l);
    }
    L6470_busydelay(10);
    Serial.print("OK ");
    Serial.print(l);
    Serial.write(byte(0));
  }
  delay(10);

//   bool changed = false;
//   long l = 0L;
//   while (Serial.available() >= 4) {
//     l = 0L;
//     for (int i = 0; i < 4; i++) {
//       l = l | Serial.read();
//       if (i < 3) {
//         l = l << 8;
//       }
//     }
//     changed = true;
//   }
  
//   if (changed) {
// //    targetSpeed = float(l);
// //  l = long(currentSpeed);
//   L6470_busydelay(10);
//   currentSpeed = l;
//   if (l == 0) {
//     L6470_hardstop();
//   } else if (l > 0) {
//     L6470_run(1, l);
//   } else {
//     L6470_run(0, -l);
//   }
//     Serial.print("OK ");
//     Serial.print(l);
//     Serial.write(byte(0));
//   }
  
// //  currentSpeed += (targetSpeed - currentSpeed) * 0.5;
// //  l = long(currentSpeed);
// //  if (l == 0) {
// //    L6470_hardstop();
// //  } else if (l > 0) {
// //    L6470_run(1, l);
// //  } else {
// //    L6470_run(0, -l);
// //  }
//   delay(100);

  if (digitalRead(PIN_RESET) == LOW) {
    L6470_hardstop();
  }
}

void report() {
  // String s = "ABS_POS: ";
  // s += L6470_getparam_abspos();
  // s += ",  SPEED: ";
  // s += L6470_getparam_speed();
  // s += ",  STATUS: ";
  Serial.print(L6470_getparam_abspos(), HEX);
  Serial.print(",  STATUS: ");
  // s += ",  current: ";
  // s += long(currentSpeed);
  // s += ",  target: ";
  // s += long(targetSpeed);
  // Serial.print(s);
  long status = L6470_getstatus();
  for (int i = 0; i < 16; i++) {
    Serial.print((status >> (15 - i)) & 1);
    if (i % 4 == 3) {
      Serial.print(" ");
    }
  }
  Serial.write(byte(0));
}

