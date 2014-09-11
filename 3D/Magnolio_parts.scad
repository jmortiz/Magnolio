/* MAGNOLIO QUADCOPTER

FILE: Magnolio_parts.scad

AUTHOR: Jose Manuel Ortiz

DESCRIPTION:
This file is the core of the design, as it contaons all of the modules which represent a part (3D-printed or not) of the design.
All of the dimensions are specified here. You can change them and then use Magnolio_assembly.scad to see the results, or you can uncomment the code right next to each module definition and press F5.
For more info, visit http://make.kinamics.com

LICENSE:
Magnolio by Kinamics is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
http://creativecommons.org/licenses/by-sa/4.0/
*/

include <lib/JMO_library.scad>

body_width = 180;
body_depth = body_width;
body_height = 24;

body_ratio = 0.9;

inside_width = 120;
inside_depth = 60;

wall_width = 6;  //actually wall_width*2

resulting_outside_w = body_width*body_ratio;
resulting_inside_w = resulting_outside_w - wall_width;
echo("resulting_outside_w = ",resulting_outside_w);
echo("resulting_inside_w = ",resulting_inside_w);

arm_tube_diam = 12;
arm_tube_radius = arm_tube_diam/2;  //kept for now for compatiblility

ESC_cavity_width = 62;
ESC_support_h = 2;
ESC_cables_hole_r = 8;
ESC_hole_x = 18;  //input the right measure!
ESC_hole_y = 18; //input the right measure!

ESC_w = 30;
ESC_d = 61;
ESC_h = 12;

bar_width = 19;
bar_height = 2;

pwr_dist_w = 50;
pwr_dist_h = 1.5;
pwr_dist_hole_r = 8;
pwr_dist_border_r = 2;
pwr_dist_fix_hole_pos = 22.5;
pwr_dist_fix_hole_r = 1.6;
pwr_dist_support_h = 4;
pwr_dist_support_w = 8;

ESC_pwr_dist_gap = (resulting_inside_w - pwr_dist_w - ESC_w*2)/2;
ESC_pwr_dist_separator_h = 10;

battery_holder_base_h = 3;
battery_case_w = 35; //inside
battery_case_h = 59; //inside
battery_case_wall_w = 4;
battery_case_d1 = 2;  //chamfer
battery_case_fixer_w = 8;
battery_case_fixer_h = 4;
battery_case_fixer_n = 7.14; // amount of structural triangles on fixer (each side)
battery_case_fixer_triangle_w = 3;
battery_case_fixer_td = resulting_outside_w/battery_case_fixer_n; //distance between triangles

drone_lid_base_h = 3;
drone_lid_h1 = 70;
drone_lid_h2 = 40;
drone_lid_thickness = 2;
drone_lid_bottom_thickness = 20;

GPS_antena_w = 25;
GPS_antena_h = 2;
GPS_antena_r = 3;
GPS_antena_cavity_w = 25.5;
GPS_antena_cavity_r = 3;

arm_tube_l = 330;

motor_r = 45/2;
motor_h = 13;
motor_base_d = 35.7;
motor_base_h = 5;
motor_total_h = motor_h + motor_base_h;
motor_support_gap = 1.5;
motor_support_base_h = 3;
motor_support_wall_w = 2;
motor_support_wall_h = 4.5;
motor_support_tube_l = 30;
motor_support_tube_w = 3;
motor_mount_hole_pos = 15.5; //distance from base center
motor_mount_hole_r = 2.5/2+0.1; //for M2.5 screw
motor_vent_r1 = 6.5;
motor_vent_r2 = 12;
motor_vent_pos = 9.5; //distance from base center
motor_support_total_r = motor_r+motor_support_gap+motor_support_wall_w;

