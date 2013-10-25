$fn=32;

for (j = [0:4]) {
  for (i = [0:3]) {
    translate([i * 8, j * 8, 0]) difference() {
      cylinder(r=3.5/2+1.6, h=3);
      translate([0, 0, -1]) cylinder(r=3.5/2, h=5);
    }
  }
}
