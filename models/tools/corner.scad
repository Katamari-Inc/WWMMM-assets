$fn=64;

difference() {
  union() {
    difference() {
      union() {
        translate([-(10+1+2*2+10)/2, -20, -5]) cube([10+1+2*2, 50, 10+3+2]);
        translate([0, -(10+1+2*2-10)/2+.25, -5]) cube([30, 10+1+2*2, 10+3+2]);
        intersection() {
          translate([0, 5, 0]) rotate([0, 0, 45]) union() {
            translate([0, 0, 2.5]) cube([35, 35, 15], center=true);
            // translate([0, 0, 8.5]) cube([35, 35, 3], center=true);
          }
          translate([0, -20, -6]) cube([20, 50, 20]);
        }
      }
      translate([-5, -.15, -3]) cube([50, 10.3, 13.01]);
      translate([-10.5+.35, -35, -3]) cube([10.3, 80, 13.01]);
    }
    translate([-5, (10-2)/2, -3]) cube([35, 2, 3]);
    translate([-(10+2)/2, -20, -3]) cube([2, 50, 3]);
  }
  translate([-1, 5, 0]) cube([10, 10.5, 20], center=true);
}



% union() {
  cube([50, 10, 10]);
  translate([0, -30, 0]) rotate([0, 0, 90]) cube([70, 10, 10]);  
}
