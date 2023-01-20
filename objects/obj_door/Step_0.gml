/// @description 

var door_offset_target = 0;
if (open) {
	door_offset_target = 64;
	if (door_offset == door_offset_target) {
		x = -1000;
		y = -1000;
	}
} else {
	x = open_door.x;
	y = open_door.y;
} 
door_offset += sign(door_offset_target-door_offset);


