// $fn = 128;
$fs = 0.2;
d = 50;
r = d / 2;
rotate([180, 0, 0]) intersection() {
  translate([0, 0, -4]) cylinder(r=r+2, h=10, $fn=256);
  difference() {
    union() {
      translate([0, 0, -3.5]) cylinder(1.5, r + 3, r, $fn=256);
      translate([0, 0, -2]) cylinder(r=r, h=3, $fn=256);
      translate([0, 0, 1]) cylinder(1.5, r, r + 3, $fn=256);
    }
    for (i = [0:3]) {
      translate([sin(i/4*360)*6.35, cos(i/4*360)*6.35, -5]) cylinder(r=2.845/2+0.1, h=10);
      translate([sin(i/4*360)*6.35, cos(i/4*360)*6.35, -5]) cylinder(r=6/2, h=5);
    }
    // translate([0, 0, 1.5]) cylinder(r=19.05/2+0.1, h=5.08);
    translate([0, 0, -5]) cylinder(r=5/2+0.5,h=10);
    for (i = [0:6]) {
      translate([sin(i/7*360)*17, cos(i/7*360)*17, -4]) cylinder(r=5.5, h=20, center=true);
    }
    // translate([0, r+5, 1]) cube([1, 10, 10], center=true);
    translate([0, 25, -1.7]) rotate([90, 0, 0]) cylinder(r=0.7, h=10, center=true);
  }
}
    
