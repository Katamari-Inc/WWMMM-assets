$fn=32;

module t(l=0,th=1.4) {
  translate([-0.2, -(2+l)/2, 0]) cube([3, 2+l, th]);
  translate([3, 0, 0]) cylinder(r=(3+l)/2, h=th);
}

module hoge() {
  difference() {
    union() {
      translate([-10.075, -10, 0]) cube([10, 20, 1.4]);
      translate([0, 1.075, 0]) t();
    }
    translate([0, -1.075, -.5]) rotate([0, 0, 180]) t(l=0.3,th=2.4);
  }
}


translate([-10, 5, 0]) hoge();
rotate([0, 0, 180]) hoge();
