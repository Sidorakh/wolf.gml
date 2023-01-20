/// @description 


var key_left = vk_left;
var key_right = vk_right;
var key_up = vk_up;
var key_down = vk_down;
var key_strafe_left = ord("Z");
var key_strafe_right = ord("C");
var key_interact = vk_space;

var _lr = keyboard_check(key_left) - keyboard_check(key_right);
var _zc = keyboard_check(key_strafe_left) - keyboard_check(key_strafe_right);
angle += _lr*5;


var _ud = keyboard_check(key_up) - keyboard_check(key_down);

if (true) {

	if (abs(_ud)) {
		spd += _ud;
		spd = clamp(spd,-maxspd,maxspd);
	} else {
		spd -= sign(spd);	
	}
	if (abs(_zc)) {
		strafespd += _zc;
		strafespd = clamp(strafespd,-maxspd,maxspd);
	} else {
		strafespd -= sign(strafespd);
	}
	var fx = lengthdir_x(sign(spd),angle);
	var fy = lengthdir_y(sign(spd),angle);

	repeat (abs(spd)) {
		if (!place_meeting(x+fx,y+fy,obj_block)) {
			x += fx;
			y += fy;
		} else {
			if (!place_meeting(x+fx,y,obj_block)) {
				x += fx;
			}
			if (!place_meeting(x,y+fy,obj_block)) {
				y += fy;
			}
		}
	}

	var sx = lengthdir_x(sign(strafespd),angle+90);	
	var sy = lengthdir_y(sign(strafespd),angle+90);
	repeat (abs(strafespd)) {
		if (!place_meeting(x+sx,y+sy,obj_block)) {
			x += sx;
			y += sy;
		} else {
			if (!place_meeting(x+sx,y,obj_block)) {
				x += sx;
			}
			if (!place_meeting(x,y+sy,obj_block)) {
				y += sy;
			}
		}
	}
}

var dx = lengthdir_x(1,angle);
var dy = lengthdir_y(1,angle);

if (keyboard_check(key_interact)) {
	var inst = instance_place(x+dx,y+dy,obj_push_block);
	show_debug_message(inst);
	if (inst != noone) {
		with (inst) {
			push(other.id)
		}
	}
}

// doors
if (keyboard_check_pressed(key_interact)) {
	var dist = 32;
	var inst = instance_place(x+dx*dist,y+dy*dist,obj_door);
	if (inst) {
		inst.use();
	} else {
		inst = instance_place(x+dx*dist,y+dy*dist,obj_door_open);
		if (inst && !place_meeting(x,y,inst)) {
			inst.use();
		}
	}
}

var matrix = matrix_build_lookat(x,y,height,x+dx,y+dy,height,0,0,-1);
camera_set_view_mat(cam,matrix);