//Main structure, houses power electronics and joins arms
module drone_body_main(){
	color("DarkSlateGray",a=0.1) translate([0,0,body_height/2]) rotate([0,0,-45]){
		difference(){
			//Body base
			intersection(){
				cube([body_width,body_depth,body_height], center=true);
				rotate([0,0,45])
					cube([body_width*body_ratio,body_depth*body_ratio,body_height],center=true);
			}
			//inside cavity
			cube([inside_width,inside_depth,body_height+2],center=true);
		
			rotate([0,0,90])
				cube([inside_width,inside_depth,body_height+2],center=true);
		
			//room for ESCs
			rotate([0,0,45])
				cube([resulting_inside_w,ESC_cavity_width,body_height+1], center=true);
			rotate([0,0,45+90])
				cube([resulting_inside_w,ESC_cavity_width,body_height+1], center=true);
		
			//cavities for tube arms
			rotate([90,0,0])
				cylinder(h=1.1*body_width,d=arm_tube_diam,center=true);
			rotate([90,0,90])
				cylinder(h=1.1*body_width,d=arm_tube_diam,center=true);
			
			//cavities for cross bars
			translate([0,0,body_height/2-bar_height/2+0.5])
				cube([body_width+1,bar_width,bar_height+1],center=true);
			translate([0,0,body_height/2-bar_height+0.5])
				cube([bar_width,body_width+1,bar_height*2+1],center=true);
			translate([0,0,-body_height/2+bar_height-0.5])
				cube([body_width+1,bar_width,bar_height*2+1],center=true);
			translate([0,0,-body_height/2+bar_height/2-0.5])
				cube([bar_width,body_width+1,bar_height+1],center=true);
		}
		
		//platform for electronics
		difference(){
			//platform base
			translate([0,0,-body_height/2+ESC_support_h/2+bar_height*2])
				intersection(){
					cube([body_width,body_depth,ESC_support_h], center=true);
					rotate([0,0,45])
						cube([body_width*body_ratio,body_depth*body_ratio,ESC_support_h],center=true);
				}
			//hole for cables
			translate([ESC_hole_x,ESC_hole_y,-body_height/2+ESC_support_h/2+bar_height*2])
				cylinder(r=ESC_cables_hole_r,h=ESC_support_h*1.2,center=true);
		}
		//support and separators
		for(ang=[0:90:270])
			rotate([0,0,45+ang]){
				//support for power dist PCB
				translate([pwr_dist_fix_hole_pos,
							pwr_dist_fix_hole_pos,
							-body_height/2+pwr_dist_support_h/2+bar_height*2+ESC_support_h])
					difference(){
						cube([pwr_dist_support_w,pwr_dist_support_w,pwr_dist_support_h],center=true);
						cylinder(r=pwr_dist_fix_hole_r,h=pwr_dist_support_h*2,center=true);
					}
				//Pwr dist - ESC separator 1
				translate([(pwr_dist_w+ESC_pwr_dist_gap)/2,
							pwr_dist_fix_hole_pos,
							-body_height/2+ESC_pwr_dist_separator_h/2+bar_height*2+ESC_support_h])
					cube([ESC_pwr_dist_gap,
							pwr_dist_support_w,
							ESC_pwr_dist_separator_h],center=true);
				//Pwr dist - ESC separator 1
				translate([pwr_dist_fix_hole_pos,
							(pwr_dist_w+ESC_pwr_dist_gap)/2,
							-body_height/2+ESC_pwr_dist_separator_h/2+bar_height*2+ESC_support_h])
					cube([pwr_dist_support_w,
							ESC_pwr_dist_gap,
							ESC_pwr_dist_separator_h],center=true);
			}
	}
}

module cross_bar(h=2,w=19,l=180,center=true,angle=0){
	color("DarkGray")
		translate([0,0,h/2])
			rotate([0,0,angle])
				cube([w,l,h],center=center);
}
////bottom bar 1
//translate([0,0,-expand_pieces_d])
//	cross_bar(h=bar_height,w=bar_width,l=body_width,angle=45+90);
////bottom bar 2
//translate([0,0,bar_height-expand_pieces_d])
//	cross_bar(h=bar_height,w=bar_width,l=body_width,angle=45);
//translate([0,0,body_height-bar_height+expand_pieces_d])
//	cross_bar(h=bar_height,w=bar_width,l=body_width,angle=45);
//translate([0,0,body_height-bar_height*2+expand_pieces_d])
//	cross_bar(h=bar_height,w=bar_width,l=body_width,angle=45+90);

module ESC_eRC35A(){
	color("FireBrick")
		translate([0,0,ESC_h/2])
			cube([ESC_w,ESC_d,ESC_h],center=true);
}
//ESCs
//translate([0,0,expand_pieces_d*2])
//	for(ang=[0:90:270])
//		rotate([0,0,ang])
//			translate([(resulting_inside_w-ESC_w)/2,0,bar_height*2+ESC_support_h])
//				ESC_eRC35A();

