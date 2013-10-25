
$fn=128;

// mirror
rotate([50,0,0]) translate([0, -4, -16]) cube([150, 1, 150], center=true);

// mirror frame

%rotate([50,0,0]) translate([0, -4, -16]) union()
{
difference()
{
	difference()
	{
		difference()
		{
			union(){
				cube([156, 5, 20], center=true);
				cube([20, 5, 156], center=true);
			}
			translate([0, -2, 0]) cube([145, 4, 145], center=true);
		}
		cube([151, 1.3, 151], center=true);
	}
	translate([0, 0, 44]) cube([156, 10, 68.1], center=true);
}

rotate([90,180,90]) translate([-31.5, 0, 0])
{
	difference() {
		union(){
			cylinder(r=15/2, h=4.5, center=true);
			translate([15, 0, 0]) cube([30, 15, 4.5], center=true);
		}
		cylinder(r=3.2/2, h=20.1, center=true);
	}
}
}




// mirror frame base
rotate([0,0,90]) translate([32, 0, 0]) union()
{
	union()
	{
		rotate([90,0,0])
		{
			difference() {
				difference() {
					union(){
						cylinder(r=15/2, h=10, center=true);
						translate([30, 0, 0]) cube([60, 15, 10], center=true);
					}
					cylinder(r=20/2, h=5, center=true);
				}
				cylinder(r=3.2/2, h=20.1, center=true);
			}
		}
		translate([47.5, 0, -28]) cube([25, 10, 43], center=true);
	}
	rotate([90,0,90]) translate([0, -50.1, 55]) 
	{
		difference()
		{
			cube([65, 3, 40], center=true);
			rotate([-90,0,0])
			{
				translate([-65/2+5, -40/2+5]) cylinder(r=3.5/2, h=10, center=true);
				translate([-65/2+5, -40/2+15]) cylinder(r=3.5/2, h=10, center=true);
				translate([65/2-5, -40/2+5]) cylinder(r=3.5/2, h=10, center=true);
				translate([65/2-5, -40/2+15]) cylinder(r=3.5/2, h=10, center=true);

				translate([-65/2+5, 40/2-5]) cylinder(r=3.5/2, h=10, center=true);
				translate([-65/2+5, 40/2-15]) cylinder(r=3.5/2, h=10, center=true);
				translate([65/2-5, 40/2-5]) cylinder(r=3.5/2, h=10, center=true);
				translate([65/2-5, 40/2-15]) cylinder(r=3.5/2, h=10, center=true);
			}
		}
	}
}
