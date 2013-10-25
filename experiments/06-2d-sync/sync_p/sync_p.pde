import controlP5.*;
import processing.serial.*;
import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.processing.LeapMotion;

ControlP5 cp5;
Serial serial;
LeapMotion leap;

static final float MOTOR_DISTANCE = 250;
static final float ANCHOR_DISTANCE = 440;
static final float OFFSET = 163708;
float height = 1000;
float rotation = 0;


void setup() {
  println(Serial.list());
  serial = new Serial(this, Serial.list()[4], 9600);
  serial.clear();

  leap = new LeapMotion(this);

  size(1280, 800);
  cp5 = new ControlP5(this);
  float r = 50000;
  cp5.addSlider("motor1")
    .setId(0)
    .setPosition(30, 30)
    .setSize(400, 20)
    .setRange(-r, r)
    .setValue(0)
    .setDecimalPrecision(2);
  cp5.addSlider("motor2")
    .setId(1)
    .setPosition(30, 60)
    .setSize(400, 20)
    .setRange(-r, r)
    .setValue(0)
    .setDecimalPrecision(2);
  cp5.addSlider("motor3")
    .setId(2)
    .setPosition(30, 90)
    .setSize(400, 20)
    .setRange(-r, r)
    .setValue(0)
    .setDecimalPrecision(2);

  cp5.addSlider("height")
    .setId(3)
    .setPosition(30, 130)
    .setSize(400, 20)
    .setRange(0, 1400)
    .setValue(1000);
  cp5.addSlider("rotation")
    .setId(4)
    .setPosition(30, 160)
    .setSize(400, 20)
    .setRange(-45, 45)
    .setValue(0);
}


void draw() {
  background(200);

  pushMatrix();
  translate(1280 / 2, 10);
  scale(0.5, 0.5);

  fill(255, 0, 0);
  noStroke();
  ellipse(-MOTOR_DISTANCE / 2, 0, 10, 10);
  ellipse( MOTOR_DISTANCE / 2, 0, 10, 10);

  pushMatrix();
  translate(0, height);
  float a = radians(rotation);
  rotate(a);
  fill(255);
  rectMode(CENTER);
  rect(0, 0, ANCHOR_DISTANCE + 40, 20);
  fill(0, 0, 255);
  ellipse(-ANCHOR_DISTANCE / 2, 0, 10, 10);
  ellipse( ANCHOR_DISTANCE / 2, 0, 10, 10);
  popMatrix();

  noFill();
  stroke(0);
  float c = cos(a) * ANCHOR_DISTANCE / 2;
  float s = sin(a) * ANCHOR_DISTANCE / 2;
  line(-MOTOR_DISTANCE / 2, 0, -c, height - s);
  line( MOTOR_DISTANCE / 2, 0,  c, height + s);

  popMatrix();
}


void controlEvent(ControlEvent event) {
  int id = event.getController().getId();
  switch (id) {
    case 3:
      height = event.getController().getValue();
      break;
    case 4:
      rotation = event.getController().getValue();
      break;
  }

  float a = radians(rotation);
  float c = cos(a) * ANCHOR_DISTANCE / 2;
  float s = sin(a) * ANCHOR_DISTANCE / 2;
  float p = dist(-MOTOR_DISTANCE / 2, 0, -c, height - s);
  p = p / (50 * PI) * 200 * 128 + cp5.getController("motor1").getValue() - OFFSET;
  String command = "P 0 " + int(p) + "\n";
  print(command);
  serial.write(command);

  p = dist(MOTOR_DISTANCE / 2, 0, c, height + s);
  p = p / (50 * PI) * 200 * 128 + cp5.getController("motor3").getValue() - OFFSET;
  command = "P 1 " + int(p) + "\n";
  print(command);
  serial.write(command);
}


void serialEvent(Serial s) {
  print(s.readString());
}


void onFrame(final Controller controller) {
  Frame frame = controller.frame();
  if (!frame.hands().isEmpty()) {
    Hand hand = frame.hands().get(0);
    cp5.getController("height").setValue(1400 - hand.palmPosition().getY() * 2);
    cp5.getController("rotation").setValue(-degrees(hand.palmNormal().roll()));
  }
}

