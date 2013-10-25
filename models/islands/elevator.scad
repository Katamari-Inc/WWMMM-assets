WS = 0.3;   // pixel to mm
FTH = 1.4 / WS; // floor thickness
TH = 1.3 / WS;   // minimum thickness
TH2 = 0.6 / WS;

l1 = 191.76;
l1connector = false;
l2 = 231.76;
l2connector = false;
w = 39;
d = 15;

h = abs(l2 - l1);
cw = 2 / WS; //max(w - 6 / WS, 4 / WS);
cl = 4 / WS;
// echo("Connector length: " + (cl * WS) + "mm");

translate([0, 0, 1.4]) scale([WS, WS, WS]) {
  // floor & pillars
  // *difference() {
  //   translate([0, 0, -TH]) cube([d, w, h + TH]);
  //   translate([-5, TH, 0]) cube([d + 10, w - TH * 2, h - TH]);
  //   translate([TH, -5, 0]) cube([d - TH * 2, w + 10, h - TH]);
  // }

  // lower box
  cube([d, TH2, h + 4]);
  translate([0, w - TH2, 0]) cube([d, TH2, h + 4]);
  cube([TH2, w, 4]);
  translate([0, 0, h - FTH]) cube([d, w, FTH]);
  translate([d-TH2, 0, h-1]) cube([TH2, w, 4+1]);
  translate([0, 0, -FTH]) cube([d, w, FTH]);

  // lower connector
  if (l1connector) {
    translate([d, (w - cw) / 2, -FTH]) cube([cl, cw, FTH]);
    translate([d+4/WS, w/2, -FTH]) cylinder(r=3/2/WS, h=FTH);
  //   translate([0, 0, -(TH+1.5/WS)]) cube([d, w, TH+1.5/WS]);
  //   translate([d, (w - cw) / 2, -(TH+1.5/WS)]) cube([cl, cw, TH]);
  //   translate([d+4/WS, w/2, -1.7/WS]) cylinder(r=1.5/WS, h=1.7/WS);
  // } else {
  }

  // upper connector
  if (l2connector) {
    #translate([-cl, (w - cw) / 2, h-FTH]) cube([cl, cw, FTH]);
    translate([-4/WS, w/2, h-FTH]) cylinder(r=3/2/WS, h=FTH);
    // translate([0, 0, h - (TH+1.5/WS)]) cube([TH, w, TH+1.5/WS]);
    // translate([-cl, (w - cw) / 2, h - (TH+1.5/WS)]) cube([cl, cw, TH]);
    // translate([-4/WS, w/2, h-1.7/WS]) cylinder(r=1.5/WS, h=1.7/WS);
  }
}
