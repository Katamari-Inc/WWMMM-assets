
$fn=128;

//
rotate([90,0,0])
{
	difference() {
		difference() {
			union(){
				cylinder(r=15/2, h=10, center=true);
				translate([15, 0, 0]) cube([30, 15, 10], center=true);
			}
			cylinder(r=20/2, h=5, center=true);
		}
		cylinder(r=3.2/2, h=20.1, center=true);
	}
}
rotate([90,180,0]) translate([20, 0, 0])
{
	difference() {
		union(){
			cylinder(r=15/2, h=4.5, center=true);
			translate([15, 0, 0]) cube([30, 15, 4.5], center=true);
		}
		cylinder(r=3.2/2, h=20.1, center=true);
	}
}
