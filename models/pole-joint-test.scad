$fn=32;

difference() {
  cube([20, 20, 1.2], center=true);
  cube([10, 10, 5], center=true);
}

translate([25, 0, 0]) difference() {
  cube([20, 20, 1.2], center=true);
  cube([10+.3, 10+.3, 5], center=true);
}

translate([50, 0, 0]) difference() {
  cube([20, 20, 1.2], center=true);
  cube([10+.5, 10+.5, 5], center=true);
}

translate([-20, 0, 0]) {
  cube([10, 10, 1.2], center=true);
  translate([0, 0, -0.6]) cylinder(r=3.3/2, h=1.2+5);
}


translate([0, 25, 0]) {
difference() {
  cube([20, 20, 1.2], center=true);
  cube([5, 5, 5], center=true);
}

translate([25, 0, 0]) difference() {
  cube([20, 20, 1.2], center=true);
  cube([5+.3, 5+.3, 5], center=true);
}

translate([50, 0, 0]) difference() {
  cube([20, 20, 1.2], center=true);
  cube([5+.5, 5+.5, 5], center=true);
}

translate([-20, 0, 0]) {
  cube([5, 5, 1.2], center=true);
  translate([0, 0, -0.6]) cylinder(r=3.3/2, h=1.2+5);
}
}


translate([0, -25, 0]) {

difference() {
  cube([20, 20, 1.2], center=true);
  cube([3.3, 10, 5], center=true);
  cube([10, 3.3, 5], center=true);
}

translate([25, 0, 0]) difference() {
  cube([20, 20, 1.2], center=true);
  cube([3.3+.3, 10+.3, 5], center=true);
  cube([10+.3, 3.3+.3, 5], center=true);
}

translate([50, 0, 0]) difference() {
  cube([20, 20, 1.2], center=true);
  cube([3.3+.5, 10+.5, 5], center=true);
  cube([10+.5, 3.3+.5, 5], center=true);
}

translate([-20, 0, 0]) {
  cube([3.3, 10, 1.2], center=true);
  cube([10, 3.3, 1.2], center=true);
  translate([0, 0, -0.6]) cylinder(r=3.3/2, h=1.2+5);
}
}
