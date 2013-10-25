import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Slider speedSlider;
Serial myPort;
boolean sendOK = true;
int prev = 0;
PFont f;
String status = "";

void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[9], 57600);
  myPort.clear();
  myPort.readStringUntil(0);
  
  size(700,400);
  noStroke();
  cp5 = new ControlP5(this);
  
  speedSlider = cp5.addSlider("slider")
    .setPosition(30, 30)
    .setSize(400, 50)
    .setRange(-5, 5)
    .setValue(0)
    .setDecimalPrecision(5)
    ;
     
  cp5.addButton("STOP").setId(1).setPosition(30, 100).setSize(100, 30);
  cp5.addButton("SET AS HOME").setId(2).setPosition(140, 100).setSize(100, 30);
  cp5.addButton("GO HOME").setId(3).setPosition(250, 100).setSize(100, 30);
  cp5.addButton("SET MARK").setId(4).setPosition(360, 100).setSize(100, 30);
  cp5.addButton("GO MARK").setId(5).setPosition(470, 100).setSize(100, 30);
  
  frameRate(20);

  f = createFont("Menlo", 16, true);
}

void draw() {
  String tmp = myPort.readStringUntil(0);
  if (tmp != null) {
    if (match(tmp, "^OK") != null) {
      println(tmp);
      sendOK = true;
    } else {
      status = tmp;
    }
  } 

  background(200);
  textFont(f);
  fill(0);
  text(status, 30, 200);
}


void slider(float speed) {
  // if (!sendOK) return;

  myPort.write(0x81);
  int i = (int)(200 * speed);
  if (i != prev) {
    println("sent: " + i);
    sendData(i, 2);
    // myPort.write(i >> 24 & 0xff);
    // myPort.write(i >> 16 & 0xff);
    // myPort.write(i >> 8 & 0xff);
    // myPort.write(i & 0xff);
    prev = i;
    // sendOK = false;
  }
}


void sendData(long data, int bytes) {
  // int bytes = ceil(float(bits) / 7.0);
  // println("send " + bytes + "bytes");
  for (int i = 0; i < bytes; i++) {
    // println(hex(byte(data >> (bytes - i - 1) * 7) & 0x7f, 2));
    myPort.write(byte(data >> (bytes - i - 1) * 7) & 0x7f);
  }
}


void controlEvent(ControlEvent theEvent) {
  
  switch (theEvent.getController().getId()){
    case 1:
      speedSlider.setValue(0);
      break;
    case 2:
      sendCommand(0x03);
      break;
    case 3:
      sendCommand(0x04);
      break;
    case 4:
      sendCommand(0x05);
      break;
    case 5:
      sendCommand(0x06);
      break;
  }
}


void sendCommand(int command) {
  // byte[] data = {byte(command), 0, 0, 0, 0};
  myPort.write(command | 0x80);
}
