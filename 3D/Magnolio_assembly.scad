/* MAGNOLIO QUADCOPTER
FILE: Magnolio_assembly.scad

AUTHOR: Jose Manuel Ortiz

DESCRIPTION:
This file calls Magnolio_parts.scad modules which represent a part (3D-printed or not) of the design and places them into the corresponding position on the design.
All of the dimensions are specified on Magnolio_parts.scad. Change the parameters on that file and use this one to see the results.
For more info, visit http://make.kinamics.com

LICENSE:
Magnolio by Kinamics is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
http://creativecommons.org/licenses/by-sa/4.0/
*/

include <Magnolio_parts.scad>

expand_pieces_d = 60;  //assign to 0 and pieces will move to position, otherwise the expanded view will be shown

drone_body_main();

//bottom bar 1
translate([0,0,-expand_pieces_d])
	cross_bar(h=bar_height,w=bar_width,l=body_width,angle=45+90);
//bottom bar 2
translate([0,0,bar_height-expand_pieces_d])
	cross_bar(h=bar_height,w=bar_width,l=body_width,angle=45);
//ESCs
translate([0,0,expand_pieces_d])
	for(ang=[0:90:270])
		rotate([0,0,ang])
			translate([(resulting_inside_w-ESC_w)/2,0,bar_height*2+ESC_support_h])
				ESC_eRC35A();
//Power distribution PCB
translate([0,0,bar_height*2+ESC_support_h+pwr_dist_support_h+expand_pieces_d])
	power_dist_PCB();
//top bar 1
translate([0,0,body_height-bar_height+expand_pieces_d*2])
	cross_bar(h=bar_height,w=bar_width,l=body_width,angle=45);
//top bar 2
translate([0,0,body_height-bar_height*2+expand_pieces_d*2])
	cross_bar(h=bar_height,w=bar_width,l=body_width,angle=45+90);

//bottom base for battery
translate([0,0,-battery_holder_base_h-expand_pieces_d*2])
	battery_holder_base();
//battery holder
translate([0,0,-battery_holder_base_h-expand_pieces_d*3])
	battery_holder_case();
//top layer with electronics
translate([0,0,body_height+expand_pieces_d*3]) drone_top_layer();
//drone lid
translate([0,0,body_height+drone_lid_base_h+expand_pieces_d*4]) drone_lid();

//drone arms + motor support + motors
for(ang=[0:90:270])
	rotate([0,0,45+ang])
		translate([inside_width/2+expand_pieces_d,0,body_height/2]){
			arm_tube(l=arm_tube_l);
			translate([arm_tube_l+expand_pieces_d,0,0]) motor_arm_support();
			translate([arm_tube_l+motor_support_total_r+expand_pieces_d,
					0,
					-arm_tube_radius+expand_pieces_d])
				bldc_motor_AX4008D();
			translate([arm_tube_l+motor_support_total_r+expand_pieces_d,0,motor_total_h-5+expand_pieces_d*2]) propeller();
		}
