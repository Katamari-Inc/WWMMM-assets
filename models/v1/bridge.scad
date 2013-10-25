WS = 0.3;   // pixel to mm
TH = 1.3 / WS;   // minimum thickness

l1 = 128.36;
l2 = 142.47;
w = 39;
d = 80;
h = abs(l2 - l1);
cw = max(w - 6 / WS, 4 / WS);
cl = 5 / WS;

scale([WS, WS, WS]) {
  multmatrix([
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [(l2 - l1) / d, 0, 1, 0],
    [0, 0, 0, 1]
  ]) {
    translate([0, 0, -TH]) cube([d, w, TH]);
    cube([d, TH, 6]);
    translate([0, w - TH, 0]) cube([d, TH, 6]);
    translate([0, 0, -5 / WS]) cube([TH, w, 5 / WS]);
    translate([d - TH, 0, -5 / WS]) cube([TH, w, 5 / WS]);
  }
  translate([-cl, (w - cw) / 2, -(5 + 0.8) / 2 / WS]) cube([cl, cw, 0.8 / WS]);
  translate([d, (w - cw) / 2, l2-l1-(5 + 0.8) / 2 / WS]) cube([cl, cw, 0.8 / WS]);
}
