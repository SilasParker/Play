with(o_Player) {
	if(protego_health < 20) {
		other.sprite_index = sp_protego_health_bar_1;
	} else if(protego_health < 40) {
		other.sprite_index = sp_protego_health_bar_2;
	} else if(protego_health < 60) {
		other.sprite_index = sp_protego_health_bar_3;
	} else if(protego_health < 80) {
		other.sprite_index = sp_protego_health_bar_4;
	} else {
		other.sprite_index = sp_protego_health_bar_5;
	}
	log(protego_health);
	if(protego_health == 100 || protego_health == 1) {
		other.sprite_index = noone;	
	}
	other.x = x + 3;
	other.y = y - 55;
	if(protego_lockout_frames > 0) protego_lockout_frames--;
}