module ttt(l) {
    for (i = [1:20]) {
      translate([pow(i/10,2)+i*5, 0, 0]) cube([i/10, l, 5]); 
    }
}

ttt(3);
translate([0, 12]) ttt(5);
translate([0, 25]) ttt(10);

# translate([0, -5, -1]) cube([110, 45, 1]);
