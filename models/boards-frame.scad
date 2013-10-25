$fn=32;

module pin(x=0, y=0, r=8, h=10) {
  translate([x, y, 0]) cylinder(r=r/2, h=h+3, $fn=6);
}
module hole(x=0, y=0, r=3, h=10) {
  translate([x, y, -1]) cylinder(r=r/2, h=h+3+2);
}

difference() {
  union() {
    linear_extrude(height=3, convexity=10, twist=0) {
      scale(25.4) import(file="boards-frame.dxf");
    }
 
    pin(5, 5);
    pin(57.07, 10.08);
    pin(6.27, 53.26);
    pin(57.07, 38.02);
  
    pin(20.85, 76.28);
    pin(51.85, 76.28);
    pin(20.85, 107.28);
    pin(51.85, 107.28);

    pin(20.85, 126.92);
    pin(51.85, 126.92);
    pin(20.85, 157.92);
    pin(51.85, 157.92);

    pin(20.85, 177.56);
    pin(51.85, 177.56);
    pin(20.85, 208.56);
    pin(51.85, 208.56);
  }
  
  hole(5, 5);
  hole(57.07, 10.08);
  hole(6.27, 53.26);
  hole(57.07, 38.02);

  hole(20.85, 76.28);
  hole(51.85, 76.28);
  hole(20.85, 107.28);
  hole(51.85, 107.28);

  hole(20.85, 126.92);
  hole(51.85, 126.92);
  hole(20.85, 157.92);
  hole(51.85, 157.92);

  hole(20.85, 177.56);
  hole(51.85, 177.56);
  hole(20.85, 208.56);
  hole(51.85, 208.56);

  translate([36.35, 5, -1]) cylinder(r=3.2/2, h=10, center=true);
  translate([36.35, 53.26, -1]) cylinder(r=3.2/2, h=10, center=true);
  translate([36.35, 208.56, -1]) cylinder(r=3.2/2, h=10, center=true);
}
