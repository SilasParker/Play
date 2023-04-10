function FSM(init_state) constructor {

	cur_action = init_state;
	
	step = function(p) {
		
		cur_action.step(p);
		if (cur_action.interrupt(p)) return;
		// maybe other stuff
		
	}
	
	transition = function(p, _new_state) {
		
		cur_action._exit(p);
		cur_action = _new_state;
		cur_action.init(p);
		cur_action.step(p); // if u wanted to
		
	}

}


function actionstate() constructor {
	
	init = function(p) {}
	
	step = function(p) {}
	
	interrupt = function(p) { return false }
	
	on_wall_collide = function(p) {}
	
	to_ground = function(p) {}
	
	to_air = function(p) {}
	
	_exit = function(p) {}
	
}

function as_airbourne() : actionstate() constructor {

	to_ground = function(p) {
		p.fsm.transition(p,p.actions.land);
	}

}

function as_grounded() : actionstate() constructor {

	to_air = function(p) {
		p.fsm.transition(p,p.actions.fall);
	}

}

function as_idle() : as_grounded() constructor {
	
	init  = function(p) {
		p.state = states.idle;
		p.landed = true;
		p.sprite_index = Idle;
	}
	
	step = function(p) {
		if(p.x_vel != 0) {
			p.x_vel -= 0.5 * p.image_xscale;	
		}
	}
	
	interrupt = function(p) {
		if(keyboard_check(vk_left) || keyboard_check(vk_right)) {
			p.fsm.transition(p,p.actions.run);
			return true;
		} else if(keyboard_check(vk_up)) {
			p.fsm.transition(p,p.actions.first_jump);
			return true;
		} else if(keyboard_check(vk_down)) {
			p.fsm.transition(p,p.actions.crouch_idle);
			return true;
		} else if(keyboard_check_pressed(vk_shift) && p.dashable) {
			p.fsm.transition(p,p.actions.dash);
			return true;
		}
		return false;
	}
	
}

function as_run() : as_grounded() constructor {
	
	init = function(p) {
		p.state = states.run;
		p.sprite_index = Run;
	}
	
	step = function(p) {
		if(keyboard_check(vk_left)) {
			p.image_xscale = -1;
			p.x_vel = -4;
		} else if(keyboard_check(vk_right)) {
			p.image_xscale = 1;
			p.x_vel = 4;
		}
	}
	
	interrupt = function(p) {
		if(keyboard_check(vk_up)) {
			p.fsm.transition(p,p.actions.first_jump);
			return true;
		} else if(keyboard_check(vk_down)) {
			p.fsm.transition(p,p.actions.crouch_idle);
			return true;
		} else if(keyboard_check_pressed(vk_shift) && p.dashable) {
			p.fsm.transition(p,p.actions.dash);
			return true;
		} else if(!(keyboard_check(vk_left) || keyboard_check(vk_right))) {
			p.fsm.transition(p,p.actions.idle);
			return true;	
		}
		return false;
	}
	
}

function as_jump() : as_airbourne() constructor {
	
	step = function(p) {
		p.y_vel += 0.2;
		if(keyboard_check(vk_left)) {
			p.image_xscale = -1;
			p.x_vel = -4;
		} else if(keyboard_check(vk_right)) {
			p.image_xscale = 1;
			p.x_vel = 4;
		}
	}
	
}

function as_first_jump() : as_jump() constructor {
	
	init = function(p) {
		p.y_vel = -4;
		p.state = states.first_jump;
		p.landed = false;
		p.current_plat = noone;
		p.sprite_index = JumpRise;
	}
	
	interrupt = function(p) {
		if(p.y_vel > 0) {
			p.fsm.transition(p,p.actions.fall);
			return true;
		} else if(keyboard_check(vk_shift) && p.dashable) {
			p.fsm.transition(p,p.actions.dash);
			return true;
		} else if(keyboard_check_pressed(vk_up)) {
			p.double_jump = false;
			p.fsm.transition(p,p.actions.double_jump);
			return true;
		}
		return false;
	}
	
}

function as_double_jump() : as_jump() constructor {
	
	init = function(p) {
		p.y_vel = -3.5;
		p.state = states.double_jump;
		p.sprite_index = JumpRise;
	}
	
	interrupt = function(p) {
		if(p.y_vel > 0) {
			p.fsm.transition(p,p.actions.fall);
			return true;
		} else if(keyboard_check_pressed(vk_shift) && p.dashable) {
			p.fsm.transition(p,p.actions.dash);
			return true;
		}
		return false;
	}
	
	
	
}

function as_fall() : as_airbourne() constructor {

	init = function(p) {
		p.state = states.fall;
		p.landed = false;
		p.sprite_index = JumpFall;
	}
	
	step = function(p) {
		p.y_vel += 0.2;
		if(keyboard_check(vk_left)) {
			p.image_xscale = -1;
			p.x_vel = -4;
		} else if(keyboard_check(vk_right)) {
			p.image_xscale = 1;
			p.x_vel = 4;
		}
		if(keyboard_check(vk_down)) {
			p.y_vel += 2;	
		}
		if((p.x_vel > 4 && p.image_xscale = 1) || (p.x_vel < -4 && p.image_xscale = -1)) {
			p.x_vel -= 0.5 * p.image_xscale;
		}
	}
	
	interrupt = function(p) {
		if(keyboard_check_pressed(vk_shift) && p.dashable) {
			p.fsm.transition(p,p.actions.dash);
			return true;
		} else if(keyboard_check_pressed(vk_up) && p.double_jump) {
			p.double_jump = false;
			p.fsm.transition(p,p.actions.double_jump);
			return true;
		}
		return false;
	}

}

function as_land() : as_grounded() constructor {
	
	init = function(p) {
		p.y_vel = 0;
		p.dashable = true;
		p.double_jump = true;
	}
	
	interrupt = function(p) {
		p.fsm.transition(p,p.actions.idle);
		return true;
	}
	
}

function as_dash() : actionstate() constructor {
	
	init = function(p) {
		p.state = states.dash;
		p.inactionable_frames = 10;
		p.y_vel = 0;
		p.dashable = false;
		p.sprite_index = Dash;
		p.x_vel = p.image_xscale * 10;
	}
	
	step = function(p) {
		p.inactionable_frames -= 1;
	}
	
	interrupt = function(p) {
		if(p.inactionable_frames == 0) {
			if(p.landed) {
				p.fsm.transition(p,p.actions.idle);
				return true;
			}
			p.fsm.transition(p,p.actions.fall);
			return true;
		}
		return false;
	}
	
}

function as_crouch_idle() : as_grounded() constructor {

	init = function(p) {
		p.sprite_index = CrouchIdle;
		p.state = states.crouch_idle;
	}
	
	step = function(p) {
		if(p.x_vel	!= 0) {
			p.x_vel -= p.image_xscale;	
		}
	}
	
	interrupt = function(p) {
		if(keyboard_check_pressed(vk_shift) && p.dashable) {
			p.fsm.transition(p,p.actions.dash);
			return true;
		} else if(!keyboard_check(vk_down)) {
			p.fsm.transition(p,p.actions.idle);
			return true;
		}
		return false;
	}

}