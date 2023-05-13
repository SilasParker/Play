function sc_hurtbox_create(_image_xscale, _image_yscale, _x_offset, _y_offset, _id){
	hurtbox = instance_create_layer(
		_id.x + _x_offset, 
		_id.y + _y_offset, 
		"l_boxes",
		o_Hurtbox
	);
	hurtbox.owner = _id;
	hurtbox.image_xscale = _image_xscale;
	hurtbox.image_yscale = _image_yscale;
	hurtbox.x_offset = _x_offset;
	hurtbox.y_offset = _y_offset;
	hurtbox.box = new sc_Box(_image_xscale, _image_yscale, _id.x, _id.y);
	
	return hurtbox;

}