$fn=32;

intersection() {
  rotate([0, -17.5/2, 0]) translate([0, 0, -30]) cube([50, 7, 30]);
  rotate([0, 17.5/2, 0]) cube([50, 7, 30]);
  translate([34, 0, 1.4/2]) cube([10, 7, 20]);
}

// translate([34+3/2+10/2, 2.5, 6.4]) rotate([0, 90-17.5/2, 0]) difference() {
//   cylinder(r=5/2, h=3, center=true);
//   cylinder(r=2.8/2, h=5, center=true);
// }


difference() {
  translate([34+5, 0, 1.4/2]) cube([5, 7, 10]);
rotate([0, 90-17.5/2, 0]) 
translate([0, 7/2, 25]) union() {
translate([-1, 0, 0]) intersection() {
  cylinder(r=3/2, h=50, center=true);
  translate([-5, 0, 0]) cube([10, 10, 50], center=true);
}
translate([-0.501, 0, 0]) cube([1, 3, 50], center=true);
}
}


