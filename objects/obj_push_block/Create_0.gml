/// @description 

event_inherited();



pushed = false;
push_direction = 0;
push_speed = 4;
push_target_x = x;
push_target_y = y;
push_x = 0;
push_y = 0;

function push(trigger) {
	if (pushed == true) return;
	pushed = true;
	//var dir = point_direction(obj_player.x,obj_player.y,x+32,y+32) + 45;
	//dir = dir div 90;
	var can_push_x = true;
	var can_push_y = true;
	if (place_meeting(x-1,y,obj_block) || place_meeting(x+1,y,obj_block)) {
		can_push_x = false;	
	}
	if (place_meeting(x,y-1,obj_block) || place_meeting(x,y+1,obj_block)) {
		can_push_y = false;
	}
	if (can_push_x) {
		// on left or right side
		if (trigger.x < x+32) {
			push_direction = 0;
		} else {
			push_direction = 180;	
		}
	}
	if (can_push_y) {
		if (trigger.y < y+32) {
			push_direction = 270;
		} else {
			push_direction = 90;
		}
	}
	push_x = lengthdir_x(1,push_direction);
	push_y = lengthdir_y(1,push_direction);
	push_target_x = x + push_x * 128;
	push_target_y = y + push_y * 128;
}