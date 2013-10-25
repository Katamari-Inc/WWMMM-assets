difference() {
  cube([30, 30, 10], center=true);
  cube([10.5, 10.5, 15], center=true);
}

translate([40, 0, 0]) difference() {
  cube([30, 30, 10], center=true);
  cube([11, 11, 15], center=true);
}
