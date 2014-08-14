/* MAGNOLIO QUADCOPTER

FILE: JMO_library.scad

AUTHOR: Jose Manuel Ortiz

DESCRIPTION:
General purpose primitive modules

LICENSE:
Magnolio by Kinamics is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
http://creativecommons.org/licenses/by-sa/4.0/
*/

//an open case with open base, wall width d and chamfer specified by d1
module case_base_open(l=160, h=32, w=55, d=4, d1=2){
	h1 = sqrt(w*w/4+h*h);
	h2 = h1-d1-d;
	x1 = w*h1/(2*h2);
	y1 = h*h1/h2;
	x2 = d1*w/(2*h1);
	alpha = atan(2*h/w);
	//echo("h1=",h1," h2=",h2," x1=",x1," y1=",y1," x2=",x2, " alpha=",alpha);
	
	rotate([90,0,0])
	translate([0,0,-l/2])
	difference(){
		union(){
			//main box
			translate([w/2,0,0]) cube([d,h,l]);
			translate([0,d/2+h,l/2]) cube([w+2*d,d,l],center=true);
			translate([-w/2-d,0,0]) cube([d,h,l]);
			
			//chamfers
			rotate([0,0,90-alpha])
				translate([0,h2+d/2+d,l/2])
					cube([2*x2+2*d,d,l],center=true);
			rotate([0,0,-90+alpha])
				translate([0,h2+d/2+d,l/2])
					cube([2*x2+2*d,d,l],center=true);
		}
		//remove excess
		rotate([0,0,90-alpha])
				translate([0,h2+3*d,l/2])
					cube([2*x2+2*d,2*d,l+1],center=true);
		rotate([0,0,-90+alpha])
				translate([0,h2+3*d,l/2])
					cube([2*x2+2*d,2*d,l+1],center=true);
		translate([w/2+d,0,-0.5]) cube([d,h+2*d,l+1]);
		translate([0,d+d/2+h,l/2]) cube([w+2*d,d,l+1],center=true);
		translate([-w/2-2*d,0,-0.5]) cube([d,h+3*d,l+1]);
	}
}
//case_base_open();

//Pyramid module: generalization of Openscad manual example
module pyramid_square_base(w=10, l=10, h=10){
	polyhedron(
		points=[ [w/2,l/2,0],[w/2,-l/2,0],[-w/2,-l/2,0],[-w/2,l/2,0], // the four points at base
           [0,0,h]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]);                         // two triangles for square base
}
//pyramid_square_base(w=150, l=150, h=60);

