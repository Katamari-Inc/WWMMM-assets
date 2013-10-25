WS = 0.3;   // pixel to mm
TH = 1.3 / WS;   // minimum thickness
TH2 = 0.6 / WS;

l1 = 102.47;
l2 = 142.47;
h = abs(l2 - l1);
w = 39;
d = 15;
cw = max(w - 6 / WS, 4 / WS);
cl = 10 / WS;
// echo("Connector length: " + (cl * WS) + "mm");

scale([WS, WS, WS]) {
  // floor & pillars
  difference() {
    translate([0, 0, -TH]) cube([d, w, h + TH]);
    translate([-5, TH, 0]) cube([d + 10, w - TH * 2, h - TH]);
    translate([TH, -5, 0]) cube([d - TH * 2, w + 10, h - TH]);
  }

  // lower box
  cube([d, TH2, 6]);
  translate([0, w - TH2, 0]) cube([d, TH2, 6]);
  cube([TH2, w, 6]);

  // lower connector
  translate([d - TH, 0, -(TH+1.5/WS)]) cube([TH, w, TH+1.5/WS]);
  translate([d, (w - cw) / 2, -(TH+1.5/WS)]) cube([cl, cw, TH]);
  translate([d+4/WS, w/2, -1.7/WS]) cylinder(r=1.5/WS, h=1.7/WS);

  // upper box
  translate([0, 0, h]) {
    cube([d, TH2, 6]);
    translate([0, w - TH2, 0]) cube([d, TH2, 6]);
    translate([d - TH2, 0, 0]) cube([TH2, w, 6]);
  }

  // upper connector
  translate([0, 0, h - (TH+1.5/WS)]) cube([TH, w, TH+1.5/WS]);
  translate([-cl, (w - cw) / 2, h - (TH+1.5/WS)]) cube([cl, cw, TH]);
  translate([-4/WS, w/2, h-1.7/WS]) cylinder(r=1.5/WS, h=1.7/WS);
}
