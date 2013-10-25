$fn=32;

difference() {
  cube([15, 15, 7], center=true);
  cylinder(r=3.5/2, h=8, center=true);
}

translate([20, 0, 0]) difference() {
  cube([15, 15, 7], center=true);
  cylinder(r=4/2, h=8, center=true);
}