module power_dist_PCB(){
	color("DarkBlue")
		translate([0,0,pwr_dist_h/2])
			difference(){
				minkowski(){ //generate rounded corners
					cube([pwr_dist_w-pwr_dist_border_r,
							pwr_dist_w-pwr_dist_border_r,
							pwr_dist_h],center=true);
					cylinder(r=pwr_dist_border_r,h=pwr_dist_h);
				}
				cylinder(r=pwr_dist_hole_r, h=pwr_dist_h*8,center=true);
				for(ang=[0:90:270])
					rotate([0,0,ang])
						translate([pwr_dist_fix_hole_pos,pwr_dist_fix_hole_pos,0])
							cylinder(r=pwr_dist_fix_hole_r,h=pwr_dist_h*8,center=true);
			}
}
//translate([0,0,bar_height*2+ESC_support_h+pwr_dist_support_h+expand_pieces_d*2])
//	power_dist_PCB();

module battery_holder_base(){
	color("DarkSlateGray",a=0.1){
		difference(){
			rotate([0,0,45])
				translate([-body_width/2, -body_depth/2, 0])
					intersection(){
						translate([body_width/2, body_depth/2, battery_holder_base_h/2])
							rotate(a=[0,0,45])
								cube([body_width*body_ratio,
										body_depth*body_ratio,
										battery_holder_base_h],center=true);
							cube([body_width,body_depth,battery_holder_base_h]);
				}
			//hole for cables
			translate([ESC_hole_x,ESC_hole_y,battery_holder_base_h-ESC_support_h*0.5])
				cylinder(r=ESC_cables_hole_r,h=ESC_support_h*3,center=true);
		}
		//top separators
		for(ang=[0:90:270])
			rotate([0,0,ang])
				translate([0,resulting_inside_w/2-11.5,battery_holder_base_h+bar_height])
					cube([ESC_cavity_width-2,20,bar_height*2],center=true);
		//bar cavity filler
		rotate([0,0,-45])
			translate([body_width/2-10,0,battery_holder_base_h+bar_height/2])
				cube([20,bar_width-1.5,bar_height], center=true);
		rotate([0,0,135])
			translate([body_width/2-10,0,battery_holder_base_h+bar_height/2])
				cube([20,bar_width-1.5,bar_height], center=true);
	}
}
//translate([0,0,-battery_holder_base_h-expand_pieces_d*2])
//	battery_holder_base();

module battery_holder_case(){
	color("DarkSlateGray",a=0.1){
		rotate([0,180,0]) case_base_open(l=resulting_outside_w,h=battery_case_h,w=battery_case_w,d1=1);
		//add border for fixing to base
		translate([battery_case_w/2+battery_case_wall_w+battery_case_fixer_w/2,0,-battery_case_fixer_h/2])
			cube([battery_case_fixer_w,resulting_outside_w,battery_case_fixer_h],center=true);
		translate([-(battery_case_w/2+battery_case_wall_w+battery_case_fixer_w/2),0,-battery_case_fixer_h/2])
			cube([battery_case_fixer_w,resulting_outside_w,battery_case_fixer_h],center=true);
		//structural triangles on fixing border
		for(p=[-resulting_outside_w/2:battery_case_fixer_td:resulting_outside_w/2])
			translate([0,p+battery_case_fixer_triangle_w,0])
				rotate([90,0,0])
					linear_extrude(height=battery_case_fixer_triangle_w)
						polygon(points=[[battery_case_w/2+battery_case_wall_w,-battery_case_fixer_h],
							[battery_case_w/2+battery_case_wall_w+battery_case_fixer_w,-battery_case_fixer_h],
							[battery_case_w/2+battery_case_wall_w,-battery_case_fixer_h-battery_case_fixer_w]]);
		rotate([0,0,180])
		for(p=[-resulting_outside_w/2:battery_case_fixer_td:resulting_outside_w/2])
			translate([0,p+battery_case_fixer_triangle_w,0])
				rotate([90,0,0])
					linear_extrude(height=battery_case_fixer_triangle_w)
						polygon(points=[[battery_case_w/2+battery_case_wall_w,-battery_case_fixer_h],
							[battery_case_w/2+battery_case_wall_w+battery_case_fixer_w,-battery_case_fixer_h],
							[battery_case_w/2+battery_case_wall_w,-battery_case_fixer_h-battery_case_fixer_w]]);
		//close back
		translate([0,(resulting_outside_w-battery_case_wall_w)/2,-battery_case_h/2])
			cube([battery_case_w,battery_case_wall_w,battery_case_h],center=true);
	}
}
//translate([0,0,-battery_holder_base_h-expand_pieces_d*3])
//	battery_holder_case();

