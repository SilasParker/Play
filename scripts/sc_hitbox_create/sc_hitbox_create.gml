// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sc_hitbox_create(_image_xscale, _image_yscale, _x_offset, _y_offset, _life){

	hitbox = instance_create_layer(
		x, 
		y,
		"l_boxes",
		o_Hitbox
	);
	hitbox.owner = id;
	hitbox.image_xscale = _image_xscale;
	hitbox.image_yscale = _image_yscale;
	hitbox.x_offset = _x_offset;
	hitbox.y_offset = _y_offset;
	hitbox.life = _life;
	hitbox.box = new sc_Box(_image_xscale, _image_yscale, x, y);

	return hitbox;
	
}