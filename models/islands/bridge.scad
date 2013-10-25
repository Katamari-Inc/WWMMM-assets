WS = 0.3;   // pixel to mm
FTH = 1.4 / WS;
TH = 1.3 / WS;   // minimum thickness
TH2 = 0.6 / WS;

l1 = 177.66;
l1connector = false;
l2 = 177.66;
l2connector = false;
w = 19;
d = 429;

h = abs(l2 - l1);
cw = 2 / WS;//max(w - 6 / WS, 4 / WS);
cl = 4 / WS;

scale([WS, WS, WS]) translate([0, 0, FTH]) {
  // body
  multmatrix([
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [(l2 - l1) / d, 0, 1, 0],
    [0, 0, 0, 1]
  ]) {
    translate([0, 0, -FTH]) cube([d, w, FTH]);
    cube([d, TH2, 4]);
    translate([0, w - TH2, 0]) cube([d, TH2, 4]);
    // if (l1connector)
    //   translate([0, 0, -(TH + 1.5/WS)]) cube([TH, w, TH + 1.5/WS]);
    // if (l2connector)
    //   translate([d - TH, 0, -(TH + 1.5/WS)]) cube([TH, w, TH + 1.5/WS]);
  }

  // connector 1
  if (l1connector) {
    #translate([-cl, (w - cw) / 2, -FTH]) cube([cl, cw, FTH]);
    translate([-4/WS, w/2, -FTH]) cylinder(r=3/2/WS, h=FTH);
  }

  // connector 2
  if (l2connector) {
    #translate([d, (w - cw) / 2, l2 - l1 - FTH]) cube([cl, cw, FTH]);
    translate([d + 4/WS, w/2, l2 - l1 - FTH]) cylinder(r=3/2/WS, h=FTH);
    // #translate([d + 4/WS, w/2, l2 - l1 - FTH-5/WS]) cylinder(r=3.2/2/WS, h=5/WS);
    // #translate([d, (w - cw) / 2, l2 - l1 - FTH]) cube([2/WS, cw, FTH]);
    // translate([-2/WS, 0, 0]) translate([d + 4/WS, w/2, l2 - l1 - FTH]) cylinder(r=3/2/WS, h=FTH);
  }
}
