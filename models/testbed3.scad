$fn=64;

translate([-5, -5, 0]) cube([110, 20, 1]);
for (i = [0:10]) {
  translate([i * 10, 0, 0]) cylinder(r=(3 + i * 0.1) / 2, h=5);
  translate([i * 10, 10, 0]) difference() {
    cylinder(r=(5 + i * 0.1) / 2+1, h=5);
    translate([0, 0, 1.01]) cylinder(r=(5 + i * 0.1) / 2, h=6);
  }
}
