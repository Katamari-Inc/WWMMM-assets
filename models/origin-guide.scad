difference() {
  translate([0, -20, -10]) cube(size=[25, 40, 25]);
  translate([5, 0, 0]) rotate([0, 0, 45]) cylinder(r1=11/sqrt(2), r2=50/sqrt(2), h=20, $fn=4);
  translate([-1, -6, -15]) cube([12, 12, 25]);
}
