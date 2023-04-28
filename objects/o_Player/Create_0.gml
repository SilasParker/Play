/// @description Insert description here
// You can write your code in this editor
enum states {
	idle,
	run,
	first_jump,
	double_jump,
	fall,
	land,
	crouch_idle,
	crouch_walk,
	idle_basic_cast,
	air_basic_cast,
	aim_basic_cast,
	wall_jump
}

#macro log show_debug_message

actions = {
	idle: new as_idle(),
	run: new as_run(),
	double_jump: new as_double_jump(),
	first_jump: new as_first_jump(),
	fall: new as_fall(),
	crouch_idle: new as_crouch_idle(),
	land: new as_land(),
	idle_basic_cast: new as_idle_basic_cast(),
	air_basic_cast: new as_air_basic_cast(),
	aim_basic_cast: new as_aim_basic_cast(),
	wall_jump: new as_wall_jump()
};

fsm = new FSM(actions.fall);

landed = false;
double_jump = true;
current_plat = noone;
inactionable_frames = 0;
initial_x = x;
initial_y = y;
colliding_this_frame = false;
wall_jump = true;

height_offset = 50 * image_yscale;
idle_basic_cast_offset_x = 22;
idle_basic_cast_offset_y = -32;
air_basic_cast_offset_x = 21;
air_basic_cast_offset_y = -38;
aim_basic_cast_offset_x = 5;
aim_basic_cast_offset_y = -32;


x_vel = 0;
y_vel = 0;