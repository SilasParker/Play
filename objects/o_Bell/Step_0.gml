/// @description Insert description here
// You can write your code in this editor
with(o_Hurtbox) {
	if(owner == other.id) {
		x = other.x + x_offset;
		y = other.y + y_offset;
	}
}

if(hit_this_frame) {
	log("DING "+string(id));
	hit_this_frame = false;
}