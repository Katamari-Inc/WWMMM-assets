$fn=32;

bp = 31/2;
br = 3.5/2;

// motor
* translate([0, 5/2, 0]) {
  translate([0, 34/2-2, 0]) intersection() {
    cube([41, 34, 41], center=true);
    rotate([0, 45, 0]) cube([53, 35, 53], center=true);
  }
  translate([0, -12, 0]) rotate([90, 0, 0]) {
    cylinder(r=52/2, h=6, center=true);
    translate([0, 0, (6+5)/2]) cylinder(r=19/2, h=5, center=true);
  }
  translate([0, -12, 0]) rotate([90, 0, 0]) cylinder(r=5/2, h=24, center=true);
}

// mount
difference() {
  intersection() {
    translate([0, -1, -.5]) cube([41, 3, 42], center=true);
    union() {
      rotate([0, 45, 0])cube([53, 10, 53], center=true);
      translate([0, 0, -20]) cube([45, 10, 45], center=true);
    }
  }
  rotate([90, 0, 0]) {
    cylinder(r=25/2, h=10, center=true, $fn=128);
    translate([bp, bp, 0]) cylinder(r=br, h=10, center=true);
    translate([-bp, bp, 0]) cylinder(r=br, h=10, center=true);
    translate([bp, -bp, 0]) cylinder(r=br, h=10, center=true);
    translate([-bp, -bp, 0]) cylinder(r=br, h=10, center=true);
  }
}

difference() {
  translate([0, 0, -.6]) union() {
    translate([0, 34/2-1, -(41+10)/2]) cube([41, 34+3, 10], center=true);
    difference() {
      translate([-61/2, -2.5-4, -41/2-10-3]) cube([61, 34+3+4*2, 3]);
      translate([0, 0, -41/2-10-2.5]) {
        translate([-61/2+5, -2.5+5-4]) cylinder(r=3.5/2, h=10, center=true);
        translate([61/2-5, -2.5+5-4]) cylinder(r=3.5/2, h=10, center=true);
        translate([-61/2+5, -2.5+34+3-5+4]) cylinder(r=3.5/2, h=10, center=true);
        translate([61/2-5, -2.5+34+3-5+4]) cylinder(r=3.5/2, h=10, center=true);
      }
    }
  }
  translate([-29/2, .5 + 3, -45]) cube([29, 34-6, 30]);
  // translate([0, 34, -41+10-3]) rotate([90, 0, 0]) cylinder(r=5/2, h=10, center=true);
}

translate([-50/2-1/2, -5-2.5, -41/2-10-1.5-.6]) difference() {
  translate([0, -2, 0]) cube([10, 10, 3], center=true);
  translate([0, -2, 10]) cylinder(r=1, h=30, center=true);
}


// bar
% translate([0, 34/2-1, -12/2-41/2-10-3-.6]) cube([100, 18+1, 12], center=true);
