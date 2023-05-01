// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sc_are_colliding_boxes(_box1, _box2){
	
	/*
	var diff_x = _box1.center_x - _box2.center_x;
	var diff_y = _box1.center_y - _box2.center_y;
	
	log("x diff: "+string(diff_x));
	log("y diff: "+string(diff_y));

	
	if((_box1.width + _box2.width) * 0.5 <= abs(diff_x)) return false;
	if((_box1.height + _box2.height) * 0.5 <= abs(diff_y)) return false;
	
	return true;*/
	
	var diff_x = _box1.x - _box2.x;
	var diff_y = _box1.y - _box2.y;
	
	if((_box1.sprite_width + _box2.sprite_width) * 0.5 <= abs(diff_x)) return false;
	if((_box1.sprite_height + _box2.sprite_height) * 0.5 <= abs(diff_y)) return false;
	
	return true;
	
}