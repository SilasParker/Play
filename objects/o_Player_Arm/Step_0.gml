/// @description Insert description here
// You can write your code in this editor



image_angle = point_direction(x, y, mouse_x, mouse_y)

if(sign(image_yscale) > 0 && mouse_x < x) {
	image_angle = point_direction(x, y, x, mouse_y)	
}

if(sign(image_yscale) < 0 && mouse_x > x) {
	image_angle = point_direction(x, y, x, mouse_y) 
}
if(sign(image_yscale) == 1) {
	if(image_angle < 180 && image_angle > aim_max_top_right) {
		image_angle = aim_max_top_right;	
	} else if(image_angle > 180 && image_angle < aim_max_bottom_right) {
		image_angle = aim_max_bottom_right;	
	}
}
	
if(sign(image_yscale) == -1) {
	if(image_angle > 0 && image_angle < aim_max_top_left) {
		image_angle = aim_max_top_left;	
	} else if(image_angle < 360 && image_angle > aim_max_bottom_left) {
		image_angle = aim_max_bottom_left;	
	}	
}

if(mouse_check_button_pressed(mb_left)) {
	instance_create_layer(
		x+(wand_tip_offset * dcos(image_angle)),
		y-(wand_tip_offset * dsin(image_angle)),
		"l_magic",
		o_Basic_Cast, 
		{ 
			xscale: image_xscale,
			angle: image_angle
		}
	);	
}