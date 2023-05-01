/// @description Insert description here
// You can write your code in this editor
active_frames = 50;
active = true;

image_angle = angle;

x_vel = 10 * dcos(angle) * xscale;
y_vel = 10 * dsin(angle) * xscale * -1;

initial_x = x;
initial_y = y;

hitbox = sc_hitbox_create(5,1,0,0,1000);
hitbox.image_angle = angle;