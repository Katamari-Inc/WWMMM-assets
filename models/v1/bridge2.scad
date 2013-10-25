WS = 0.3;   // pixel to mm
TH = 1.3 / WS;   // minimum thickness
TH2 = 0.6 / WS;

l1 = 128.36;
l2 = 142.47;
w = 39;
d = 80;
h = abs(l2 - l1);
cw = max(w - 6 / WS, 4 / WS);
cl = 7 / WS;

scale([WS, WS, WS]) {
  // body
  multmatrix([
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [(l2 - l1) / d, 0, 1, 0],
    [0, 0, 0, 1]
  ]) {
    translate([0, 0, -TH]) cube([d, w, TH]);
    cube([d, TH2, 6]);
    translate([0, w - TH2, 0]) cube([d, TH2, 6]);
    translate([0, 0, -(TH + 1.5/WS)]) cube([TH, w, TH + 1.5/WS]);
    translate([d - TH, 0, -(TH + 1.5/WS)]) cube([TH, w, TH + 1.5/WS]);
  }

  // connector 1
  translate([-cl, (w - cw) / 2, -(TH + 1.5/WS)]) cube([cl+TH, cw, TH]);
  translate([-4/WS, w/2, -1.7/WS]) cylinder(r=1.5/WS, h=1.7/WS);

  // connector 2
  translate([d - TH, (w - cw) / 2, l2 - l1 - (TH + 1.5/WS)]) cube([cl+TH, cw, TH]);
  translate([d + 4/WS, w/2, l2 - l1 - 1.7/WS]) cylinder(r=1.5/WS, h=1.7/WS);
}
