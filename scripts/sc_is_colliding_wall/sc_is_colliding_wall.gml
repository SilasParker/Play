function sc_is_colliding_wall(){
	with(o_Player) {
		var next_x = x + x_vel;
		var top_y = y - height_offset;
		
		with(Wall) {
			if((top_y > top && top_y <= bottom) || (other.y > top && other.y <= bottom)) {
				if(other.initial_x < left && next_x >= left) {
					return "left";
				} else if(other.initial_x > right && next_x <= right) {
					return "right";
				}
			}
		}
	}
	return false;
}