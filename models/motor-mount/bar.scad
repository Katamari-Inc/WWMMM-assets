$fn=32;

difference() {
  cube([10, 34+3, 3], center=true);
  translate([0, -13.5, 0]) cylinder(r=3.5/2, h=10, center=true);
  translate([0, 13.5, 0]) cylinder(r=3.5/2, h=10, center=true);
}
