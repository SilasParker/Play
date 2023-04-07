// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sc_handle_collision(){
	
	//fall off platform
	if(current_plat != noone) {
		if(x < current_plat.leftSide || x > current_plat.rightSide) {
			current_plat = noone;
			landed = false;
			fsm.cur_action.to_air(id);
		}
	}
	
	//land on platform
	if(!landed) {
		with(Platform) {
			if(other.x >= leftSide && other.x <= rightSide) {
				if(other.initial_y <= y && other.y >= y) {
					other.current_plat = id;
					other.y = y;
					other.landed = true;
					other.fsm.cur_action.to_ground(other.id);
				}
			}
		}
	}
	
	//running into wall
	var top_y = y - height_offset;
	with(Wall) {
		if((top_y > top && top_y <= bottom) || (other.y > top && other.y <= bottom)) {
			if(other.initial_x < left && other.x >= left) {
				other.x = left-0.1;	
			} else if(other.initial_x > right && other.x <= right) {
				other.x = right+0.1;	
			}
		}
	}
	
	if(landed) {
		dashable = true;
		double_jump = true;
	}
	
}