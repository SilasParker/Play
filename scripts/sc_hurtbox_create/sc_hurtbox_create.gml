function sc_hurtbox_create(_image_xscale, _image_yscale, _x_offset, _y_offset){

	hurtbox = instance_create_layer(
		x, 
		y, 
		"l_boxes",
		o_Hurtbox
	);
	hurtbox.owner = id;
	hurtbox.image_xscale = _image_xscale;
	hurtbox.image_yscale = _image_yscale;
	hurtbox.x_offset = _x_offset;
	hurtbox.y_offset = _y_offset;
	hurtbox.box = new sc_Box(_image_xscale, _image_yscale, x, y);
	
	return hurtbox;

}