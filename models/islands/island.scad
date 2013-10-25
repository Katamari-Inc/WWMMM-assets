N = 22;
TH = 1.4;

translate([0, 0, 0]) {
  linear_extrude(height=TH, convexity=10, twist=0) {
    scale(25.4) import(file=str(N, "/floor.dxf"));
  }
}

t = -(0.4 / 2);

*translate([t, t, 0]) {
  linear_extrude(height=TH+6*0.3, convexity=10, twist=0) {
    scale(25.4) import(file=str(N, "/pillar.dxf"));  
  }
}

#translate([t, t, 0]) {
  linear_extrude(height=TH+1.2, convexity=10, twist=0) {
    scale(25.4) import(file=str(N, "/rail.dxf"));  
  }
}
