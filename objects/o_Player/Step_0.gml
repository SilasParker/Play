/// @description Insert description here
// You can write your code in this editor

next_x = x + x_vel;
next_y = y + y_vel;



fsm.step(id);

sc_handle_movement();
sc_handle_collision();

last_key = keyboard_key;