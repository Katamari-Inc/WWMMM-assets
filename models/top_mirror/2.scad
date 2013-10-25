
$fn=128;

// mirror
%cube([150, 1, 150], center=true);

// mirror frame
difference()
{
	difference()
	{
		difference()
		{
			union(){
				cube([156, 7, 20], center=true);
				cube([20, 7, 156], center=true);
			}
			translate([0, -2, 0]) cube([145, 4, 145], center=true);
		}
		cube([151.5, 1.5, 151.5], center=true);
	}
	translate([0, 0, 44]) cube([156, 10, 68.1], center=true);
}

rotate([90,180,90]) translate([-31.5, -2.5, 0])
{
	difference() {
		union(){
			cylinder(r=15/2, h=4.5, center=true);
			translate([15, 0, 0]) cube([30, 15, 4.5], center=true);
		}
		cylinder(r=3.2/2, h=20.1, center=true);
	}
}

