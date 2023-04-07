/// @description Insert description here
// You can write your code in this editor
enum states {
	idle,
	run,
	jump,
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
	jump: new as_jump(),
	fall: new as_fall(),
	dash: new as_dash(),
	crouch_idle: new as_crouch_idle(),
	land: new as_land()
};

fsm = new FSM(actions.fall);

landed = false;
dashable = true;
current_plat = noone;
inactionable_frames = 0;
initial_x = x;
initial_y = y;

height_offset = 50 * image_yscale;

x_vel = 0;
y_vel = 0;

is_running_into_wall = function(wall_id) {
	if(next_y >= wall_id.top && next_y <= wall_id.bottom) {
		if(x < wall_id.x && next_x > wall_id.x) {
			return true;
		} else if(x > wall_id.x && next_x < wall_id.x) {
			return true;
		}
	}
	return false;
}