$fn=32;

*union() {
  cube([15, 15, 1.4]);
  translate([15+4, 15/2, 0]) cylinder(r=3/2, h=1.4);
  translate([15+4-10, (15-2)/2, 0]) cube([10, 2, 1.4]);

  translate([15, 0, 0]) difference() {
    translate([15.3, 0, 0]) cube([15, 15, 1.4]);
    translate([15+4, 15/2, -0.5]) cylinder(r=3.3/2, h=2.2);
    translate([15+4-10, (15-2.3)/2, -0.5]) cube([10, 2.3, 2.2]);
  }
}

cube([15, 15, 1.4]);
translate([15+4, 15/2, 0]) cylinder(r=3/2, h=1.4);
translate([15+4-10, (15-2)/2, 0]) cube([10, 2, 1.4]);

#translate([10, 0, 0]) difference() {
  translate([15, 0, 0]) cube([15, 15, 1.4]);
  translate([15+4, 15/2, -0.5]) cylinder(r=3/2, h=2.2);
  translate([15+4-10, (15-2)/2, -0.5]) cube([10, 2, 2.2]);
}
