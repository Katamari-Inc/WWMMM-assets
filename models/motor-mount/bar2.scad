$fn=32;

%translate([0, 0, -(12)/2+.5]) cube([50, 18+1, 12], center=true);

difference() {
  union() {
    translate([0, 0, -3/2]) cube([10, 34+3+4*2, 3], center=true);
    translate([0, 0, -(12-.5+3)/2]) cube([10, 18+1+3*2, 12-.5+3], center=true);
  }
  translate([0, 0, -(12-.5)/2+0.01]) cube([50, 18+1, 12-.5], center=true);
  translate([0, -17.5, 0]) cylinder(r=3.5/2, h=50, center=true);
  translate([0, 17.5, 0]) cylinder(r=3.5/2, h=50, center=true);
}
%translate([0, (18+1)/2+10/2+3]) cylinder(r=10/2, h=10, center=true);