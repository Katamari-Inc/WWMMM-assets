$fn=64;

for (i = [2:6]) {
  translate([(i-1) * 15, 0, 0]) {
    cube([10, 10, 1]);
    translate([5, 5, 0]) cylinder(r=i/2, h=5);

    translate([0, 15, 0]) {
      difference() {
        translate([(10-(i+6))/2, 0, 0]) cube([i+6, 90, 1]);
        for (j = [-2:5]) {
          translate([5, j*10+28, -2]) cylinder(r=(i+j*0.1)/2, h=5);
        }
      }
    }
  }
}