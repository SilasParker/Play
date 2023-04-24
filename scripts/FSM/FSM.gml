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
			p.x_vel = sign(p.x_vel) * max(0, abs(p.x_vel) - 0.5);
		}
	}
	
	interrupt = function(p) {
		if(keyboard_check(vk_space)) {
			p.fsm.transition(p,p.actions.aim_basic_cast);
			return true;
		} 
		if(keyboard_check(ord("A")) || keyboard_check(ord("D"))) {
			p.fsm.transition(p,p.actions.run);
			return true;
		} else if(keyboard_check(ord("W"))) {
			p.fsm.transition(p,p.actions.first_jump);
			return true;
		} else if(keyboard_check(ord("S"))) {
			p.fsm.transition(p,p.actions.crouch_idle);
			return true;
		} else if(mouse_check_button_pressed(mb_left)) {
			p.fsm.transition(p,p.actions.idle_basic_cast);
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
		if(keyboard_check(ord("A"))) {
			p.image_xscale = -1;
			p.x_vel = -4;
		} else if(keyboard_check(ord("D"))) {
			p.image_xscale = 1;
			p.x_vel = 4;
		}
	}
	
	interrupt = function(p) {
		if(keyboard_check(vk_space)) {
			p.fsm.transition(p,p.actions.aim_basic_cast);
			return true;
		} 
		if(keyboard_check(ord("W"))) {
			p.fsm.transition(p,p.actions.first_jump);
			return true;
		} else if(keyboard_check(ord("S"))) {
			p.fsm.transition(p,p.actions.crouch_idle);
			return true;
		} else if(!(keyboard_check(ord("A")) || keyboard_check(ord("D")))) {
			p.fsm.transition(p,p.actions.idle);
			return true;	
		} else if(mouse_check_button_pressed(mb_left)) {
			p.fsm.transition(p,p.actions.idle_basic_cast);
			return true;
		}
		return false;
	}
	
}

function as_jump() : as_airbourne() constructor {
	
	step = function(p) {
		p.y_vel += 0.2;
		if(keyboard_check(ord("A"))) {
			p.image_xscale = -1;
			p.x_vel = -4;
		} else if(keyboard_check(ord("D"))) {
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
		}
		if(keyboard_check_pressed(ord("W"))) {
			p.double_jump = false;
			p.fsm.transition(p,p.actions.double_jump);
			return true;
		}
		if(mouse_check_button_pressed(mb_left)) {
			p.fsm.transition(p,p.actions.air_basic_cast);
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
		} else if(mouse_check_button_pressed(mb_left)) {
			p.fsm.transition(p,p.actions.air_basic_cast);
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
		if(!keyboard_check(ord("S"))) {
			p.fsm.transition(p,p.actions.idle);
			return true;
		}
		return false;
	}

}

function as_air_basic_cast() : as_airbourne() constructor {

	init = function(p) {
		p.sprite_index = sp_Jump_Rise_Shoot;
		p.state = states.air_basic_cast;
	}
	
	step = function(p) {
		p.y_vel += 0.2;
		if(keyboard_check(ord("S"))) {
			p.x_vel = -4;	
		} else if(keyboard_check(ord("D"))) {
			p.x_vel = 4;	
		}
		if((p.x_vel > 4 && p.image_xscale = 1) || (p.x_vel < -4 && p.image_xscale = -1)) {
			p.x_vel -= 0.5 * p.image_xscale;
		}
		if(p.image_index == 5) {
			instance_create_layer(
				p.x+(p.air_basic_cast_offset_x * p.image_xscale),
				p.y+p.air_basic_cast_offset_y,
				"Player",
				o_Basic_Cast, 
				{ 
					xscale: p.image_xscale,
					angle: 0
				}
			);	
		}
	}
	
	interrupt = function(p) {
		if(p.image_index == 12) {
			if(p.y_vel < 0) {
				if(p.double_jump) {
					p.fsm.transition(p,p.actions.first_jump);
				} else {
					p.fsm.transition(p,p.actions.double_jump);	
				}
			} else {
				p.fsm.transition(p,p.actions.fall);	
			}
			return true;
		}
		return false;
	}

}

function as_idle_basic_cast() : as_grounded() constructor {
	
	init = function(p) {
		p.sprite_index = sp_Idle_Shoot;
		p.state = states.idle_basic_cast;
		p.x_vel = 0;
		p.image_index = 0;
	}
	
	step = function(p) {
		if(p.image_index == 5) {
			instance_create_layer(
				p.x+(p.idle_basic_cast_offset_x * p.image_xscale),
				p.y+p.idle_basic_cast_offset_y,
				"l_magic",
				o_Basic_Cast, 
				{ 
					xscale: p.image_xscale,
					angle: 0
				}
			);	
		}
	}
	
	interrupt = function(p) {
		if(p.image_index == 12) {
			p.fsm.transition(p,p.actions.idle);
			return true;
		}
		return false;
	}
	
}

function as_aim_basic_cast() : as_grounded() constructor {
	
	init = function(p) {
		p.sprite_index = sp_aim_basic_cast;
		p.state = states.aim_basic_cast;
		p.x_vel = 0;
		instance_create_layer(
			p.x+(p.aim_basic_cast_offset_x * p.image_xscale),
			p.y+p.aim_basic_cast_offset_y,
			"l_player2",
			o_Player_Arm,
			{ xscale: p.image_xscale }
		);
	}
	
	interrupt = function(p) {
		if(keyboard_check_released(vk_space)) {
			p.fsm.transition(p,p.actions.idle);
			return true;
		}
		return false;
	}
	
	_exit = function(p) {
		instance_deactivate_layer("l_player2");	
		
		
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
		if(keyboard_check(ord("A"))) {
			p.image_xscale = -1;
			p.x_vel = -4;
		} else if(keyboard_check(ord("D"))) {
			p.image_xscale = 1;
			p.x_vel = 4;
		}
		if(keyboard_check(ord("S"))) {
			p.y_vel += 2;	
		}
		if((p.x_vel > 4 && p.image_xscale = 1) || (p.x_vel < -4 && p.image_xscale = -1)) {
			p.x_vel -= 0.5 * p.image_xscale;
		}
	}
	
	interrupt = function(p) {
		if(keyboard_check_pressed(ord("W")) && p.wall_jump) {
			if(sc_is_colliding_wall() == "left" && keyboard_check(ord("D"))) {
				p.fsm.transition(p,p.actions.wall_jump);
				return true;
			} else if(sc_is_colliding_wall() == "right" && keyboard_check(ord("A"))) {
				p.fsm.transition(p,p.actions.wall_jump);
				return true;
			}
		}
		if(keyboard_check_pressed(ord("W")) && p.double_jump) {
			p.double_jump = false;
			p.fsm.transition(p,p.actions.double_jump);
			return true;
		} else if(mouse_check_button_pressed(mb_left)) {
			p.fsm.transition(p,p.actions.air_basic_cast);
			return true;
		}
		return false;
	}

}

function as_wall_jump() : as_airbourne() constructor {

	init = function(p) {
		p.sprite_index = sp_wall_jump;
	}
	
	step = function(p) {
		p.wall_jump = false;
	}
	
	interrupt = function(p) {
		if(!p.wall_jump) {
			p.fsm.transition(p,p.actions.double_jump);
			return true;
		}
		return false;
	}
	
	

}