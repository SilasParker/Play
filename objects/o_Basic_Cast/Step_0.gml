/// @description Insert description here
// You can write your code in this editor

if(active) {



	initial_x = x;
	initial_y = y;

	x += x_vel;
	y += y_vel;

	with(Wall) {
		if((other.y > top && other.y <= bottom) || (other.y > top && other.y <= bottom)) {
			if((other.initial_x < left_real && other.x >= left_real)
				|| (other.initial_x > right_real && other.x <= right_real)
			) {
				other.sprite_index = sp_Shot_Dissipate;
				other.active = false;
			}
		}
	}
	
	with(Platform) {
			if(other.x >= leftSide && other.x <= rightSide) {
				if(other.initial_y <= y && other.y >= y) {
					other.sprite_index = sp_Shot_Dissipate;
					other.active = false;
				}
			}
		}
	
	if(active_frames > 0) {
		active_frames -= 1;
	} else {
		sprite_index = sp_Shot_Dissipate;
		active = false;
	}

} else {

	if(image_index == 8) {
		instance_destroy(id);	
	}

}



