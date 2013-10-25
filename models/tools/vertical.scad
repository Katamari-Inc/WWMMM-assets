$fn=32;

n = 10-5/2;


difference() {
  union() {
    translate([-20/2, -30/2, 0]) cube([20, 30, 15]);
    translate([0, 0, 50-5]) cube([20, 20, 5], center=true);
    translate([n, n, 29]) cube([5, 5, 30], center=true);
    translate([-n, n, 29]) cube([5, 5, 30], center=true);
    translate([-n, -n, 29]) cube([5, 5, 30], center=true);
    translate([n, -n, 29]) cube([5, 5, 30], center=true);
  }
  translate([0, 0, 0.25]) cube([30, 20, 20], center=true);
  cylinder(r=5.2/2, h=50);
}
