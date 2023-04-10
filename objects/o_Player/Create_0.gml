/// @description Insert description here
// You can write your code in this editor
enum states {
	idle,
	run,
	first_jump,
	double_jump,
	fall,
	dash,
	land,
	crouch_idle,
	crouch_walk,
	idle_basic_cast
}

#macro log show_debug_message

actions = {
	idle: new as_idle(),
	run: new as_run(),
	double_jump: new as_double_jump(),
	first_jump: new as_first_jump(),
	fall: new as_fall(),
	dash: new as_dash(),
	crouch_idle: new as_crouch_idle(),
	land: new as_land(),
	idle_basic_cast: new as_idle_basic_cast()
};

fsm = new FSM(actions.fall);

landed = false;
dashable = true;
double_jump = true;
current_plat = noone;
inactionable_frames = 0;
initial_x = x;
initial_y = y;

height_offset = 50 * image_yscale;
idle_basic_cast_offset_x = 22;
idle_basic_cast_offset_y = -32;

x_vel = 0;
y_vel = 0;