module radio_rx(){
	color("Silver") translate([0,0,5.52])
		cube([29.3,30.1,11.4],center=true);
}

module GPS_module(){
	//PCB
	color("LimeGreen") translate([0,0,0.55]) cube([32,32,1.1], center=true);
	//antena base
	color("LightYellow")
		translate([0,0,0.55+GPS_antena_h/2])
			resize([GPS_antena_w,GPS_antena_w,GPS_antena_h])
				minkowski(){
					cube([GPS_antena_w,
						GPS_antena_w,GPS_antena_h],center=true);
					cylinder(r=GPS_antena_r,h=GPS_antena_h);
				}
	//antena silver part
	color("Silver") 
		translate([0,0,1.15+GPS_antena_h]) cube([20,20,0.1],center=true);
}
//GPS_module();

module drone_top_layer_base(){
	color("DarkSlateGray"){
		difference(){
			rotate([0,0,45])
				translate([-body_width/2, -body_depth/2, 0])
					intersection(){
						translate([body_width/2, body_depth/2, drone_lid_base_h/2])
							rotate(a=[0,0,45])
								cube([body_width*body_ratio,
										body_depth*body_ratio,
										drone_lid_base_h],center=true);
							cube([body_width,body_depth,drone_lid_base_h]);
				}
			//hole for cables
			translate([ESC_hole_x,ESC_hole_y,battery_holder_base_h-ESC_support_h*0.5])
				cylinder(r=ESC_cables_hole_r,h=ESC_support_h*3,center=true);
		}
			//bar cavity filler
			rotate([0,0,45])
				translate([body_width/2-10,0,-bar_height/2])
					cube([20,bar_width-1.5,bar_height], center=true);
			rotate([0,0,180+45])
				translate([body_width/2-10,0,-bar_height/2])
					cube([20,bar_width-1.5,bar_height], center=true);
			//bottom separators
			for(ang=[0:90:270])
				rotate([0,0,ang])
					translate([0,resulting_inside_w/2-11.5,-bar_height])
						cube([ESC_cavity_width-2,20,bar_height*2],center=true);
	}
}
//translate([0,0,50]) drone_top_layer_base();

module drone_top_layer(){
	drone_top_layer_base();
	translate([-20,-25,drone_lid_base_h]) rotate([90,0,90]) color("SlateGray") import("resources/APM 2.5 Side Entry Case.STL");
	translate([-2,-50,drone_lid_base_h]) radio_rx();
}
//translate([0,0,body_height+expand_pieces_d*3]) drone_top_layer();

//for drawing actual lid only, do not print!
module drone_lid_solid_base(w=180,l=180,h1=70,h2=40,ratio=0.9){
	difference(){
		rotate([0,0,45])
			intersection(){
				rotate([0,0,45])
					pyramid_square_base(w=w*ratio,l=l*ratio,h=h1);
				pyramid_square_base(w=w,l=l,h=h1);
			}
		translate([0,0,h2+h1/2]) cube([w,l,h1],center=true);
	}
}
//translate([0,0,100]) drone_lid_solid_base();

