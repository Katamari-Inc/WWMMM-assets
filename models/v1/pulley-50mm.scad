// $fn = 128;
$fs = 0.2;
d = 50;
r = d / 2;
intersection() {
  translate([0, 0, -4]) cylinder(r=r+1, h=10, $fn=256);
  difference() {
    union() {
      translate([0, 0, -2]) cylinder(2, r + 2, r, $fn=256);
      cylinder(r=r, h=2, $fn=256);
      translate([0, 0, 2]) cylinder(2, r, r + 2, $fn=256);
    }
    for (i = [0:3]) {
      translate([sin(i/4*360)*6.35, cos(i/4*360)*6.35, -5]) cylinder(r=2.845/2+0.1, h=10);
      translate([sin(i/4*360)*6.35, cos(i/4*360)*6.35, -5.01]) cylinder(r=6/2, h=5);
    }
    translate([0, 0, 1.5]) cylinder(r=19.05/2+0.1, h=5.08);
    translate([0, 0, -5]) cylinder(r=5/2+0.5,h=10);
    for (i = [0:6]) {
      translate([sin(i/7*360)*17, cos(i/7*360)*17, -4]) cylinder(r=5.5, h=10);
    }
    translate([0, r+5, 1]) cube([1, 10, 10], center=true);
  }
}
    

