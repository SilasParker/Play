// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sc_Box(_width, _height, _pos_x, _pos_y) constructor {
	
	top = _pos_y - (_height / 2);
	bottom = _pos_y + (_height / 2);
	left = _pos_x - (_width / 2);
	right = _pos_x + (_width / 2);
	
	width = _width;
	height = _height;
	
	center_x = (left + right) / 2;
	center_y = (top + bottom) / 2;
}