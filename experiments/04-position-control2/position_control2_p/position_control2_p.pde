import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Slider speedSlider;
Serial myPort;
int prev = 0;
PFont f;
String status = "";

void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[9], 115200);
  myPort.clear();
  myPort.readStringUntil(0);
  
  size(700,400);
  noStroke();
  cp5 = new ControlP5(this);
  
  speedSlider = cp5.addSlider("slider")
    .setPosition(30, 30)
    .setSize(400, 50)
    .setRange(200 * 128 * -5, 200 * 128 * 5)
    .setValue(0)
    .setDecimalPrecision(2)
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
    } else {
      status = tmp;
    }
  } 

  if (mouseX > 600) {
    speedSlider.setValue((float(mouseY - 300) / 300) * 200 * 128 * 2);
  }

  background(200);
  textFont(f);
  fill(0);
  text(status, 30, 200);
}


void slider(float position) {
  myPort.write(0x82);
  int p = (int)position;
  if (p != prev) {
    // println("sent: " + p);
    sendData(p, 4);
    prev = p;
  }
}


void sendData(int data, int bytes) {
  // print("0x");
  println(data);
  for (int i = 0; i < bytes; i++) {
    myPort.write(byte((data >> (bytes - i - 1) * 7) & 0x7f));
  }
}


void controlEvent(ControlEvent theEvent) {
  
  switch (theEvent.getController().getId()){
    case 1:
      speedSlider.setValue(0);
      break;
    case 2:
      myPort.write(0x83);
      break;
    case 3:
      myPort.write(0x84);
      break;
    case 4:
      myPort.write(0x85);
      break;
    case 5:
      myPort.write(0x86);
      break;
  }
}
