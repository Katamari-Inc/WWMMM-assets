import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Serial serial;

void setup() {
  println(Serial.list());
  serial = new Serial(this, Serial.list()[4], 9600);
  serial.clear();

  size(700, 400);
  cp5 = new ControlP5(this);
  float r = 50000;
  cp5.addSlider("motor1")
    .setId(0)
    .setPosition(30, 30)
    .setSize(400, 50)
    .setRange(-r, r)
    .setValue(0)
    .setDecimalPrecision(2);
  cp5.addSlider("motor2")
    .setId(1)
    .setPosition(30, 100)
    .setSize(400, 50)
    .setRange(-r, r)
    .setValue(0)
    .setDecimalPrecision(2);
  cp5.addSlider("motor3")
    .setId(2)
    .setPosition(30, 170)
    .setSize(400, 50)
    .setRange(-r, r)
    .setValue(0)
    .setDecimalPrecision(2);
}

void draw() {
}

void controlEvent(ControlEvent event) {
  int id = event.getController().getId();
  switch (id) {
    case 0:
    case 1:
    case 2:
      String command = "P " + id + " " + int(event.getController().getValue()) + "\n";
      println(command);
      serial.write(command);
      break;
  }
}

void serialEvent(Serial s) {
  print(s.readString());
}
