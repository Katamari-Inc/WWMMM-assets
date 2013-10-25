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
  myPort = new Serial(this, Serial.list()[9], 115200);
  myPort.clear();
  myPort.readStringUntil(0);
  
  size(700,400);
  noStroke();
  cp5 = new ControlP5(this);
  
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  speedSlider = cp5.addSlider("slider")
     .setPosition(30, 30)
     .setSize(400, 50)
     .setRange(-5, 5)
     .setValue(0)
     .setDecimalPrecision(5)
     ;
     
  cp5.addButton("stop").setPosition(30, 100).setSize(100, 30);
  
  frameRate(20);

  f = createFont("Menlo", 16, true);
}

void draw() {
  String hoge = myPort.readStringUntil(0);
  if (hoge != null) {
    // println(hoge);
    if (match(hoge, "^OK") != null) {
      sendOK = true;
    } else {
      status = hoge;
      // println(hoge);
    }
  } 
  if (mousePressed) {
   speedSlider.setValue((float(mouseY) - 200.0) / 200.0 * 5.0);
  }

  background(200);
  textFont(f);
  fill(0);
  text(status, 30, 200);
}

void mouseReleased() {
  stop();
}

void slider(float speed) {
  if (!sendOK) return;
    
  int i = (int)(200 * speed);
  if (i != prev) {
    println("sent: " + i);
    myPort.write(i >> 24 & 0xff);
    myPort.write(i >> 16 & 0xff);
    myPort.write(i >> 8 & 0xff);
    myPort.write(i & 0xff);
    prev = i;
    sendOK = false;
  }
}

void stop() {
  println("stop");
  speedSlider.setValue(0);
}


