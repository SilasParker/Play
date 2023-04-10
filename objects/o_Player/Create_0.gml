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
	land: new as_land()
};

fsm = new FSM(actions.fall);

landed = false;
dashable = true;
double_jump = true;
current_plat = noone;
inactionable_frames = 0;
initial_x = x;
initial_y = y;
last_key = 0;

height_offset = 50 * image_yscale;

x_vel = 0;
y_vel = 0;