module drone_lid(only_print=false){
	color("DarkSlateGray")
	render(){
		difference(){
			drone_lid_solid_base(w=body_width,
						l=body_depth,
						h1=drone_lid_h1,
						h2=drone_lid_h2,
						ratio=body_ratio);
			//resize([body_width*body_ratio-drone_lid_thickness*2,
			//		body_depth*body_ratio-drone_lid_thickness*2,
			//		drone_lid_h2-drone_lid_thickness*2])
			drone_lid_solid_base(w=body_width-drone_lid_bottom_thickness,
						l=body_depth-drone_lid_bottom_thickness,
						h1=drone_lid_h1,
						h2=drone_lid_h2-drone_lid_thickness,
						ratio=body_ratio);
			//hole for GPS antena
			translate([0,0,drone_lid_h2-1])
				resize([GPS_antena_cavity_w,GPS_antena_cavity_w,10])
					minkowski(){
						cube([GPS_antena_cavity_w,
							GPS_antena_cavity_w,10],center=true);
						cylinder(r=GPS_antena_cavity_r,h=10);
					}
		}
	}
	if(!only_print) //GPS module
		translate([0,0,drone_lid_h2-drone_lid_thickness-1.1]) GPS_module();
}
//translate([0,0,body_height+drone_lid_base_h+expand_pieces_d*4])
//difference(){
//drone_lid();
//cut
//translate([body_width/2,0,drone_lid_h1/2-1]) cube([body_width,body_width,drone_lid_h1],center=true);
//}
module arm_tube(l=400,re=6,ri=5){
	color("DarkGray")
		rotate([0,90,0])
			difference(){
				cylinder(r=re,h=l);
				translate([0,0,-0.5]) cylinder(r=ri,h=l+1);
			}
}
//arm_tube();

module motor_arm_support(){
	color("DarkSlateGray"){
		translate([0,0,-(arm_tube_radius+motor_support_tube_w)]){  //center on X axis
			difference(){
				//main body, composed of base cylinder and tube holding cylinder
				hull(){
					//base support for motor
					translate([motor_support_total_r,0,(motor_support_wall_h+motor_support_base_h)/2])
						cylinder(r=motor_support_total_r,
							h=motor_support_base_h+motor_support_wall_h,
							center=true);
					//tube envelope
					translate([-motor_support_tube_l,0,arm_tube_radius+motor_support_tube_w])
						rotate([0,90,0])
							cylinder(r=arm_tube_radius+motor_support_tube_w,h=motor_support_tube_l);
				}
				//motor cavity
				translate([motor_r+motor_support_gap+motor_support_wall_w,0,motor_support_wall_h*2+motor_support_base_h])
					cylinder(r=motor_r+motor_support_gap,h=motor_support_wall_h*4,center=true);
				//tube cavity
				translate([-motor_support_tube_l-2,0,arm_tube_radius+motor_support_tube_w])
						rotate([0,90,0])
							cylinder(r=arm_tube_radius,h=motor_support_tube_l+10);
				//holes on motor platform
				translate([motor_r+motor_support_gap+motor_support_wall_w,0,0]){
					//cylinder(r=4, h=motor_support_base_h*3,center=true); //center hole for bearing
					for(ang=[60:120:360])  //motor mount holes
						rotate([0,0,ang])
							render()
							translate([-motor_mount_hole_pos,0,0]){
								cylinder(r=motor_mount_hole_r, h=motor_support_base_h*3,center=true); //hole
								cylinder(d1=4.7, d2=2.5+0.2, h=1.5);  //countersink
							}
					for(ang=[0:120:360])  //motor vent holes
						rotate([0,0,180+ang])
							translate([motor_vent_pos,0,0])
								cylinder(r=motor_vent_r1, h=motor_support_base_h*3,center=true);
				}
				translate([-motor_support_tube_l/4,0,-1]) cylinder(r=3.2/2+0.1, h=(motor_support_total_r)*3);
				translate([-motor_support_tube_l*3/4,0,-1]) cylinder(r=3.2/2+0.1, h=(motor_support_total_r)*3);
				//translate([0,0,-25]) cube([70,70,50],center=true);
			}
			//fill cylinder for vent holes
			translate([motor_r+motor_support_gap+motor_support_wall_w,0,0]) cylinder(r=motor_vent_r2,h=motor_support_base_h);
		}
	}
}
//motor_arm_support();
module bldc_motor_AX4008D(){
	color("MidnightBlue") cylinder(d=motor_base_d, h=motor_base_h);
	color("Silver") translate([0,0,motor_base_h]) cylinder(r=motor_r,h=motor_h);
}
//bldc_motor_AX4008D();
module propeller(){
	color("Black")
	translate([-30,98,0]) rotate([90,0,0]) import("resources/propeller 8x3.8.STL");
}
//propeller();