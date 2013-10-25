WS = 0.3;   // pixel to mm
TH = 1.3 / WS;   // minimum thickness

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
  cube([d, TH, 6]);
  translate([0, w - TH, 0]) cube([d, TH, 6]);
  cube([TH, w, 6]);

  // lower connector
  translate([d - TH, 0, -5 / WS]) cube([TH, w, 5 / WS]);
  translate([d, (w - cw) / 2, -(5 + 0.8) / 2 / WS]) cube([cl, cw, 0.8 / WS]);

  // upper box
  translate([0, 0, h]) {
    cube([d, TH, 6]);
    translate([0, w - TH, 0]) cube([d, TH, 6]);
    translate([d - TH, 0, 0]) cube([TH, w, 6]);
  }

  // upper connector
  translate([0, 0, h - 5 / WS]) cube([TH, w, 5 / WS]);
  translate([-cl, (w - cw) / 2, h - (5 + 0.8) / 2 / WS]) cube([cl, cw, 0.8 / WS]);
}
