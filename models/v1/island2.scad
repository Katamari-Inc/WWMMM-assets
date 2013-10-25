dir = "i4";

translate([0, 0, 0]) {
  linear_extrude(height=1.2, convexity=10, twist=0) {
    scale(25.4) import(file=str(dir, "/floor.dxf"));
  }
}

t = -(0.6 / 2);

translate([t, t, 0]) {
  linear_extrude(height=6*0.3+1.2, convexity=10, twist=0) {
    scale(25.4) import(file=str(dir, "/rail.dxf"));  
  }
}
